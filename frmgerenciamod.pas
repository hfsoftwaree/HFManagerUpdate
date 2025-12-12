unit frmgerenciamod;

interface

uses
  Windows, ShellAPI, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus,
  Vcl.Grids, Data.DB, Vcl.DBGrids, EDBGrid, Datasnap.DBClient, System.StrUtils, System.IOUtils,Types;

type
  Tfrmgerenciarmod = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    StringGrid1: TEvDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Label4: TLabel;
    DBGrid1: TEvDBGrid;
    DBGrid2: TEvDBGrid;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    ClientDataSet2: TClientDataSet;
    ClientDataSet3: TClientDataSet;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Label5: TLabel;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure StringGrid1CellClick(Column: TColumn);
    procedure BitBtn4Click(Sender: TObject);
    procedure ListaModServidor(Servidor: Integer);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure ListaModBat(Servidor: Integer);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure StringGrid1TitleClick(Column: TColumn);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure BitBtn5Click(Sender: TObject);
    procedure DeletarModsteamcmd;
    procedure CarregarModSteamcmd;
    procedure DeletarModServidor;
    procedure ListaModServidor1;
    procedure RemoveModBat(ModsParaRemover: TStrings);
    procedure AbrirBatOpcao(const BatPath: string);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure CopiarModsSelecionados;
    function TemModSelecionado: Boolean;
    procedure BitBtn9Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmgerenciarmod: Tfrmgerenciarmod;

implementation

uses Unit1, frmwebsteam, frmadbat;

{$R *.dfm}

procedure Tfrmgerenciarmod.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure Tfrmgerenciarmod.BitBtn2Click(Sender: TObject);
var
  PastaBase: string;
begin
  // Caminho com base no EXE
  PastaBase := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
               'Steamcmd\steamapps\workshop\content\221100\';

  // Mostra o caminho real para ver se está certo
  //ShowMessage('Pasta calculada: ' + PastaBase);

  // Verifica se existe
  if not DirectoryExists(PastaBase) then
  begin
    ShowMessage('A pasta não foi encontrada:' + sLineBreak + PastaBase);
    Exit;
  end;

  if MessageDlg('Deseja ir para o diretório onde são baixados os mods da Steam?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ShellExecute(0, 'open', PChar(PastaBase), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure Tfrmgerenciarmod.BitBtn3Click(Sender: TObject);
var
  Ini: TIniFile;
  IniPath, ExePath, PastaExe, NomeServidor: string;
  Servidor: Integer;
begin
  if RadioGroup1.ItemIndex = -1 then
  begin
    ShowMessage('Selecione um servidor primeiro!');
    Exit;
  end;

  Servidor := RadioGroup1.ItemIndex + 1;
  NomeServidor := RadioGroup1.Items[RadioGroup1.ItemIndex]; // Aqui pegamos o nome certo

  IniPath := ExtractFilePath(Application.ExeName) + 'Config\Config.ini';
  Ini := TIniFile.Create(IniPath);
  try
    ExePath := Ini.ReadString('Servidor ' + IntToStr(Servidor), 'exe', '');

    if ExePath = '' then
    begin
      ShowMessage('Caminho do EXE do servidor "' + NomeServidor + '" não definido no INI.');
      Exit;
    end;

    PastaExe := ExtractFilePath(ExePath);

    if not DirectoryExists(PastaExe) then
    begin
      ShowMessage('Diretório do EXE não encontrado:' + sLineBreak + PastaExe);
      Exit;
    end;

    if MessageDlg('Deseja abrir o diretório do servidor "' + NomeServidor + '"?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ShellExecute(0, 'open', PChar(PastaExe), nil, nil, SW_SHOWNORMAL);
    end;

  finally
    Ini.Free;
  end;
end;

procedure Tfrmgerenciarmod.BitBtn4Click(Sender: TObject);
var
  Ini: TIniFile;
  IniPath, ExePath, PastaExe, NomeServidor: string;
  Servidor: Integer;
begin
  if RadioGroup1.ItemIndex = -1 then
  begin
    ShowMessage('Selecione um servidor primeiro!');
    Exit;
  end;

  Servidor := RadioGroup1.ItemIndex + 1;
  NomeServidor := RadioGroup1.Items[RadioGroup1.ItemIndex]; // Aqui pegamos o nome certo

  IniPath := ExtractFilePath(Application.ExeName) + 'Config\Config.ini';
  Ini := TIniFile.Create(IniPath);
  try
    ExePath := Ini.ReadString('Servidor ' + IntToStr(Servidor), 'start', '');

    if ExePath = '' then
    begin
      ShowMessage('Caminho do BAT do servidor "' + NomeServidor + '" não definido no INI.');
      Exit;
    end;

    PastaExe := ExtractFilePath(ExePath);

    if not DirectoryExists(PastaExe) then
    begin
      ShowMessage('Diretório do BAT não encontrado:' + sLineBreak + PastaExe);
      Exit;
    end;

    if MessageDlg('Deseja abrir o diretório do servidor "' + NomeServidor + '"?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ShellExecute(0, 'open', PChar(PastaExe), nil, nil, SW_SHOWNORMAL);
    end;

  finally
    Ini.Free;
  end;
end;

//Deletar MOD pasta steamcmd
procedure Tfrmgerenciarmod.DeletarModsteamcmd;
var
  PastaBase, PastaMod, IDSteam: string;
  Deletados: Integer;
begin
  PastaBase := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
               'Steamcmd\steamapps\workshop\content\221100\';

  Deletados := 0;

  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      if ClientDataSet1.FieldByName('Selecionado').AsBoolean then
      begin
        IDSteam := ClientDataSet1.FieldByName('IDSteam').AsString;

        if IDSteam <> '' then
        begin
          PastaMod := IncludeTrailingPathDelimiter(PastaBase + IDSteam);

          if TDirectory.Exists(PastaMod) then
          begin
            try
              TDirectory.Delete(PastaMod, True); // Apaga pasta e tudo dentro
              Inc(Deletados);
            except
              on E: Exception do
                ShowMessage('Erro ao deletar: ' + PastaMod + sLineBreak + E.Message);
            end;
          end;
        end;
      end;

      ClientDataSet1.Next;
    end;

  finally
    ClientDataSet1.EnableControls;
  end;

  ShowMessage('Mods deletados: ' + IntToStr(Deletados));
end;

//Deletar mod servidor
procedure Tfrmgerenciarmod.DeletarModServidor;
var
  Servidor: Integer;
  Ini: TIniFile;
  IniPath, ExePath, PastaServidor, PastaKeys, IDSteam: string;
  Pastas: TStringDynArray;
  PastaMod, MetaPath, PastaKeysMod: string;
  MetaFile: TStringList;
  Linha, IDMeta: string;
  Keys: TStringDynArray;
  I, J, K: Integer;
  Deletados: Integer;
  Encontrado: Boolean;
  LogFile: TStringList;
  NomeKey, KeyNoServidor: string;
  LogDir, LogPath: string;
begin
  Servidor := RadioGroup1.ItemIndex + 1;


  IniPath := ExtractFilePath(Application.ExeName) + 'Config\Config.ini';
  Ini := TIniFile.Create(IniPath);
  LogFile := TStringList.Create;
  try
    ExePath := Ini.ReadString('Servidor ' + IntToStr(Servidor), 'exe', '');
    if ExePath = '' then
    begin
      ShowMessage('Caminho do servidor não definido no INI!');
      Exit;
    end;

    PastaServidor := ExtractFileDir(ExePath);
    PastaKeys := IncludeTrailingPathDelimiter(PastaServidor) + 'Keys';

    if not DirectoryExists(PastaServidor) then
    begin
      ShowMessage('Pasta do servidor não encontrada: ' + PastaServidor);
      Exit;
    end;

    if not DirectoryExists(PastaKeys) then
    begin
      ShowMessage('Pasta de Keys não encontrada: ' + PastaKeys);
      Exit;
    end;

    Deletados := 0;
    LogFile.Add('=== LOG DE EXCLUSÃO DE MODS ===');
    LogFile.Add('Data/Hora: ' + DateTimeToStr(Now));
    LogFile.Add('');

    ClientDataSet2.DisableControls;
    try
      ClientDataSet2.First;
      while not ClientDataSet2.Eof do
      begin
        if ClientDataSet2.FieldByName('Selecionado').AsBoolean then
        begin
          IDSteam := ClientDataSet2.FieldByName('IDSteam').AsString;

          Pastas := TDirectory.GetDirectories(PastaServidor, '@*', TSearchOption.soTopDirectoryOnly);

          Encontrado := False;

          for I := 0 to High(Pastas) do
          begin
            PastaMod := Pastas[I];
            MetaPath := IncludeTrailingPathDelimiter(PastaMod) + 'meta.cpp';

            if FileExists(MetaPath) then
            begin
              MetaFile := TStringList.Create;
              try
                MetaFile.LoadFromFile(MetaPath);
                IDMeta := '';

                for J := 0 to MetaFile.Count - 1 do
                begin
                  Linha := Trim(MetaFile[J]);
                  if Pos('publishedid =', Linha) > 0 then
                  begin
                    IDMeta := StringReplace(Linha, 'publishedid =', '', [rfIgnoreCase]);
                    IDMeta := StringReplace(IDMeta, ';', '', [rfReplaceAll]);
                    IDMeta := Trim(IDMeta);
                    Break;
                  end;
                end;

                if IDMeta = IDSteam then
                begin
                  LogFile.Add('Mod deletado: ' + ExtractFileName(PastaMod));

                  // Verificar keys → não deletar, só avisar
                  PastaKeysMod := IncludeTrailingPathDelimiter(PastaMod) + 'keys';

                  if DirectoryExists(PastaKeysMod) then
                  begin
                    Keys := TDirectory.GetFiles(PastaKeysMod, '*.bikey', TSearchOption.soTopDirectoryOnly);
                    for K := 0 to High(Keys) do
                    begin
                      NomeKey := ExtractFileName(Keys[K]);
                      KeyNoServidor := IncludeTrailingPathDelimiter(PastaKeys) + NomeKey;

                      if FileExists(KeyNoServidor) then
                      begin
                        LogFile.Add('  Atenção: Key detectada no servidor');
                        LogFile.Add('  Nome da Key: ' + NomeKey);
                        LogFile.Add('  Caminho: ' + KeyNoServidor);
                        LogFile.Add('  >>> Verifique manualmente se outros mods usam esta key antes de remover!');
                        LogFile.Add('');
                      end;
                    end;
                  end;

                  // Deleta pasta do mod
                  TDirectory.Delete(PastaMod, True);
                  Inc(Deletados);
                  Encontrado := True;
                  Break; // achou, sai loop pastas
                end;

              finally
                MetaFile.Free;
              end;
            end;
          end;

          if not Encontrado then
          begin
            LogFile.Add('Mod com IDSteam ' + IDSteam + ' não encontrado na pasta do servidor.');
            LogFile.Add('');
          end;
        end;

        ClientDataSet2.Next;
      end;
    finally
      ClientDataSet2.EnableControls;
    end;


    LogDir := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'log';
    if not DirectoryExists(LogDir) then
      ForceDirectories(LogDir);

    LogPath := LogDir + PathDelim + 'log_delecao_mods_' +
               FormatDateTime('yyyymmdd_hhnnss', Now) + '.txt';

    LogFile.SaveToFile(LogPath);

    ShowMessage('Mods do servidor deletados: ' + IntToStr(Deletados) + sLineBreak +
      'Um log detalhado foi salvo em: ' + LogPath + sLineBreak +
      'Verifique se deseja remover keys manualmente conforme indicado no log.');

    ShellExecute(0, 'open', PChar('notepad.exe'), PChar(LogPath), nil, SW_SHOWNORMAL);

  finally
    Ini.Free;
    LogFile.Free;
  end;
end;

//Listar mod servidor novamente apos delete
procedure Tfrmgerenciarmod.ListaModServidor1;
var
  Servidor: Integer;
  Ini: TIniFile;
  IniPath, ExePath, PastaServidor, ModPath, ModName, MetaFile, IDSteam: string;
  Pastas: TStringDynArray;
  I: Integer;
  MetaLines: TStringList;
  J: Integer;
begin
  Servidor := RadioGroup1.ItemIndex + 1;

  IniPath := ExtractFilePath(Application.ExeName) + 'Config\Config.ini';

  Ini := TIniFile.Create(IniPath);
  try
    ExePath := Ini.ReadString('Servidor ' + IntToStr(Servidor), 'exe', '');

    if not ClientDataSet2.Active then
    begin
      ClientDataSet2.FieldDefs.Clear;
      ClientDataSet2.FieldDefs.Add('Selecionado', ftBoolean);
      ClientDataSet2.FieldDefs.Add('NomeMod', ftString, 310);
      ClientDataSet2.FieldDefs.Add('IDSteam', ftString, 90);  // <-- Novo campo
      ClientDataSet2.CreateDataSet;
    end;

    if ExePath = '' then
    begin
      ClientDataSet2.DisableControls;
      try
        ClientDataSet2.EmptyDataSet;
      finally
        ClientDataSet2.EnableControls;
      end;
      Label3.Caption := 'MOD''s na pasta do Servidor: 0';
      ShowMessage('Caminho para os mod do servidor selecionado não definido. Verifique!');
      Exit;
    end;

    PastaServidor := ExtractFileDir(ExePath);

    if not DirectoryExists(PastaServidor) then
    begin
      ShowMessage('Pasta do servidor não encontrada: ' + PastaServidor);
      Exit;
    end;

    ClientDataSet2.DisableControls;
    try
      ClientDataSet2.EmptyDataSet;

      Pastas := TDirectory.GetDirectories(PastaServidor, '@*', TSearchOption.soTopDirectoryOnly);

      for I := 0 to High(Pastas) do
      begin
        ModPath := Pastas[I];
        ModName := ExtractFileName(ModPath);

        if LeftStr(ModName, 1) = '@' then
          ModName := Copy(ModName, 2, Length(ModName));

        // Caminho do arquivo meta.cpp
        MetaFile := IncludeTrailingPathDelimiter(ModPath) + 'meta.cpp';
        IDSteam := '';

        if FileExists(MetaFile) then
        begin
          MetaLines := TStringList.Create;
          try
            MetaLines.LoadFromFile(MetaFile);
            for J := 0 to MetaLines.Count - 1 do
            begin
              if Pos('publishedid', LowerCase(MetaLines[J])) > 0 then
              begin
                // Exemplo de linha: publishedid = 2276010135;
                IDSteam := Trim(MetaLines[J]);
                IDSteam := StringReplace(IDSteam, 'publishedid', '', [rfIgnoreCase]);
                IDSteam := StringReplace(IDSteam, '=', '', []);
                IDSteam := StringReplace(IDSteam, ';', '', []);
                IDSteam := Trim(IDSteam);
                Break;
              end;
            end;
          finally
            MetaLines.Free;
          end;
        end;

        ClientDataSet2.Append;
        ClientDataSet2.FieldByName('Selecionado').AsBoolean := False;
        ClientDataSet2.FieldByName('NomeMod').AsString := ModName;
        ClientDataSet2.FieldByName('IDSteam').AsString := IDSteam;  // <-- Preenche novo campo
        ClientDataSet2.Post;
      end;
    finally
      ClientDataSet2.EnableControls;
    end;

    // Cria índices físicos (se não existirem)
    if ClientDataSet2.IndexDefs.IndexOf('Idx_NomeMod_ASC') < 0 then
      ClientDataSet2.AddIndex('Idx_NomeMod_ASC', 'NomeMod', []);
    if ClientDataSet2.IndexDefs.IndexOf('Idx_NomeMod_DESC') < 0 then
      ClientDataSet2.AddIndex('Idx_NomeMod_DESC', 'NomeMod', [ixDescending]);

    ClientDataSet2.IndexName := 'Idx_NomeMod_ASC';

    Label3.Caption := 'MOD''s na pasta do Servidor: ' + IntToStr(ClientDataSet2.RecordCount);

  finally
    Ini.Free;
  end;
end;

procedure Tfrmgerenciarmod.Panel1Click(Sender: TObject);
begin

end;

// Remove mod do BAT
procedure Tfrmgerenciarmod.RemoveModBat(ModsParaRemover: TStrings);
var
  Ini: TIniFile;
  IniPath, BatPath, Linha: string;
  Linhas: TStringList;
  I, J: Integer;
  ModName, Param: string;
  ModEncontrado: Boolean;
  ModsNaoEncontrados: TStringList;
begin
  IniPath := ExtractFilePath(Application.ExeName) + 'Config\Config.ini';
  Ini := TIniFile.Create(IniPath);
  try
    BatPath := Ini.ReadString('Servidor ' + IntToStr(RadioGroup1.ItemIndex + 1), 'Start', '');
  finally
    Ini.Free;
  end;

  if (BatPath = '') or (not FileExists(BatPath)) then
  begin
    ShowMessage('Arquivo .bat não encontrado ou não configurado.');
    Exit;
  end;

  Linhas := TStringList.Create;
  ModsNaoEncontrados := TStringList.Create;
  try
    Linhas.LoadFromFile(BatPath);

    for I := 0 to Linhas.Count - 1 do
    begin
      Linha := Linhas[I];

      // Só mexe se for linha com -mod= ou -servermod=
      if (Pos('-mod=', Linha) > 0) or (Pos('-servermod=', Linha) > 0) then
      begin
        for J := 0 to ModsParaRemover.Count - 1 do
        begin
          ModName := Copy(ModsParaRemover[J], 1, Pos('|', ModsParaRemover[J]) - 1);
          if ModName = '' then
            ModName := ModsParaRemover[J];

          Param := ';@' + ModName;
          ModEncontrado := False;

          if Pos(Param, Linha) > 0 then
          begin
            Linha := StringReplace(Linha, Param, '', [rfReplaceAll, rfIgnoreCase]);
            ModEncontrado := True;
          end
          else if Pos('@' + ModName, Linha) > 0 then
          begin
            Linha := StringReplace(Linha, '@' + ModName, '', [rfReplaceAll, rfIgnoreCase]);
            ModEncontrado := True;
          end;

          if not ModEncontrado then
            ModsNaoEncontrados.Add(ModName);
        end;

        // Limpa ; extra
        while Pos(';;', Linha) > 0 do
          Linha := StringReplace(Linha, ';;', ';', [rfReplaceAll]);

        Linha := StringReplace(Linha, ';"', '"', [rfReplaceAll]);

        Linhas[I] := Linha; // Atualiza a linha modificada!
      end;
    end;

    Linhas.SaveToFile(BatPath);

    if ModsNaoEncontrados.Count > 0 then
      ShowMessage('Os seguintes mods não foram encontrados no BAT:' + sLineBreak + ModsNaoEncontrados.Text)
    else
      ShowMessage('Mods removidos com sucesso do BAT.');

    ListaModBat(RadioGroup1.ItemIndex + 1);

    if MessageDlg('BAT:' + sLineBreak +
    'Deseja abrir o BAT para conferência?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      AbrirBatOpcao(BatPath);
    end;

  finally
    Linhas.Free;
    ModsNaoEncontrados.Free;
  end;
end;


//Abre bat para conferencia
procedure Tfrmgerenciarmod.AbrirBatOpcao(const BatPath: string);
var
  F: TForm;
  BtnBloco, BtnNotepadPP, BtnVSCode, BtnAbrirPasta: TBitBtn;
  VSCodePath, NotepadPPPath, EditorPath: string;
  Resultado: Integer;
begin
  if not FileExists(BatPath) then
  begin
    ShowMessage('Arquivo BAT não encontrado.');
    Exit;
  end;

  NotepadPPPath := TPath.Combine('C:\Program Files\Notepad++', 'notepad++.exe');
  if not FileExists(NotepadPPPath) then
    NotepadPPPath := TPath.Combine('C:\Program Files (x86)\Notepad++', 'notepad++.exe');

  VSCodePath := TPath.Combine(GetEnvironmentVariable('LOCALAPPDATA'),
    'Programs\Microsoft VS Code\Code.exe');

  F := TForm.Create(nil);
  try
    F.Caption := 'Abrir BAT';
    F.Width := 320;
    F.Height := 280;
    F.Position := poScreenCenter;
    F.BorderStyle := bsDialog;

    BtnAbrirPasta := TBitBtn.Create(F);
    BtnAbrirPasta.Parent := F;
    BtnAbrirPasta.Caption := 'Abrir pasta do arquivo';
    BtnAbrirPasta.ModalResult := mrRetry;
    BtnAbrirPasta.Cursor := crHandPoint;
    BtnAbrirPasta.Height := 35;
    BtnAbrirPasta.Left := 50;
    BtnAbrirPasta.Top := 30;
    BtnAbrirPasta.Width := 220;

    BtnBloco := TBitBtn.Create(F);
    BtnBloco.Parent := F;
    BtnBloco.Caption := 'Abrir no Bloco de Notas';
    BtnBloco.ModalResult := mrYes;
    BtnBloco.Cursor := crHandPoint;
    BtnBloco.Height := 35;
    BtnBloco.Left := 50;
    BtnBloco.Top := 80;
    BtnBloco.Width := 220;

    if FileExists(NotepadPPPath) then
    begin
      BtnNotepadPP := TBitBtn.Create(F);
      BtnNotepadPP.Parent := F;
      BtnNotepadPP.Caption := 'Abrir no Notepad++';
      BtnNotepadPP.ModalResult := mrNo;
      BtnNotepadPP.Cursor := crHandPoint;
      BtnNotepadPP.Height := 35;
      BtnNotepadPP.Left := 50;
      BtnNotepadPP.Top := 130;
      BtnNotepadPP.Width := 220;
    end;

    if FileExists(VSCodePath) then
    begin
      BtnVSCode := TBitBtn.Create(F);
      BtnVSCode.Parent := F;
      BtnVSCode.Caption := 'Abrir no VSCode';
      BtnVSCode.ModalResult := mrOk;
      BtnVSCode.Cursor := crHandPoint;
      BtnVSCode.Height := 35;
      BtnVSCode.Left := 50;
      BtnVSCode.Top := 180;
      BtnVSCode.Width := 220;
    end;

    Resultado := F.ShowModal;

    case Resultado of
      mrYes:
        EditorPath := 'notepad.exe';
      mrNo:
        if FileExists(NotepadPPPath) then
          EditorPath := NotepadPPPath
        else
        begin
          ShowMessage('Notepad++ não encontrado.');
          Exit;
        end;
      mrOk:
        if FileExists(VSCodePath) then
          EditorPath := VSCodePath
        else
        begin
          ShowMessage('VSCode não encontrado.');
          Exit;
        end;
      mrRetry:
        begin
          ShellExecute(0, 'open', 'explorer.exe',
            PChar('/select,"' + BatPath + '"'), nil, SW_SHOWNORMAL);
          Exit;
        end;
    else
      Exit;
    end;

    if ShellExecute(0, 'open', PChar(EditorPath), PChar('"' + BatPath + '"'),
      nil, SW_SHOWNORMAL) <= 32 then
    begin
      ShowMessage('Falha ao abrir o editor.');
    end;

  finally
    F.Free;
  end;
end;



procedure Tfrmgerenciarmod.BitBtn5Click(Sender: TObject);
var
  TemSelecionadoSteamcmd, TemSelecionadoServidor: Boolean;
  ModsParaRemover: TStringList;
begin
  // ============================================================
  // Deletar mod steamcmd
  if ClientDataSet1.Active then
  begin
    ClientDataSet1.CheckBrowseMode;

    TemSelecionadoSteamcmd := False;
    ClientDataSet1.DisableControls;
    try
      ClientDataSet1.First;
      while not ClientDataSet1.Eof do
      begin
        if ClientDataSet1.FieldByName('Selecionado').AsBoolean then
        begin
          TemSelecionadoSteamcmd := True;
          Break;
        end;
        ClientDataSet1.Next;
      end;
    finally
      ClientDataSet1.EnableControls;
    end;

    if TemSelecionadoSteamcmd then
    begin
      if MessageDlg('Steamcmd:' + sLineBreak +
        'Tem certeza que deseja deletar da pasta do STEAMCMD os mods selecionados?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        DeletarModsteamcmd;
        CarregarModSteamcmd;
      end;
    end
    else
      ShowMessage('Steamcmd:' + sLineBreak + 'Nenhum mod foi selecionado!');
  end
  else
    ShowMessage('Steamcmd:' + sLineBreak + 'Nenhum mod carregado!');

  // ============================================================
  // Deletar mod servidor
  if RadioGroup1.ItemIndex <> -1 then
  begin
    if ClientDataSet2.Active then
    begin
      ClientDataSet2.CheckBrowseMode;

      TemSelecionadoServidor := False;
      ClientDataSet2.DisableControls;
      try
        ClientDataSet2.First;
        while not ClientDataSet2.Eof do
        begin
          if ClientDataSet2.FieldByName('Selecionado').AsBoolean then
          begin
            TemSelecionadoServidor := True;
            Break;
          end;
          ClientDataSet2.Next;
        end;
      finally
        ClientDataSet2.EnableControls;
      end;

      if TemSelecionadoServidor then
      begin
        if MessageDlg('Servidor:' + sLineBreak +
          'Tem certeza que deseja deletar da pasta do SERVIDOR os mods selecionados?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          DeletarModServidor;
          ListaModServidor1;
        end;
      end
      else
        ShowMessage('Servidor:' + sLineBreak + 'Nenhum mod foi selecionado!');
    end
    else
      ShowMessage('Servidor:' + sLineBreak + 'Nenhum mod carregado!');
  end
  else
    ShowMessage('Servidor:' + sLineBreak + 'Nenhum servidor selecionado. Verifique!');

  // ============================================================
  // Remove mod do BAT
  if RadioGroup1.ItemIndex <> -1 then
  begin
    ModsParaRemover := TStringList.Create;
    try
      ClientDataSet3.First;
      while not ClientDataSet3.Eof do
      begin
        if ClientDataSet3.FieldByName('Selecionado').AsBoolean then
          ModsParaRemover.Add(ClientDataSet3.FieldByName('NomeMod').AsString + '|' + ClientDataSet3.FieldByName('Tipo').AsString);
        ClientDataSet3.Next;
      end;

      if ModsParaRemover.Count > 0 then
      begin
        if MessageDlg('BAT:' + sLineBreak +
          'Tem certeza que deseja remover do BAT os mods selecionados?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          RemoveModBat(ModsParaRemover);
        end;
      end
      else
        ShowMessage('BAT:' + sLineBreak + 'Nenhum mod foi selecionado!');
    finally
      ModsParaRemover.Free;
    end;
  end
  else
    ShowMessage('BAT:' + sLineBreak + 'Nenhum servidor selecionado. Verifique!');
end;

procedure Tfrmgerenciarmod.BitBtn6Click(Sender: TObject);
var
  F: TForm;
  BtnBloco, BtnNotepadPP, BtnVSCode, BtnAbrirPasta: TBitBtn;
  VSCodePath, NotepadPPPath, CaminhoBat, CaminhoINI, Chave, EditorPath: string;
  Index, Resultado: Integer;
  Ini: TIniFile;
begin
  CaminhoINI := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Config\Config.ini');

  Index := RadioGroup1.ItemIndex;
  case Index of
    0: Chave := 'Servidor 1';
    1: Chave := 'Servidor 2';
    2: Chave := 'Servidor 3';
  else
    ShowMessage('Selecione um servidor primeiro!');
    Exit;
  end;

  Ini := TIniFile.Create(CaminhoINI);
  try
    CaminhoBat := Ini.ReadString(Chave, 'start', '');
  finally
    Ini.Free;
  end;

  if not FileExists(CaminhoBat) then
  begin
    ShowMessage('Arquivo BAT não encontrado.');
    Exit;
  end;

  NotepadPPPath := TPath.Combine('C:\Program Files\Notepad++', 'notepad++.exe');
  if not FileExists(NotepadPPPath) then
    NotepadPPPath := TPath.Combine('C:\Program Files (x86)\Notepad++', 'notepad++.exe');

  VSCodePath := TPath.Combine(GetEnvironmentVariable('LOCALAPPDATA'),
    'Programs\Microsoft VS Code\Code.exe');

  F := TForm.Create(nil);
  try
    F.Caption := 'Escolher ação';
    F.Width := 320;
    F.Height := 280;
    F.Position := poScreenCenter;
    F.BorderStyle := bsDialog;

    BtnAbrirPasta := TBitBtn.Create(F);
    BtnAbrirPasta.Parent := F;
    BtnAbrirPasta.Caption := 'Abrir pasta do arquivo';
    BtnAbrirPasta.ModalResult := mrRetry;
    BtnAbrirPasta.Cursor := crHandPoint;
    BtnAbrirPasta.Height := 35;
    BtnAbrirPasta.Left := 50;
    BtnAbrirPasta.Top := 30;
    BtnAbrirPasta.Width := 220;
    // Exemplo: carregar ícone (PNG ou ICO)
    if FileExists('Icones\folder.ico') then
      BtnAbrirPasta.Glyph.LoadFromFile('Icones\folder.ico');

    BtnBloco := TBitBtn.Create(F);
    BtnBloco.Parent := F;
    BtnBloco.Caption := 'Abrir no Bloco de Notas';
    BtnBloco.ModalResult := mrYes;
    BtnBloco.Cursor := crHandPoint;
    BtnBloco.Height := 35;
    BtnBloco.Left := 50;
    BtnBloco.Top := 80;
    BtnBloco.Width := 220;

    if FileExists(NotepadPPPath) then
    begin
      BtnNotepadPP := TBitBtn.Create(F);
      BtnNotepadPP.Parent := F;
      BtnNotepadPP.Caption := 'Abrir no Notepad++';
      BtnNotepadPP.ModalResult := mrNo;
      BtnNotepadPP.Cursor := crHandPoint;
      BtnNotepadPP.Height := 35;
      BtnNotepadPP.Left := 50;
      BtnNotepadPP.Top := 130;
      BtnNotepadPP.Width := 220;
    end;

    if FileExists(VSCodePath) then
    begin
      BtnVSCode := TBitBtn.Create(F);
      BtnVSCode.Parent := F;
      BtnVSCode.Caption := 'Abrir no VSCode';
      BtnVSCode.ModalResult := mrOk;
      BtnVSCode.Cursor := crHandPoint;
      BtnVSCode.Height := 35;
      BtnVSCode.Left := 50;
      BtnVSCode.Top := 180;
      BtnVSCode.Width := 220;
    end;

    Resultado := F.ShowModal;

    case Resultado of
      mrYes: EditorPath := 'notepad.exe';
      mrNo:
        if FileExists(NotepadPPPath) then
          EditorPath := NotepadPPPath
        else
        begin
          ShowMessage('Notepad++ não encontrado.');
          Exit;
        end;
      mrOk:
        if FileExists(VSCodePath) then
          EditorPath := VSCodePath
        else
        begin
          ShowMessage('VSCode não encontrado.');
          Exit;
        end;
      mrRetry:
        begin
          ShellExecute(0, 'open', 'explorer.exe',
            PChar('/select,"' + CaminhoBat + '"'), nil, SW_SHOWNORMAL);
          Exit;
        end;
    else
      Exit; // Cancelou
    end;

    if ShellExecute(0, 'open', PChar(EditorPath), PChar('"' + CaminhoBat + '"'),
      nil, SW_SHOWNORMAL) <= 32 then
    begin
      ShowMessage('Falha ao abrir o editor.');
    end;

  finally
    F.Free;
  end;
end;

procedure Tfrmgerenciarmod.BitBtn7Click(Sender: TObject);
var
  NomeModsBAT, Resultado: TStringList;
  NomeModServidor, DataHoraAtual: string;
  Found: Boolean;
  TotalNaoUsados: Integer;
  CaminhoPastaLog, CaminhoLog: string;
  EditorPath: string;
  NotepadPPPath, VSCodePath: string;
  ShellResult: HINST;
begin
  if RadioGroup1.ItemIndex = -1 then
  begin
    ShowMessage('Selecione o servidor!');
    Exit;
  end;

  NomeModsBAT := TStringList.Create;
  Resultado := TStringList.Create;
  TotalNaoUsados := 0;
  try
    Resultado.Add('HF Manager');
    Resultado.Add('==========');
    Resultado.Add('');

    ClientDataSet3.First;
    while not ClientDataSet3.Eof do
    begin
      NomeModsBAT.Add(LowerCase(ClientDataSet3.FieldByName('NomeMod').AsString));
      ClientDataSet3.Next;
    end;

    ClientDataSet2.First;
    while not ClientDataSet2.Eof do
    begin
      NomeModServidor := LowerCase(ClientDataSet2.FieldByName('NomeMod').AsString);
      Found := NomeModsBAT.IndexOf(NomeModServidor) >= 0;

      if not Found then
      begin
        Inc(TotalNaoUsados);
        Resultado.Add('Mod não usado no BAT: ' + ClientDataSet2.FieldByName('NomeMod').AsString);
        ClientDataSet2.Edit;
        ClientDataSet2.FieldByName('Selecionado').AsBoolean := True;
        ClientDataSet2.Post;
      end;

      ClientDataSet2.Next;
    end;

    if TotalNaoUsados > 0 then
    begin
      Resultado.Add('');
      Resultado.Add('Nota: Os Mod listados também foram marcados no grid caso deseja remove-los.');
      DataHoraAtual := FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);
      Resultado.Add(DataHoraAtual);

      CaminhoPastaLog := ExtractFilePath(Application.ExeName) + 'Log\';
      ForceDirectories(CaminhoPastaLog);
      CaminhoLog := CaminhoPastaLog + 'ModsNaoUsados.txt';

      Resultado.SaveToFile(CaminhoLog);

      // Tentativa 1: abrir com editor padrão do Windows
      ShellResult := ShellExecute(0, nil, PChar(CaminhoLog), nil, nil, SW_SHOWNORMAL);
      if ShellResult <= 32 then
      begin
        // Tentativa 2: abrir com Notepad++
        NotepadPPPath := TPath.Combine('C:\Program Files\Notepad++', 'notepad++.exe');
        if not FileExists(NotepadPPPath) then
          NotepadPPPath := TPath.Combine('C:\Program Files (x86)\Notepad++', 'notepad++.exe');

        if FileExists(NotepadPPPath) then
          ShellResult := ShellExecute(0, 'open', PChar(NotepadPPPath), PChar('"' + CaminhoLog + '"'), nil, SW_SHOWNORMAL)
        else
        begin
          // Tentativa 3: abrir com VSCode
          VSCodePath := TPath.Combine(GetEnvironmentVariable('LOCALAPPDATA'),
            'Programs\Microsoft VS Code\Code.exe');
          if FileExists(VSCodePath) then
            ShellResult := ShellExecute(0, 'open', PChar(VSCodePath), PChar('"' + CaminhoLog + '"'), nil, SW_SHOWNORMAL)
          else
          begin
            // Tentativa 4: abrir com bloco de notas padrão
            ShellResult := ShellExecute(0, 'open', 'notepad.exe', PChar('"' + CaminhoLog + '"'), nil, SW_SHOWNORMAL);
            if ShellResult <= 32 then
              ShowMessage('Não foi possível abrir o arquivo de log automaticamente.' + sLineBreak +
                          'O arquivo foi salvo em:' + sLineBreak + CaminhoLog);
          end;
        end;
      end;
    end
    else
    begin
      ShowMessage('Todos os mods da pasta do servidor estão em uso no BAT.');
    end;

    Label5.Visible := True;
    Label5.Caption := 'Total de Mod não usado no BAT: ' + IntToStr(TotalNaoUsados);

  finally
    NomeModsBAT.Free;
    Resultado.Free;
  end;
end;

//Copia mod selecionado na pasta steam para o servidor desejado ao aplicar parametros no bat
function Tfrmgerenciarmod.TemModSelecionado: Boolean;
begin
  Result := False;
  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    if ClientDataSet1.FieldByName('Selecionado').AsBoolean then
    begin
      Result := True;
      Exit;
    end;
    ClientDataSet1.Next;
  end;
end;

procedure Tfrmgerenciarmod.CopiarModsSelecionados;
var
  i, j: Integer;
  NomeModGrid, NomeModSteam, Linha: string;
  PastaRaizSteam, PastaMod, CaminhoMeta, PastaDestino, PastaKeysMod, PastaKeysServidor: string;
  DirServidor, ModID: string;
  MetaFile: TStringList;
  Pasta: string;
  Folders: TArray<string>;
  Ini: TIniFile;
  CaminhoINI, CaminhoBat, Chave, BatContent: string;
  Index, StartPos, EndPos: Integer;
begin
  // Verifica se algum servidor foi selecionado
  if RadioGroup1.ItemIndex = -1 then
  begin
    ShowMessage('Nenhum servidor selecionado. Verifique!');
    Exit;
  end;

  // Obtem caminho do servidor baseado no RadioGroup
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\Config.ini';
  Index := RadioGroup1.ItemIndex;
  case Index of
    0: Chave := 'Servidor 1';
    1: Chave := 'Servidor 2';
    2: Chave := 'Servidor 3';
  else
    //ShowMessage('Servidor não selecionado.');
    //Exit;
  end;

  Ini := TIniFile.Create(CaminhoINI);
  try
    CaminhoBat := Ini.ReadString(Chave, 'start', '');
    if CaminhoBat = '' then
    begin
      //ShowMessage('Caminho do BAT não encontrado no INI.');
      //Exit;
    end;
    DirServidor := ExtractFileDir(CaminhoBat); // Extrai só o diretório
  finally
    Ini.Free;
  end;

  PastaRaizSteam := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)) +
                      'Steamcmd\steamapps\workshop\content\221100');
  Folders := TDirectory.GetDirectories(PastaRaizSteam);

  for i := 0 to ClientDataSet1.RecordCount - 1 do
  begin
    ClientDataSet1.RecNo := i + 1;
    if not ClientDataSet1.FieldByName('Selecionado').AsBoolean then
      Continue;

    NomeModGrid := ClientDataSet1.FieldByName('NomeMod').AsString;

    for Pasta in Folders do
    begin
      CaminhoMeta := IncludeTrailingPathDelimiter(Pasta) + 'meta.cpp';
      if not FileExists(CaminhoMeta) then Continue;

      MetaFile := TStringList.Create;
      try
        MetaFile.LoadFromFile(CaminhoMeta);
        NomeModSteam := '';
        for j := 0 to MetaFile.Count - 1 do
        begin
          Linha := Trim(MetaFile[j]);
          if Pos('name =', Linha) > 0 then
          begin
            NomeModSteam := Copy(Linha, Pos('"', Linha) + 1,
                                 Length(Linha) - Pos('"', Linha));
            NomeModSteam := Copy(NomeModSteam, 1, Pos('"', NomeModSteam) - 1);
            Break;
          end;
        end;
      finally
        MetaFile.Free;
      end;

      if SameText(NomeModGrid, NomeModSteam) then
      begin
        PastaMod := Pasta;
        PastaDestino := IncludeTrailingPathDelimiter(DirServidor) + '@' + NomeModSteam;

        if not TDirectory.Exists(PastaDestino) then
          TDirectory.Copy(PastaMod, PastaDestino, True);

        // Copiar keys se existir
        PastaKeysMod := IncludeTrailingPathDelimiter(PastaMod) + 'keys';
        PastaKeysServidor := IncludeTrailingPathDelimiter(DirServidor) + 'keys';

        if TDirectory.Exists(PastaKeysMod) then
        begin
          if not TDirectory.Exists(PastaKeysServidor) then
            TDirectory.CreateDirectory(PastaKeysServidor);

          for var F in TDirectory.GetFiles(PastaKeysMod, '*.bikey') do
          begin
            TFile.Copy(F, IncludeTrailingPathDelimiter(PastaKeysServidor) + ExtractFileName(F), True);
          end;
        end;

        Break; // Já encontrou e copiou, sai do loop de pastas Steam
      end;
    end;
  end;

  ShowMessage('Cópia concluída!');
    // Atualiza o grid2 após a cópia
  ListaModServidor(RadioGroup1.ItemIndex + 1);

  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      ClientDataSet1.Edit;
      ClientDataSet1.FieldByName('Selecionado').AsBoolean := False;
      ClientDataSet1.Post;
      ClientDataSet1.Next;
    end;
  finally
    ClientDataSet1.EnableControls;
  end;
end;

procedure Tfrmgerenciarmod.BitBtn8Click(Sender: TObject);
begin
if not TemModSelecionado then
  begin
    ShowMessage('Nenhum mod selecionado. Verifique!');
    Exit;
  end;

  // Executa o procedimento de cópia
  CopiarModsSelecionados;

end;

procedure Tfrmgerenciarmod.BitBtn9Click(Sender: TObject);
begin
Application.CreateForm(Tfrmaddbat, frmaddbat);
try
  frmaddbat.Tag := 2;
  frmaddbat.CheckBox1.visible := false;
  frmaddbat.ShowModal;

finally
  frmaddbat.Free;
end;
end;

procedure Tfrmgerenciarmod.DBGrid1CellClick(Column: TColumn);
var
  NomeMod: string;
begin
  if Column.FieldName = 'Selecionado' then
  begin
    ClientDataSet2.Edit;
    if ClientDataSet2.FieldByName('Selecionado').AsBoolean then
      ClientDataSet2.FieldByName('Selecionado').AsBoolean := False
    else
      ClientDataSet2.FieldByName('Selecionado').AsBoolean := True;
    ClientDataSet2.Post;
  end;
end;

procedure Tfrmgerenciarmod.DBGrid1TitleClick(Column: TColumn);
begin
  if not ClientDataSet2.Active then Exit;

  if Column.FieldName = 'NomeMod' then
  begin
    if ClientDataSet2.IndexName = 'Idx_NomeMod_ASC' then
      ClientDataSet2.IndexName := 'Idx_NomeMod_DESC'
    else
      ClientDataSet2.IndexName := 'Idx_NomeMod_ASC';
  end;
end;

procedure Tfrmgerenciarmod.DBGrid2CellClick(Column: TColumn);
var
  NomeMod: string;
begin
  if Column.FieldName = 'Selecionado' then
  begin
    ClientDataSet3.Edit;
    if ClientDataSet3.FieldByName('Selecionado').AsBoolean then
      ClientDataSet3.FieldByName('Selecionado').AsBoolean := False
    else
      ClientDataSet3.FieldByName('Selecionado').AsBoolean := True;
    ClientDataSet3.Post;
  end;
end;

procedure Tfrmgerenciarmod.DBGrid2TitleClick(Column: TColumn);
var
  MarcarTodos: Boolean;
begin
 if not ClientDataSet3.Active then Exit;

  if Column.FieldName = 'NomeMod' then
  begin
    if ClientDataSet3.IndexName = 'Idx_NomeMod_ASC' then
      ClientDataSet3.IndexName := 'Idx_NomeMod_DESC'
    else
      ClientDataSet3.IndexName := 'Idx_NomeMod_ASC';
  end;

  if not ClientDataSet3.Active then Exit;

  if Column.FieldName = 'Tipo' then
  begin
    if ClientDataSet3.IndexName = 'Idx_Tipo_ASC' then
      ClientDataSet3.IndexName := 'Idx_Tipo_DESC'
    else
      ClientDataSet3.IndexName := 'Idx_Tipo_ASC';
  end;

  if Column.FieldName = 'Selecionado' then
  begin
    // Marca/desmarca todos os registros
    MarcarTodos := False;

    // Verifica se tem pelo menos UM desmarcado → então marca todos
    ClientDataSet3.First;
    while not ClientDataSet3.Eof do
    begin
      if not ClientDataSet3.FieldByName('Selecionado').AsBoolean then
      begin
        MarcarTodos := True;
        Break;
      end;
      ClientDataSet3.Next;
    end;

    ClientDataSet3.DisableControls;
    try
      ClientDataSet3.First;
      while not ClientDataSet3.Eof do
      begin
        ClientDataSet3.Edit;
        ClientDataSet3.FieldByName('Selecionado').AsBoolean := MarcarTodos;
        ClientDataSet3.Post;
        ClientDataSet3.Next;
      end;
    finally
      ClientDataSet3.EnableControls;
    end;
  end;
end;

procedure Tfrmgerenciarmod.FormCreate(Sender: TObject);
begin
  RadioGroup1.Items[0] := Form1.Servidor11.Caption;
  RadioGroup1.Items[1] := Form1.Servidor21.Caption;
  RadioGroup1.Items[2] := Form1.Servidor31.Caption;


  ClientDataSet1.FieldDefs.Clear;
  ClientDataSet1.FieldDefs.Add('Selecionado', ftBoolean);
  ClientDataSet1.FieldDefs.Add('IDSteam', ftString, 130); // Nova coluna
  ClientDataSet1.FieldDefs.Add('NomeMod', ftString, 685);

  ClientDataSet1.CreateDataSet;
  DataSource1.DataSet := ClientDataSet1;
  StringGrid1.DataSource := DataSource1; // EvDBGrid3D na prática
end;

//CARREGAR MOD STEAMCMD
procedure Tfrmgerenciarmod.CarregarModSteamcmd;
var
  PastaBase, PastaMod, CaminhoMeta: string;
  SR: TSearchRec;
  MetaFile: TStringList;
  Linha, NomeMod, IDSteam: string;
  j: Integer;
begin
  PastaBase := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
               'Steamcmd\steamapps\workshop\content\221100\';

  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.EmptyDataSet;

    if FindFirst(PastaBase + '*', faDirectory, SR) = 0 then
    begin
      repeat
        if (SR.Attr and faDirectory = faDirectory) and
           (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          PastaMod := IncludeTrailingPathDelimiter(PastaBase + SR.Name);
          CaminhoMeta := PastaMod + 'meta.cpp';

          if not FileExists(CaminhoMeta) then
            Continue;

          MetaFile := TStringList.Create;
          try
            MetaFile.LoadFromFile(CaminhoMeta);
            NomeMod := '';
            IDSteam := '';

            for j := 0 to MetaFile.Count - 1 do
            begin
              Linha := Trim(MetaFile[j]);

              // Pega o Nome do Mod
              if Pos('name =', Linha) > 0 then
              begin
                NomeMod := Copy(Linha, Pos('"', Linha) + 1,
                                Length(Linha) - Pos('"', Linha));
                NomeMod := Copy(NomeMod, 1, Pos('"', NomeMod) - 1);
              end;

              // Pega o ID Steam (publishedid = 123456789;)
              if Pos('publishedid =', Linha) > 0 then
              begin
                IDSteam := Trim(StringReplace(Linha, 'publishedid =', '', [rfIgnoreCase]));
                IDSteam := StringReplace(IDSteam, ';', '', [rfReplaceAll]);
                IDSteam := Trim(IDSteam);
              end;

              if (NomeMod <> '') and (IDSteam <> '') then
                Break;
            end;

            if NomeMod <> '' then
            begin
              ClientDataSet1.Append;
              ClientDataSet1.FieldByName('Selecionado').AsBoolean := False;
              ClientDataSet1.FieldByName('IDSteam').AsString := IDSteam;
              ClientDataSet1.FieldByName('NomeMod').AsString := NomeMod;
              ClientDataSet1.Post;
            end;

          finally
            MetaFile.Free;
          end;

        end;

      until FindNext(SR) <> 0;
      FindClose(SR);
    end;

  finally
    ClientDataSet1.EnableControls;
  end;

  if not ClientDataSet1.IndexDefs.IndexOf('Idx_NomeMod_ASC') >= 0 then
    ClientDataSet1.AddIndex('Idx_NomeMod_ASC', 'NomeMod', []);
  if not ClientDataSet1.IndexDefs.IndexOf('Idx_NomeMod_DESC') >= 0 then
    ClientDataSet1.AddIndex('Idx_NomeMod_DESC', 'NomeMod', [ixDescending]);

  ClientDataSet1.IndexName := 'Idx_NomeMod_ASC';

  Label2.Caption := 'MODs na pasta Steamcmd: ' + IntToStr(ClientDataSet1.RecordCount);
end;

procedure Tfrmgerenciarmod.FormShow(Sender: TObject);
var
  PastaBase, PastaMod, CaminhoMeta: string;
  SR: TSearchRec;
  MetaFile: TStringList;
  Linha, NomeMod, IDSteam: string;
  j: Integer;
begin
  PastaBase := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
               'Steamcmd\steamapps\workshop\content\221100\';

  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.EmptyDataSet;

    if FindFirst(PastaBase + '*', faDirectory, SR) = 0 then
    begin
      repeat
        if (SR.Attr and faDirectory = faDirectory) and
           (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          PastaMod := IncludeTrailingPathDelimiter(PastaBase + SR.Name);
          CaminhoMeta := PastaMod + 'meta.cpp';

          if not FileExists(CaminhoMeta) then
            Continue;

          MetaFile := TStringList.Create;
          try
            MetaFile.LoadFromFile(CaminhoMeta);
            NomeMod := '';
            IDSteam := '';

            for j := 0 to MetaFile.Count - 1 do
            begin
              Linha := Trim(MetaFile[j]);

              // Pega o Nome do Mod
              if Pos('name =', Linha) > 0 then
              begin
                NomeMod := Copy(Linha, Pos('"', Linha) + 1,
                                Length(Linha) - Pos('"', Linha));
                NomeMod := Copy(NomeMod, 1, Pos('"', NomeMod) - 1);
              end;

              // Pega o ID Steam (publishedid = 123456789;)
              if Pos('publishedid =', Linha) > 0 then
              begin
                IDSteam := Trim(StringReplace(Linha, 'publishedid =', '', [rfIgnoreCase]));
                IDSteam := StringReplace(IDSteam, ';', '', [rfReplaceAll]);
                IDSteam := Trim(IDSteam);
              end;

              if (NomeMod <> '') and (IDSteam <> '') then
                Break;
            end;

            if NomeMod <> '' then
            begin
              ClientDataSet1.Append;
              ClientDataSet1.FieldByName('Selecionado').AsBoolean := False;
              ClientDataSet1.FieldByName('IDSteam').AsString := IDSteam;
              ClientDataSet1.FieldByName('NomeMod').AsString := NomeMod;
              ClientDataSet1.Post;
            end;

          finally
            MetaFile.Free;
          end;

        end;

      until FindNext(SR) <> 0;
      FindClose(SR);
    end;

  finally
    ClientDataSet1.EnableControls;
  end;

  if not ClientDataSet1.IndexDefs.IndexOf('Idx_NomeMod_ASC') >= 0 then
    ClientDataSet1.AddIndex('Idx_NomeMod_ASC', 'NomeMod', []);
  if not ClientDataSet1.IndexDefs.IndexOf('Idx_NomeMod_DESC') >= 0 then
    ClientDataSet1.AddIndex('Idx_NomeMod_DESC', 'NomeMod', [ixDescending]);

  ClientDataSet1.IndexName := 'Idx_NomeMod_ASC';

  Label2.Caption := 'MODs na pasta Steamcmd: ' + IntToStr(ClientDataSet1.RecordCount);
end;

//Radiogroup
procedure Tfrmgerenciarmod.ListaModServidor(Servidor: Integer);
var
  Ini: TIniFile;
  IniPath, ExePath, PastaServidor, ModPath, ModName, MetaFile, IDSteam: string;
  Pastas: TStringDynArray;
  I: Integer;
  MetaLines: TStringList;
  J: Integer;
begin
  IniPath := ExtractFilePath(Application.ExeName) + 'Config\Config.ini';

  Ini := TIniFile.Create(IniPath);
  try
    ExePath := Ini.ReadString('Servidor ' + IntToStr(Servidor), 'exe', '');

    if not ClientDataSet2.Active then
    begin
      ClientDataSet2.FieldDefs.Clear;
      ClientDataSet2.FieldDefs.Add('Selecionado', ftBoolean);
      ClientDataSet2.FieldDefs.Add('NomeMod', ftString, 310);
      ClientDataSet2.FieldDefs.Add('IDSteam', ftString, 90);  // <-- Novo campo
      ClientDataSet2.CreateDataSet;
    end;

    if ExePath = '' then
    begin
      ClientDataSet2.DisableControls;
      try
        ClientDataSet2.EmptyDataSet;
      finally
        ClientDataSet2.EnableControls;
      end;
      Label3.Caption := 'MOD''s na pasta do Servidor: 0';
      ShowMessage('Caminho para os mod do servidor selecionado não definido. Verifique!');
      Exit;
    end;

    PastaServidor := ExtractFileDir(ExePath);

    if not DirectoryExists(PastaServidor) then
    begin
      ShowMessage('Pasta do servidor não encontrada: ' + PastaServidor);
      Exit;
    end;

    ClientDataSet2.DisableControls;
    try
      ClientDataSet2.EmptyDataSet;

      Pastas := TDirectory.GetDirectories(PastaServidor, '@*', TSearchOption.soTopDirectoryOnly);

      for I := 0 to High(Pastas) do
      begin
        ModPath := Pastas[I];
        ModName := ExtractFileName(ModPath);

        if LeftStr(ModName, 1) = '@' then
          ModName := Copy(ModName, 2, Length(ModName));

        // Caminho do arquivo meta.cpp
        MetaFile := IncludeTrailingPathDelimiter(ModPath) + 'meta.cpp';
        IDSteam := '';

        if FileExists(MetaFile) then
        begin
          MetaLines := TStringList.Create;
          try
            MetaLines.LoadFromFile(MetaFile);
            for J := 0 to MetaLines.Count - 1 do
            begin
              if Pos('publishedid', LowerCase(MetaLines[J])) > 0 then
              begin
                // Exemplo de linha: publishedid = 2276010135;
                IDSteam := Trim(MetaLines[J]);
                IDSteam := StringReplace(IDSteam, 'publishedid', '', [rfIgnoreCase]);
                IDSteam := StringReplace(IDSteam, '=', '', []);
                IDSteam := StringReplace(IDSteam, ';', '', []);
                IDSteam := Trim(IDSteam);
                Break;
              end;
            end;
          finally
            MetaLines.Free;
          end;
        end;

        ClientDataSet2.Append;
        ClientDataSet2.FieldByName('Selecionado').AsBoolean := False;
        ClientDataSet2.FieldByName('NomeMod').AsString := ModName;
        ClientDataSet2.FieldByName('IDSteam').AsString := IDSteam;  // <-- Preenche novo campo
        ClientDataSet2.Post;
      end;
    finally
      ClientDataSet2.EnableControls;
    end;

    // Cria índices físicos (se não existirem)
    if ClientDataSet2.IndexDefs.IndexOf('Idx_NomeMod_ASC') < 0 then
      ClientDataSet2.AddIndex('Idx_NomeMod_ASC', 'NomeMod', []);
    if ClientDataSet2.IndexDefs.IndexOf('Idx_NomeMod_DESC') < 0 then
      ClientDataSet2.AddIndex('Idx_NomeMod_DESC', 'NomeMod', [ixDescending]);

    ClientDataSet2.IndexName := 'Idx_NomeMod_ASC';

    Label3.Caption := 'MOD''s na pasta do Servidor: ' + IntToStr(ClientDataSet2.RecordCount);

  finally
    Ini.Free;
  end;
end;

procedure Tfrmgerenciarmod.ListaModBat(Servidor: Integer);
var
  Ini: TIniFile;
  IniPath, BatPath, Conteudo, ModsStr, ModName: string;
  Linhas: TStringList;
  I: Integer;
  ModArray: TArray<string>;
  StartPos, EndPos: Integer;
begin
  IniPath := ExtractFilePath(Application.ExeName) + 'Config\Config.ini';
  Ini := TIniFile.Create(IniPath);
  try
    // Garante estrutura do DataSet
    if not ClientDataSet3.Active then
    begin
      ClientDataSet3.FieldDefs.Clear;
      ClientDataSet3.FieldDefs.Add('Selecionado', ftBoolean);
      ClientDataSet3.FieldDefs.Add('NomeMod', ftString, 255);
      ClientDataSet3.FieldDefs.Add('Tipo', ftString, 100);
      ClientDataSet3.CreateDataSet;
    end;

    // Caminho do BAT no INI
    BatPath := Ini.ReadString('Servidor ' + IntToStr(Servidor), 'Start', '');
    if BatPath = '' then
    begin
      ClientDataSet3.DisableControls;
      try
        ClientDataSet3.EmptyDataSet;
      finally
        ClientDataSet3.EnableControls;
      end;

      Label4.Caption := 'MOD''s listados no BAT: 0';
      ShowMessage('Caminho do arquivo .bat não definido.');
      Exit;
    end;

    if not FileExists(BatPath) then
    begin
      ShowMessage('Arquivo .bat não encontrado: ' + BatPath);
      Exit;
    end;

    Linhas := TStringList.Create;
    try
      Linhas.LoadFromFile(BatPath);
      // Junta tudo em uma linha só
      Conteudo := Linhas.Text.Replace(#13#10, ' ').Replace(#10, ' ').Replace(#13, ' ');

      ClientDataSet3.DisableControls;
      try
        ClientDataSet3.EmptyDataSet;

        // === Bloco: -mod ===
        StartPos := Pos('-mod=', Conteudo);
        if StartPos > 0 then
        begin
          StartPos := StartPos + Length('-mod=');
          EndPos := PosEx('"', Conteudo, StartPos);
          if EndPos > StartPos then
          begin
            ModsStr := Copy(Conteudo, StartPos, EndPos - StartPos).Trim;
            ModArray := ModsStr.Split([';']);
            for I := 0 to High(ModArray) do
            begin
              ModName := ModArray[I].Trim;
              if ModName.StartsWith('@') then
                ModName := ModName.Substring(1);
              if ModName <> '' then
              begin
                ClientDataSet3.Append;
                ClientDataSet3.FieldByName('Selecionado').AsBoolean := False;
                ClientDataSet3.FieldByName('NomeMod').AsString := ModName;
                ClientDataSet3.FieldByName('Tipo').AsString := 'Mod';
                ClientDataSet3.Post;
              end;
            end;
          end;
        end;

        // === Bloco: -servermod ===
        StartPos := Pos('-servermod=', Conteudo);
        if StartPos > 0 then
        begin
          StartPos := StartPos + Length('-servermod=');
          EndPos := PosEx('"', Conteudo, StartPos);
          if EndPos > StartPos then
          begin
            ModsStr := Copy(Conteudo, StartPos, EndPos - StartPos).Trim;
            ModArray := ModsStr.Split([';']);
            for I := 0 to High(ModArray) do
            begin
              ModName := ModArray[I].Trim;
              if ModName.StartsWith('@') then
                ModName := ModName.Substring(1);
              if ModName <> '' then
              begin
                ClientDataSet3.Append;
                ClientDataSet3.FieldByName('Selecionado').AsBoolean := False;
                ClientDataSet3.FieldByName('NomeMod').AsString := ModName;
                ClientDataSet3.FieldByName('Tipo').AsString := 'ServerMod';
                ClientDataSet3.Post;
              end;
            end;
          end;
        end;

      finally
        ClientDataSet3.EnableControls;
      end;

      // 🔥 Agora SIM: cria os índices FÍSICOS
      if not ClientDataSet3.IndexDefs.IndexOf('Idx_NomeMod_ASC') >= 0 then
      ClientDataSet3.AddIndex('Idx_NomeMod_ASC', 'NomeMod', []);
      if not ClientDataSet3.IndexDefs.IndexOf('Idx_NomeMod_DESC') >= 0 then
      ClientDataSet3.AddIndex('Idx_NomeMod_DESC', 'NomeMod', [ixDescending]);

      // Ativa ASC por padrão
//      ClientDataSet3.IndexName := 'Idx_NomeMod_ASC';

      // 🔥 Agora SIM: cria os índices FÍSICOS
      if not ClientDataSet3.IndexDefs.IndexOf('Idx_Tipo_ASC') >= 0 then
      ClientDataSet3.AddIndex('Idx_Tipo_ASC', 'Tipo', []);
      if not ClientDataSet3.IndexDefs.IndexOf('Idx_Tipo_DESC') >= 0 then
      ClientDataSet3.AddIndex('Idx_Tipo_DESC', 'Tipo', [ixDescending]);

      // Ativa ASC por padrão
      ClientDataSet3.IndexName := 'Idx_NomeMod_ASC';

      Label4.Caption := 'MOD''s listados no BAT: ' + IntToStr(ClientDataSet3.RecordCount);

    finally
      Linhas.Free;
    end;

  finally
    Ini.Free;
  end;
end;

procedure Tfrmgerenciarmod.RadioGroup1Click(Sender: TObject);
var
  Servidor: Integer;
begin
  Label5.Visible := False;

  Servidor := RadioGroup1.ItemIndex + 1;

  ListaModServidor(Servidor);
  ListaModBat(Servidor);
end;


procedure Tfrmgerenciarmod.StringGrid1CellClick(Column: TColumn);
var
  NomeMod: string;
begin
  if Column.FieldName = 'Selecionado' then
  begin
    ClientDataSet1.Edit;
    if ClientDataSet1.FieldByName('Selecionado').AsBoolean then
      ClientDataSet1.FieldByName('Selecionado').AsBoolean := False
    else
      ClientDataSet1.FieldByName('Selecionado').AsBoolean := True;
    ClientDataSet1.Post;
  end;
end;

procedure Tfrmgerenciarmod.StringGrid1TitleClick(Column: TColumn);
var
  MarcarTodos: Boolean;
begin
  if not ClientDataSet1.Active then Exit;

  if Column.FieldName = 'NomeMod' then
  begin
    // Alterna ordem ASC/DESC da coluna NomeMod
    if ClientDataSet1.IndexName = 'Idx_NomeMod_ASC' then
      ClientDataSet1.IndexName := 'Idx_NomeMod_DESC'
    else
      ClientDataSet1.IndexName := 'Idx_NomeMod_ASC';
  end
  else if Column.FieldName = 'Selecionado' then
  begin
    // Marca/desmarca todos os registros
    MarcarTodos := False;

    // Verifica se tem pelo menos UM desmarcado → então marca todos
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      if not ClientDataSet1.FieldByName('Selecionado').AsBoolean then
      begin
        MarcarTodos := True;
        Break;
      end;
      ClientDataSet1.Next;
    end;

    ClientDataSet1.DisableControls;
    try
      ClientDataSet1.First;
      while not ClientDataSet1.Eof do
      begin
        ClientDataSet1.Edit;
        ClientDataSet1.FieldByName('Selecionado').AsBoolean := MarcarTodos;
        ClientDataSet1.Post;
        ClientDataSet1.Next;
      end;
    finally
      ClientDataSet1.EnableControls;
    end;
  end;
end;

end.
