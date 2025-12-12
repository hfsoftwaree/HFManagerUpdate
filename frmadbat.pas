unit frmadbat;

interface

uses
  Windows, ShellAPI, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus,
  Vcl.Grids, Data.DB, Vcl.DBGrids, EDBGrid, Datasnap.DBClient, System.StrUtils, System.IOUtils;

type
  Tfrmaddbat = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RadioGroup1: TRadioGroup;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    StringGrid1: TEvDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Label4: TLabel;
    Memo2: TMemo;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    Button1: TButton;
    BitBtn4: TBitBtn;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1CellClick(Column: TColumn);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CopiarModsSelecionados;
    procedure CheckBox1Click(Sender: TObject);
    procedure CarregarModsDoMemo;
    procedure CarregarTodosModsSteam;
    procedure StringGrid1TitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);





  private
    { Private declarations }

  public
    { Public declarations }
    OrigemChamada: string;
  end;

var
  frmaddbat: Tfrmaddbat;

implementation

uses Unit1, frmwebsteam;

{$R *.dfm}
//Copia mod selecionado na pasta steam para o servidor desejado ao aplicar parametros no bat
procedure Tfrmaddbat.CheckBox1Click(Sender: TObject);
var
  PastaMods, PastaMod, CaminhoMeta: string;
  SR: TSearchRec;
  MetaFile: TStringList;
  NomeMod, Linha, NomeOriginal, ModID: string;
  i, j, PosSeparador: Integer;
begin
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.EmptyDataSet;

    if CheckBox1.Checked then
    begin
      checkBox1.Caption := 'Mostrar ultimos';
      // Mostra todos os mods da pasta Steam
      PastaMods := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
                   'Steamcmd\steamapps\workshop\content\221100\';

      if FindFirst(PastaMods + '*', faDirectory, SR) = 0 then
      begin
        repeat
          if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
          begin
            PastaMod := IncludeTrailingPathDelimiter(PastaMods + SR.Name);
            CaminhoMeta := PastaMod + 'meta.cpp';

            if not FileExists(CaminhoMeta) then
              Continue;

            MetaFile := TStringList.Create;
            try
              MetaFile.LoadFromFile(CaminhoMeta);
              NomeMod := '';

              for j := 0 to MetaFile.Count - 1 do
              begin
                Linha := Trim(MetaFile[j]);
                if Pos('name =', Linha) > 0 then
                begin
                  NomeMod := Copy(Linha, Pos('"', Linha) + 1,
                                  Length(Linha) - Pos('"', Linha));
                  NomeMod := Copy(NomeMod, 1, Pos('"', NomeMod) - 1);
                  Break;
                end;
              end;

              if NomeMod = '' then Continue;

              ClientDataSet1.Append;
              ClientDataSet1.FieldByName('Selecionado').AsBoolean := False;
              ClientDataSet1.FieldByName('NomeMod').AsString := NomeMod;
              ClientDataSet1.FieldByName('Tipo').AsString := 'ServerMod';
              ClientDataSet1.Post;

            finally
              MetaFile.Free;
            end;
          end;
        until FindNext(SR) <> 0;
        FindClose(SR);
      end;

      Label2.Caption := 'Todos os mods baixados: ' + IntToStr(ClientDataSet1.RecordCount);
    end
    else
    begin
      checkBox1.Caption := 'Mostrar todos';
      // Mostra apenas os mods do Memo1
      for i := 0 to formWebSteam.Memo1.Lines.Count - 1 do
      begin
        NomeOriginal := Trim(formWebSteam.Memo1.Lines[i]);
        ModID := NomeOriginal;
        if ModID = '' then Continue;

        PosSeparador := Pos('-', ModID);
        if PosSeparador > 0 then
          ModID := Trim(Copy(ModID, 1, PosSeparador - 1));

        PastaMod := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
                    'Steamcmd\steamapps\workshop\content\221100\' + ModID;
        CaminhoMeta := IncludeTrailingPathDelimiter(PastaMod) + 'meta.cpp';

        if not FileExists(CaminhoMeta) then
          Continue;

        MetaFile := TStringList.Create;
        try
          MetaFile.LoadFromFile(CaminhoMeta);
          NomeMod := '';

          for j := 0 to MetaFile.Count - 1 do
          begin
            Linha := Trim(MetaFile[j]);
            if Pos('name =', Linha) > 0 then
            begin
              NomeMod := Copy(Linha, Pos('"', Linha) + 1,
                              Length(Linha) - Pos('"', Linha));
              NomeMod := Copy(NomeMod, 1, Pos('"', NomeMod) - 1);
              Break;
            end;
          end;

          if NomeMod = '' then Continue;

          ClientDataSet1.Append;
          ClientDataSet1.FieldByName('Selecionado').AsBoolean := True;
          ClientDataSet1.FieldByName('NomeMod').AsString := NomeMod;
          ClientDataSet1.FieldByName('Tipo').AsString := 'ServerMod';
          ClientDataSet1.Post;

        finally
          MetaFile.Free;
        end;
      end;

      Label2.Caption := 'Últimos mods baixados: ' + IntToStr(ClientDataSet1.RecordCount);
    end;

  finally
    ClientDataSet1.EnableControls;
  end;
end;

procedure Tfrmaddbat.CopiarModsSelecionados;
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

  //ShowMessage('Cópia concluída!');
end;


procedure Tfrmaddbat.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure Tfrmaddbat.BitBtn2Click(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI, CaminhoBat, BackupPath, BatContent, BackupFileName: string;
  Chave: string;
  Index, StartPos, EndPos: Integer;
  CaminhoServidor: string;
  ModID, NomeMod: string;
  i: Integer;
  ModPresenteNosMemos: Boolean;
begin
  // Verificar se algum mod do grid está presente nos Memo1 ou Memo2
  ModPresenteNosMemos := False;
  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    NomeMod := ClientDataSet1.FieldByName('NomeMod').AsString.Trim;
    if (Memo1.Lines.Text.Contains('@' + NomeMod)) or
       (Memo2.Lines.Text.Contains('@' + NomeMod)) then
    begin
      ModPresenteNosMemos := True;
      Break;
    end;
    ClientDataSet1.Next;
  end;

  if not ModPresenteNosMemos then
  begin
    ShowMessage('Nenhum mod foi adicionado aos parâmetros. Verifique!');
    Exit;
  end;


  // Caminho do INI
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\Config.ini';

  // Ver qual servidor foi selecionado
  Index := RadioGroup1.ItemIndex;

  case Index of
    0: Chave := 'Servidor 1';
    1: Chave := 'Servidor 2';
    2: Chave := 'Servidor 3';
  else
    ShowMessage('Selecione um servidor!');
    Exit;
  end;

  // Ler caminho do BAT
  Ini := TIniFile.Create(CaminhoINI);
  try
    CaminhoBat := Ini.ReadString(Chave, 'start', '');

    if not FileExists(CaminhoBat) then
    begin
      ShowMessage('Arquivo BAT não encontrado!');
      Exit;
    end;

    // Perguntar confirmação
    if MessageDlg('Um backup será criado na mesma pasta do arquivo original.' + sLineBreak +
                  'Em seguida, o arquivo BAT será atualizado com os novos parâmetros.' + sLineBreak +
                  sLineBreak + 'Deseja continuar?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;

    // Criar backup fixo
    BackupPath := ChangeFileExt(CaminhoBat, '') + '_backup.bat';
    BackupFileName := ExtractFileName(BackupPath);
    TFile.Copy(CaminhoBat, BackupPath, True); // True sobrescreve se já existir

     // Caminho base do servidor
    CaminhoServidor := ExtractFileDir(CaminhoBat);

    // Copiar os mods selecionados
    CopiarModsSelecionados;

    // Ler conteúdo original
    BatContent := TFile.ReadAllText(CaminhoBat, TEncoding.Default);

    // === Atualizar -servermod ===
    StartPos := Pos('-servermod=', BatContent);
    if StartPos > 0 then
    begin
      StartPos := StartPos + Length('-servermod=');
      EndPos := PosEx('"', BatContent, StartPos);
      Delete(BatContent, StartPos, EndPos - StartPos);
      Insert(Memo1.Lines.Text, BatContent, StartPos);
    end
    else
    begin
      ShowMessage('Parâmetro -servermod não encontrado!');
    end;

    // === Atualizar -mod ===
    StartPos := Pos('-mod=', BatContent);
    if StartPos > 0 then
    begin
      StartPos := StartPos + Length('-mod=');
      EndPos := PosEx('"', BatContent, StartPos);
      Delete(BatContent, StartPos, EndPos - StartPos);
      Insert(Memo2.Lines.Text, BatContent, StartPos);
    end
    else
    begin
      ShowMessage('Parâmetro -mod não encontrado!');
    end;

    // Salvar alterações
    TFile.WriteAllText(CaminhoBat, BatContent, TEncoding.Default);

    ShowMessage('Arquivo BAT atualizado com sucesso!' + sLineBreak +
                'Backup salvo como: ' + BackupFileName);

  finally
    Ini.Free;
  end;
end;

procedure Tfrmaddbat.BitBtn3Click(Sender: TObject);
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

procedure Tfrmaddbat.BitBtn4Click(Sender: TObject);
var
  ModName, Param: string;
  ModSelecionado, ModEncontrado: Boolean;
  ModsNaoEncontrados: TStringList;
begin
  // Verificar se há mods
  if ClientDataSet1.IsEmpty then
  begin
    ShowMessage('Nenhum mod disponível.');
    Exit;
  end;

  ModsNaoEncontrados := TStringList.Create;
  try
    ModSelecionado := False;

    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      if ClientDataSet1.FieldByName('Selecionado').AsBoolean then
      begin
        ModSelecionado := True;

        ModName := ClientDataSet1.FieldByName('NomeMod').AsString.Trim;

        if ModName = '' then
        begin
          ClientDataSet1.Next;
          Continue;
        end;

        Param := ';@' + ModName;

        // Limpar quebras de linha
        Memo1.Lines.Text := Memo1.Lines.Text.Replace(sLineBreak, '').Trim;
        Memo2.Lines.Text := Memo2.Lines.Text.Replace(sLineBreak, '').Trim;

        ModEncontrado := False;

        if Memo1.Lines.Text.Contains(Param) then
        begin
          Memo1.Lines.Text := Memo1.Lines.Text.Replace(Param, '');
          ModEncontrado := True;
        end;

        if Memo2.Lines.Text.Contains(Param) then
        begin
          Memo2.Lines.Text := Memo2.Lines.Text.Replace(Param, '');
          ModEncontrado := True;
        end;

        if not ModEncontrado then
          ModsNaoEncontrados.Add(ModName);
      end;

      ClientDataSet1.Next;
    end;

    if not ModSelecionado then
      ShowMessage('Nenhum MOD foi selecionado para remoção.')
    else if ModsNaoEncontrados.Count > 0 then
      ShowMessage('Os seguintes mods não constam na linha de comando:' + sLineBreak + ModsNaoEncontrados.Text);

  finally
    ModsNaoEncontrados.Free;
  end;
end;



procedure Tfrmaddbat.Button1Click(Sender: TObject);
var
  ModName, ModType, Param: string;
  ModSelecionado: Boolean;
begin
  // Verificar servidor selecionado
  if RadioGroup1.ItemIndex = -1 then
  begin
    ShowMessage('Selecione um servidor primeiro!');
    Exit;
  end;

  // Verificar se há mods
  if ClientDataSet1.IsEmpty then
  begin
    ShowMessage('Nenhum mod disponível.');
    Exit;
  end;

  ModSelecionado := False; // Flag para verificar seleção

  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    if ClientDataSet1.FieldByName('Selecionado').AsBoolean then
    begin
      ModSelecionado := True;

      ModName := ClientDataSet1.FieldByName('NomeMod').AsString.Trim;
      ModType := ClientDataSet1.FieldByName('Tipo').AsString.Trim;

      if ModName = '' then
      begin
        ClientDataSet1.Next;
        Continue;
      end;

      Param := ';@' + ModName;

      // Limpar quebras de linha e espaços
      Memo1.Lines.Text := Memo1.Lines.Text.Replace(sLineBreak, '').Trim;
      Memo2.Lines.Text := Memo2.Lines.Text.Replace(sLineBreak, '').Trim;

      // REMOVER do outro Memo, se existir
      if SameText(ModType, 'ServerMod') then
      begin
        if Memo2.Lines.Text.Contains(Param) then
          Memo2.Lines.Text := Memo2.Lines.Text.Replace(Param, '');

        if not Memo1.Lines.Text.Contains(Param) then
          Memo1.Lines.Text := Memo1.Lines.Text + Param;
      end
      else if SameText(ModType, 'ServerSide') then
      begin
        if Memo1.Lines.Text.Contains(Param) then
          Memo1.Lines.Text := Memo1.Lines.Text.Replace(Param, '');

        if not Memo2.Lines.Text.Contains(Param) then
          Memo2.Lines.Text := Memo2.Lines.Text + Param;
      end
      else
      begin
        ShowMessage('Tipo de mod inválido: ' + ModType);
      end;

    end;

    ClientDataSet1.Next;
  end;

  if not ModSelecionado then
    ShowMessage('Nenhum MOD foi selecionado. Verifique!');

end;

procedure Tfrmaddbat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.EvFocus.ChangeColor := True;
  Form1.EvFocus.ChangeFont := True;
end;

procedure Tfrmaddbat.FormCreate(Sender: TObject);
begin
  Form1.EvFocus.ChangeColor := False;
  Form1.EvFocus.ChangeFont := False;

  RadioGroup1.Items[0] := Form1.Servidor11.Caption;
  RadioGroup1.Items[1] := Form1.Servidor21.Caption;
  RadioGroup1.Items[2] := Form1.Servidor31.Caption;

  ClientDataSet1.FieldDefs.Clear;
  ClientDataSet1.FieldDefs.Add('Selecionado', ftBoolean);
  ClientDataSet1.FieldDefs.Add('NomeMod', ftString, 255);
  ClientDataSet1.FieldDefs.Add('Tipo', ftString, 20);

  ClientDataSet1.CreateDataSet;

  with ClientDataSet1.IndexDefs do
  begin
    Clear;
    Add('Idx_NomeMod_ASC', 'NomeMod', []);
    Add('Idx_NomeMod_DESC', 'NomeMod', [ixDescending]);
  end;

  DataSource1.DataSet := ClientDataSet1;
  StringGrid1.DataSource := DataSource1; // EvDBGrid3D na prática
end;

//VALIDA QUAL BOTAO CHAMOU O FORM
procedure Tfrmaddbat.CarregarModsDoMemo;
var
  i, j, PosSeparador: Integer;
  ModID, PastaMod, CaminhoMeta, NomeMod, Linha, NomeOriginal: string;
  MetaFile: TStringList;
begin
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.EmptyDataSet;

    for i := 0 to formWebSteam.Memo1.Lines.Count - 1 do
    begin
      NomeOriginal := Trim(formWebSteam.Memo1.Lines[i]);
      ModID := NomeOriginal;

      if ModID = '' then Continue;

      PosSeparador := Pos('-', ModID);
      if PosSeparador > 0 then
        ModID := Trim(Copy(ModID, 1, PosSeparador - 1));

      PastaMod := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
                  'Steamcmd\steamapps\workshop\content\221100\' + ModID;
      CaminhoMeta := IncludeTrailingPathDelimiter(PastaMod) + 'meta.cpp';

      if not FileExists(CaminhoMeta) then
        Continue;

      MetaFile := TStringList.Create;
      try
        MetaFile.LoadFromFile(CaminhoMeta);

        NomeMod := '';
        for j := 0 to MetaFile.Count - 1 do
        begin
          Linha := Trim(MetaFile[j]);
          if Pos('name =', Linha) > 0 then
          begin
            NomeMod := Copy(Linha, Pos('"', Linha) + 1,
                            Length(Linha) - Pos('"', Linha));
            NomeMod := Copy(NomeMod, 1, Pos('"', NomeMod) - 1);
            Break;
          end;
        end;

        if NomeMod = '' then Continue;

        ClientDataSet1.Append;
        ClientDataSet1.FieldByName('Selecionado').AsBoolean := True;
        ClientDataSet1.FieldByName('NomeMod').AsString := NomeMod;
        ClientDataSet1.FieldByName('Tipo').AsString := 'ServerMod';
        ClientDataSet1.Post;

      finally
        MetaFile.Free;
      end;
    end;

    Label2.Caption := 'Últimos mods baixados: ' + IntToStr(ClientDataSet1.RecordCount);
  finally
    ClientDataSet1.EnableControls;
    ClientDataSet1.IndexFieldNames := ''; // Limpa para garantir que IndexName funcione
    ClientDataSet1.IndexName := 'Idx_NomeMod_ASC'; // Ordena por NomeMod ASC

  end;
end;

procedure Tfrmaddbat.CarregarTodosModsSteam;
var
  PastaMods, PastaMod, CaminhoMeta: string;
  SR: TSearchRec;
  MetaFile: TStringList;
  NomeMod, Linha: string;
  j: Integer;
begin
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.EmptyDataSet;

    PastaMods := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
                 'Steamcmd\steamapps\workshop\content\221100\';

    if FindFirst(PastaMods + '*', faDirectory, SR) = 0 then
    begin
      repeat
        if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          PastaMod := IncludeTrailingPathDelimiter(PastaMods + SR.Name);
          CaminhoMeta := PastaMod + 'meta.cpp';

          if not FileExists(CaminhoMeta) then
            Continue;

          MetaFile := TStringList.Create;
          try
            MetaFile.LoadFromFile(CaminhoMeta);
            NomeMod := '';

            for j := 0 to MetaFile.Count - 1 do
            begin
              Linha := Trim(MetaFile[j]);
              if Pos('name =', Linha) > 0 then
              begin
                NomeMod := Copy(Linha, Pos('"', Linha) + 1,
                                Length(Linha) - Pos('"', Linha));
                NomeMod := Copy(NomeMod, 1, Pos('"', NomeMod) - 1);
                Break;
              end;
            end;

            if NomeMod = '' then Continue;

            ClientDataSet1.Append;
            ClientDataSet1.FieldByName('Selecionado').AsBoolean := False;
            ClientDataSet1.FieldByName('NomeMod').AsString := NomeMod;
            ClientDataSet1.FieldByName('Tipo').AsString := 'ServerMod';
            ClientDataSet1.Post;

          finally
            MetaFile.Free;
          end;
        end;
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;

    Label2.Caption := 'Todos os mods baixados: ' + IntToStr(ClientDataSet1.RecordCount);
  finally
    ClientDataSet1.EnableControls;
    ClientDataSet1.IndexFieldNames := ''; // Limpa para garantir que IndexName funcione
    ClientDataSet1.IndexName := 'Idx_NomeMod_ASC'; // Ordena por NomeMod ASC
  end;
end;

procedure Tfrmaddbat.FormShow(Sender: TObject);
begin
  case Tag of
    1: CarregarModsDoMemo;
    2: CarregarTodosModsSteam;
  end;
end;

procedure Tfrmaddbat.RadioGroup1Click(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI, CaminhoBat, Chave, BatContent, ServerMod, ModParam: string;
  Index, StartPos, EndPos: Integer;
begin
  // Caminho do INI no diretório de instalação
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\Config.ini';

  // Ver qual servidor
  Index := RadioGroup1.ItemIndex;

  case Index of
    0: Chave := 'Servidor 1';
    1: Chave := 'Servidor 2';
    2: Chave := 'Servidor 3';
  else
    Exit;
  end;

  // Ler caminho do bat
  Ini := TIniFile.Create(CaminhoINI);
  try
    CaminhoBat := Ini.ReadString(Chave, 'start', '');

    if FileExists(CaminhoBat) then
    begin
      BatContent := TFile.ReadAllText(CaminhoBat, TEncoding.Default);

      // Procurar -servermod
      StartPos := Pos('-servermod=', BatContent);
      if StartPos > 0 then
      begin
        StartPos := StartPos + Length('-servermod=');
        EndPos := PosEx('"', BatContent, StartPos);
        ServerMod := Copy(BatContent, StartPos, EndPos - StartPos);
      end
      else
        ServerMod := 'Não encontrado';

      // Procurar -mod
      StartPos := Pos('-mod=', BatContent);
      if StartPos > 0 then
      begin
        StartPos := StartPos + Length('-mod=');
        EndPos := PosEx('"', BatContent, StartPos);
        ModParam := Copy(BatContent, StartPos, EndPos - StartPos);
      end
      else
        ModParam := 'Não encontrado';

      // Exibir nos Memos
      Memo1.Lines.Text := ServerMod;
      Memo2.Lines.Text := ModParam;
      Button1.Enabled := True;
      BitBtn4.Enabled := True;

      Label5.Caption := CaminhoBat;
    end
    else
    begin
      Memo1.Lines.Text := 'Caminho do arquivo BAT não encontrado ou não configurado.';
      Memo2.Lines.Text := '';
      Button1.Enabled := False;
      BitBtn4.Enabled := False;

      Label5.Caption := '';
    end;
  finally
    Ini.Free;
  end;
end;


procedure Tfrmaddbat.StringGrid1CellClick(Column: TColumn);
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
  end
  else if Column.FieldName = 'Tipo' then
  begin
    ClientDataSet1.Edit;
    if ClientDataSet1.FieldByName('Tipo').AsString = 'ServerMod' then
      ClientDataSet1.FieldByName('Tipo').AsString := 'ServerSide'
    else
      ClientDataSet1.FieldByName('Tipo').AsString := 'ServerMod';
    ClientDataSet1.Post;
  end;
end;

procedure Tfrmaddbat.StringGrid1TitleClick(Column: TColumn);
begin
if Column.FieldName = 'NomeMod' then
  begin
    // Alterna ordem ASC/DESC da coluna NomeMod
    if ClientDataSet1.IndexName = 'Idx_NomeMod_ASC' then
      ClientDataSet1.IndexName := 'Idx_NomeMod_DESC'
    else
      ClientDataSet1.IndexName := 'Idx_NomeMod_ASC';
  end
end;

end.
