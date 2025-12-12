unit frmwebsteam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.IOUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Winapi.WebView2,
  Winapi.ActiveX, Vcl.Edge, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, IniFiles, ShellAPI, System.NetEncoding, EPaswd, TlHelp32;

type
  TFormwebsteam = class(TForm)
    EdgeBrowser1: TEdgeBrowser;
    Edit1: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn4: TBitBtn;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Panel6: TPanel;
    Memo1: TMemo;
    Panel7: TPanel;
    BitBtn5: TBitBtn;
    Panel8: TPanel;
    Memo2: TMemo;
    Panel9: TPanel;
    BitBtn6: TBitBtn;
    Panel10: TPanel;
    procedure EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
      AResult: HRESULT; const AResultObjectAsJson: string);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);


  private
    { Private declarations }
    FParamID: string; // Guarda o ID temporariamente

  public
    { Public declarations }
  end;

var
  Formwebsteam: TFormwebsteam;

implementation

{$R *.dfm}

uses Unit1, frmsteam, frmadbat, frmconfig;

//desembaralha pass
function DecodeSenha(const SenhaEnc: string): string;
var
  Tmp: string;
  i: Integer;
begin
  Tmp := TNetEncoding.Base64.Decode(SenhaEnc);
  Result := '';
  for i := 1 to Length(Tmp) do
    Result := Result + Chr(Ord(Tmp[i]) xor $5A);
end;

procedure TFormwebsteam.BitBtn1Click(Sender: TObject);
var
  URL: string;
  PosID, PosAmp: Integer;
begin
  URL := Trim(Edit1.Text);

  PosID := Pos('?id=', URL);
  if PosID = 0 then
  begin
    ShowMessage('Por favor, selecione um mod primeiro.');
    Exit;
  end;

  FParamID := Copy(URL, PosID + Length('?id='), Length(URL));

  PosAmp := Pos('&', FParamID);
  if PosAmp > 0 then
    FParamID := Copy(FParamID, 1, PosAmp - 1);

  if FParamID = '' then
  begin
    ShowMessage('Por favor, selecione um mod primeiro.');
    Exit;
  end;

  if Pos(FParamID, Memo1.Lines.Text) > 0 then
  begin
    ShowMessage('Este mod já foi selecionado para ser baixado.');
    Exit;
  end;

  // Executa script JS para pegar o título
  EdgeBrowser1.ExecuteScript('document.title');
end;

//PROCESSO PARA ENCERRAR MONITOR QUE BUSTA ATT DE MOD ANTES DE BAIXAR MOD
function GetProcessCmdLine(ProcessID: DWORD): string;
var
  Cmd, TempFile: string;
  Output: TStringList;
  AnsiCmd: AnsiString;
begin
  Result := '';
  TempFile := IncludeTrailingPathDelimiter(GetEnvironmentVariable('TEMP')) + 'cmdline.txt';
  if FileExists(TempFile) then DeleteFile(TempFile);

  Cmd := Format(
    'powershell -command "Get-CimInstance Win32_Process -Filter ''ProcessId = %d'' | Select-Object -ExpandProperty CommandLine"',
    [ProcessID]);

  AnsiCmd := AnsiString(Cmd + ' > "' + TempFile + '"');
  WinExec(PAnsiChar(AnsiCmd), SW_HIDE);
  Sleep(1500);

  if FileExists(TempFile) then
  begin
    Output := TStringList.Create;
    try
      Output.LoadFromFile(TempFile);
      if Output.Count > 0 then
        Result := Output.Text.Trim;
    finally
      Output.Free;
    end;
    DeleteFile(TempFile);
  end;
end;

procedure EncerrarMonitorSteam;
var
  Snapshot: THandle;
  ProcEntry: TProcessEntry32;
  CmdLine, LockPath: string;
  hProc: THandle;
begin
  LockPath := GetEnvironmentVariable('TEMP') + '\SCmdHidden\monitor.lock';

  if FileExists(LockPath) then
  begin
    Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if Snapshot = INVALID_HANDLE_VALUE then Exit;

    ProcEntry.dwSize := SizeOf(TProcessEntry32);
    if Process32First(Snapshot, ProcEntry) then
    begin
      repeat
        if SameText(ExtractFileName(ProcEntry.szExeFile), 'cmd.exe') then
        begin
          CmdLine := GetProcessCmdLine(ProcEntry.th32ProcessID);
          if CmdLine <> '' then
          begin
            if Pos('umd.bat', LowerCase(CmdLine)) > 0 then
            begin
              hProc := OpenProcess(PROCESS_TERMINATE, False, ProcEntry.th32ProcessID);
              if hProc <> 0 then
              begin
                TerminateProcess(hProc, 0);
                CloseHandle(hProc);
                Sleep(2000);
              end;
            end;
          end;
        end;
      until not Process32Next(Snapshot, ProcEntry);
    end;
    CloseHandle(Snapshot);

    DeleteFile(PChar(LockPath));
    Sleep(8000);
  end;
end;


procedure TFormwebsteam.BitBtn2Click(Sender: TObject);
var
  Ini: TIniFile;
  SteamCmdPath, SteamLoginEnc, SteamSenhaEnc, SteamLogin, SteamSenha: string;
  BatFile, ScriptFile, Line, ModID, BackupFile: string;
  i, PosSep: Integer;
  Bat, Script: TStringList;
begin
  EncerrarMonitorSteam; // Encerra monitor antes de baixar

  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\Config.ini');
  try
    SteamCmdPath := Ini.ReadString('STEAM', 'steamcmdexe', '');
    SteamLoginEnc := Ini.ReadString('STEAM', 'login', '');
    SteamSenhaEnc := Ini.ReadString('STEAM', 'senha', '');
  finally
    Ini.Free;
  end;

  SteamLogin := DecodeSenha(SteamLoginEnc);
  SteamSenha := DecodeSenha(SteamSenhaEnc);

  if (SteamCmdPath = '') or (SteamLogin = '') or (SteamSenha = '') then
  begin
    ShowMessage('SteamCMD e credenciais Steam devem estar definidas.');
    Exit;
  end;

  BackupFile := ExtractFileDir(SteamCmdPath) + '\listamod.txt';
  Memo1.Lines.SaveToFile(BackupFile);

  // Arquivos temporários
  ScriptFile := ExtractFileDir(SteamCmdPath) + '\download_mods.txt';
  BatFile := ExtractFileDir(SteamCmdPath) + '\startdownload.bat';

  // Cria o script steamcmd
  Script := TStringList.Create;
  try
    Script.Add('login ' + SteamLogin + ' ' + SteamSenha);

    for i := 0 to Memo1.Lines.Count - 1 do
    begin
      Line := Trim(Memo1.Lines[i]);
      if Line = '' then Continue;

      PosSep := Pos(' - ', Line);
      if PosSep > 0 then
        ModID := Trim(Copy(Line, 1, PosSep - 1))
      else
        ModID := Line;

      if ModID <> '' then
        Script.Add('workshop_download_item 221100 ' + ModID + ' validate');
    end;

    Script.Add('quit');
    Script.SaveToFile(ScriptFile);
  finally
    Script.Free;
  end;

  // Cria o BAT para chamar o steamcmd com o script
  Bat := TStringList.Create;
  try
    Bat.Add('@echo off');
    Bat.Add('cd /d "' + ExtractFileDir(SteamCmdPath) + '"');
    Bat.Add('"' + SteamCmdPath + '" +runscript "' + ScriptFile + '"');
    Bat.Add('pause');
    Bat.Add('del "%~f0"');
    Bat.SaveToFile(BatFile);
  finally
    Bat.Free;
  end;

  ShellExecute(0, 'open', PWideChar(BatFile), nil, nil, SW_SHOWNORMAL);
end;

//FUNCAO PARA VERIFICAR MOD BAIXADO
function VerificarModsNaoBaixados(ModList: TStrings): TStringList;
var
  i, PosSeparador: Integer;
  ModID, PastaMod, CaminhoMeta, NomeOriginal: string;
begin
  Result := TStringList.Create;

  for i := 0 to ModList.Count - 1 do
  begin
    NomeOriginal := Trim(ModList[i]);
    ModID := NomeOriginal;

    if ModID = '' then Continue;

    PosSeparador := Pos('-', ModID);
    if PosSeparador > 0 then
      ModID := Trim(Copy(ModID, 1, PosSeparador - 1));

    PastaMod := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
                'Steamcmd\steamapps\workshop\content\221100\' + ModID;
    CaminhoMeta := IncludeTrailingPathDelimiter(PastaMod) + 'meta.cpp';

    if not FileExists(CaminhoMeta) then
      Result.Add(NomeOriginal);
  end;
end;

procedure TFormwebsteam.BitBtn3Click(Sender: TObject);
var
  ModsNaoBaixados: TStringList;
  Resp: Integer;
begin
  ModsNaoBaixados := VerificarModsNaoBaixados(formWebSteam.Memo1.Lines);
  try
    if ModsNaoBaixados.Count > 0 then
    begin
      Resp := Application.MessageBox(
        PChar('Os seguintes mods NÃO estão baixados:' + sLineBreak +
              ModsNaoBaixados.Text + sLineBreak +
              'Deseja continuar mesmo assim?'),
        'Atenção',
        MB_YESNO or MB_ICONWARNING
      );

      if Resp = IDNO then
      begin
        ShowMessage('Operação cancelada pelo usuário.');
        Exit;  // Saída antecipada segura, pois o try libera apenas ModsNaoBaixados
      end;
    end;

    // Aqui só criamos o form se o usuário não cancelou
    Application.CreateForm(Tfrmaddbat, frmaddbat);
    try
      frmaddbat.Tag := 1;
      frmaddbat.ShowModal;
    finally
      frmaddbat.Free;
    end;

  finally
    ModsNaoBaixados.Free;
  end;
end;

procedure TFormwebsteam.BitBtn4Click(Sender: TObject);
begin
Close;
end;

procedure TFormwebsteam.BitBtn5Click(Sender: TObject);
var
  URL, ParamID: string;
  PosID, PosAmp: Integer;
  i: Integer;
begin
  URL := Trim(Edit1.Text);

  PosID := Pos('?id=', URL);
  if (PosID = 0) then
  begin
    ShowMessage('Acesse a página do mod para removê-lo ou selecione o código desejado na lista acima e clique em DELETE.');
    Exit;
  end;

  ParamID := Copy(URL, PosID + Length('?id='), Length(URL));
  PosAmp := Pos('&', ParamID);
  if PosAmp > 0 then
    ParamID := Copy(ParamID, 1, PosAmp - 1);

  if ParamID = '' then
  begin
    ShowMessage('Nenhum mod válido selecionado para remover.');
    Exit;
  end;

  // Percorrer linhas para remover
  for i := Memo1.Lines.Count - 1 downto 0 do
  begin
    if Pos(ParamID, Memo1.Lines[i]) > 0 then
      Memo1.Lines.Delete(i);
  end;

  ShowMessage('O mod da página atual foi removido da lista.');
end;


procedure TFormwebsteam.BitBtn6Click(Sender: TObject);
var
  SteamCmdPath, BackupFile: string;
  Ini: TIniFile;
begin
  // Lê o SteamCmdPath do Config.ini
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\Config.ini');
  try
    SteamCmdPath := Ini.ReadString('STEAM', 'steamcmdexe', '');
  finally
    Ini.Free;
  end;

  // Monta caminho completo do backup
  BackupFile := ExtractFileDir(SteamCmdPath) + '\listamod.txt';

  // Verifica se arquivo existe
  if not FileExists(BackupFile) then
  begin
    ShowMessage('Arquivo "listamod.txt" não encontrado!');
    Exit;
  end;

  // Carrega o backup no Memo1
  Memo1.Lines.LoadFromFile(BackupFile);

  // Atualiza quantidade no Label2
  Panel10.Caption := ' Listados: ' + IntToStr(Memo1.Lines.Count);
end;

procedure TFormwebsteam.EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
  AResult: HRESULT; const AResultObjectAsJson: string);
var
  ModTitle: string;
  PosSep: Integer;
begin
  if AResult = S_OK then
  begin
    ModTitle := AResultObjectAsJson;

    // Remove aspas extras do JSON
    if (Length(ModTitle) > 2) and (ModTitle[1] = '"') and (ModTitle[Length(ModTitle)] = '"') then
      ModTitle := Copy(ModTitle, 2, Length(ModTitle) - 2);

    // Procura a posição de '::'
    PosSep := Pos('::', ModTitle);
    if PosSep > 0 then
    begin
      ModTitle := Copy(ModTitle, PosSep + 2, Length(ModTitle));
      ModTitle := Trim(ModTitle);
    end;

    // Adiciona na próxima linha sem risco de linha vazia
    Memo1.Lines.Add(FParamID + ' - ' + ModTitle);

    Panel10.Caption := ' Listados: ' + IntToStr(Memo1.Lines.Count);
  end;
end;

procedure TFormwebsteam.EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
  IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
begin
edit1.Text := EdgeBrowser1.LocationURL;
end;

procedure TFormwebsteam.Edit1Change(Sender: TObject);
begin
 if Pos('?id=', Edit1.Text) > 0 then
    bitbtn1.Enabled := True
  else
    bitbtn1.Enabled := False;
end;

procedure TFormwebsteam.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.EvFocus.ChangeColor := true;
    Form1.EvFocus.ChangeFont := true;
end;

procedure TFormwebsteam.FormCreate(Sender: TObject);
begin
  Form1.EvFocus.ChangeColor := false;
  Form1.EvFocus.ChangeFont := false;
end;

procedure TFormwebsteam.FormShow(Sender: TObject);
begin
  EdgeBrowser1.Navigate('https://steamcommunity.com/app/221100/workshop/');
end;

procedure TFormwebsteam.Memo1Change(Sender: TObject);
begin
  if memo1.Text <> '' then
    begin
      bitbtn5.Enabled := true;
      bitbtn2.Enabled := true;
      bitbtn3.Enabled := true;
      end
      else
      begin
      bitbtn5.Enabled := false;
      bitbtn2.Enabled := false;
      bitbtn3.Enabled := false;
      end;
end;

procedure TFormwebsteam.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LineIndex: Integer;
begin
  if Key = VK_DELETE then
  begin
    // Descobre a linha onde está o cursor
    LineIndex := Memo1.Perform(EM_LINEFROMCHAR, Memo1.SelStart, 0);

    if (LineIndex >= 0) and (LineIndex < Memo1.Lines.Count) then
    begin
      Memo1.ReadOnly := False;  // Permite edição temporariamente
      Memo1.Lines.Delete(LineIndex);  // Remove a linha inteira
      Memo1.ReadOnly := True;   // Volta pra só leitura

      Panel10.Caption := ' Listados: ' + IntToStr(Memo1.Lines.Count);

      Key := 0;  // Bloqueia propagação
    end;
  end
  else
    Key := 0; // Bloqueia qualquer outra tecla
end;

procedure TFormwebsteam.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
Key := #0; // Bloqueia tudo
end;

end.
