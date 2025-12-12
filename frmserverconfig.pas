unit frmserverconfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus, StrUtils, ShellAPI,
  System.IOUtils; // para TPath



type
  TForm19 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label33: TLabel;
    Memo: TMemo;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    origem: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure Label33Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm19.BitBtn1Click(Sender: TObject);
begin
Close;
end;

//cria backup do arquivo serverDZ.cfg antes de salvar as alteracoes
procedure CriarBackupArquivo(const CaminhoOriginal: string);
var
  BackupPath: string;
begin
  if FileExists(CaminhoOriginal) then
  begin
    // Monta o caminho do backup com sufixo "_backup"
    BackupPath := ChangeFileExt(CaminhoOriginal, '') + '_backup' + ExtractFileExt(CaminhoOriginal);
    try
      CopyFile(PChar(CaminhoOriginal), PChar(BackupPath), False);
      ShowMessage('Por segurança, uma cópia do arquivo foi criada com o nome: ' + ExtractFileName(BackupPath));
    except
      on E: Exception do
        ShowMessage('Aviso: não foi possível criar o backup do arquivo original. Erro: ' + E.Message);
    end;
  end
  else
    ShowMessage('Aviso: Arquivo original não encontrado para criar backup.');
end;
//End

procedure TForm19.BitBtn2Click(Sender: TObject);
var
  SaveDir, TempPath, OrigemPath: string;
begin

  // Caminho do arquivo de origem
  OrigemPath := origem.Caption;

  //cria backup do arquivo serverDZ.cfg
  CriarBackupArquivo(Origem.Caption);

  // Caminho do diretório temporário
  SaveDir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)) + 'temp\cfgs1\');

  // Cria o diretório temporário se necessário
  if not DirectoryExists(SaveDir) then
    ForceDirectories(SaveDir);

  // Caminho do arquivo temporário
  TempPath := SaveDir + 'serverDZ.cfg';

  // Salva o conteúdo do Memo no temporário
  Memo.Lines.SaveToFile(TempPath);

  try
    // Tenta apagar o arquivo de origem (pode falhar se estiver em uso)
    if FileExists(OrigemPath) then
      DeleteFile(OrigemPath);

    // Tenta renomear o temporário para o original
    if RenameFile(TempPath, OrigemPath) then
      ShowMessage('Alteração realizada com sucesso!')
    else
      raise Exception.Create('Falha ao substituir o arquivo.');
  except
    on E: Exception do
    begin
      ShowMessage('Não foi possível aplicar as alterações, pois o arquivo está em uso. ' +
                  'As mudanças serão aplicadas no próximo restart do servidor.');
    end;
  end;
end;


//REMOVE COMENTARIO MEMO
procedure TForm19.BitBtn3Click(Sender: TObject);
var
  i, posPontoVirgula, posComentario: Integer;
  linha, novaLinha: string;
begin
  for i := 0 to Memo.Lines.Count - 1 do
  begin
    linha := Memo.Lines[i];

    // Verifica se existe //
    posComentario := Pos('//', linha);
    if posComentario > 0 then
      Delete(linha, posComentario, Length(linha) - posComentario + 1);

    // Verifica se existe ;
    posPontoVirgula := Pos(';', linha);
    if posPontoVirgula > 0 then
      linha := Copy(linha, 1, posPontoVirgula); // Mantém o ;

    Memo.Lines[i] := TrimRight(linha); // Remove espaços no final

  end;
    //aqui define quebra de linha novamente
    Memo.ScrollBars := ssVertical;
    Memo.WordWrap := true;
end;
//End


procedure TForm19.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Evfocus.ChangeColor := True;
  Form1.Evfocus.ChangeFont  := True;
end;

procedure TForm19.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  IniPath, DestinoServidor, ServerCfgPath: string;
begin
  Form1.Evfocus.ChangeColor := False;
  Form1.Evfocus.ChangeFont  := False;

  // Caminho para o config.ini
  IniPath := ExtractFilePath(Application.ExeName) + 'Config\config.ini';

  if not FileExists(IniPath) then
  begin
    ShowMessage('Arquivo config.ini não encontrado!');
    Exit;
  end;

  // Lê o valor do ini
  Ini := TIniFile.Create(IniPath);
  try
    DestinoServidor := Ini.ReadString('UpdateMod', 'destinoserver1', '');
    origem.Caption:= DestinoServidor;
  finally
    Ini.Free;
  end;

  // Monta o caminho completo para o serverDZ.cfg
  if DestinoServidor <> '' then
    ServerCfgPath := IncludeTrailingPathDelimiter(DestinoServidor) + 'serverDZ.cfg';

  // Se o caminho for vazio ou o arquivo não existir, pedir para selecionar
  if (DestinoServidor = '') or (not FileExists(ServerCfgPath)) then
  begin
    with TOpenDialog.Create(Self) do
    try
      Title := 'Selecione o arquivo serverDZ.cfg';
      Filter := 'Arquivos CFG (*.cfg)|*.cfg|Todos os Arquivos (*.*)|*.*';
      if Execute then
        ServerCfgPath := FileName
      else
        Exit; // Usuário cancelou
    finally
      Free;
    end;
  end;

  origem.Caption:= ServerCfgPath;
  // Carrega o conteúdo do arquivo no memo
  Memo.Lines.LoadFromFile(ServerCfgPath);
  Memo.WordWrap:=False;
end;



procedure TForm19.Label33Click(Sender: TObject);
begin
 ShellExecute(0, 'open', 'https://community.bohemia.net/wiki/DayZ:Server_Configuration#Main_Parameters', nil, nil, SW_SHOWNORMAL);
end;

end.
