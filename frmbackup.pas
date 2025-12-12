unit frmbackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus,
  RxToolEdit;

type
  TForm12 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    FilenameEdit3: TFilenameEdit;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    DirectoryEdit3: TDirectoryEdit;
    Label2: TLabel;
    DirectoryEdit1: TDirectoryEdit;
    Label3: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    Label6: TLabel;
    FilenameEdit1: TFilenameEdit;
    BitBtn3: TBitBtn;
    Label8: TLabel;
    FilenameEdit2: TFilenameEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DirectoryEdit1Change(Sender: TObject);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo1Exit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FilenameEdit2Change(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm12.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm12.BitBtn2Click(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
  i: Integer;
  Secao: string;
  ListaChaves: TStringList;
begin
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  // Garante que a pasta Config existe
  if not DirectoryExists(ExtractFilePath(CaminhoINI)) then
    ForceDirectories(ExtractFilePath(CaminhoINI));

  // Criar ou abrir o arquivo de configuração INI
  Ini := TIniFile.Create(CaminhoINI);
  ListaChaves := TStringList.Create;
  try
    Secao := 'ParadaBackup';

    // Listar todas as chaves existentes
    Ini.ReadSection(Secao, ListaChaves);

    // Remover todas as chaves que começam com 'Lorigem'
    for i := 0 to ListaChaves.Count - 1 do
    begin
      if Pos('S1Lorigem', ListaChaves[i]) = 1 then
        Ini.DeleteKey(Secao, ListaChaves[i]);
    end;

    // Salvar os novos valores
    Ini.WriteString(Secao, 'GDcaminho', FileNameEdit3.FileName);
    Ini.WriteString(Secao, 'S1winrar', FileNameEdit1.FileName);
    Ini.WriteString(Secao, 'S1Ldestino', DirectoryEdit3.Text);

    // Salvar cada linha do Memo1 no INI com os nomes Lorigem1, Lorigem2, etc.
    for i := 0 to Memo1.Lines.Count - 1 do
      Ini.WriteString(Secao, 'S1Lorigem' + IntToStr(i + 1), Memo1.Lines[i]);

  finally
    ListaChaves.Free;
    Ini.Free;
  end;

  // Exibe uma mensagem de confirmação
  ShowMessage('Configuração salva com sucesso!');
end;

procedure TForm12.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI, Linha: string;
  i: Integer;
begin
  // Define o caminho do arquivo .INI dentro da pasta Config
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  // Verifica se o arquivo .INI existe antes de tentar ler
  if not FileExists(CaminhoINI) then Exit;

  // Abre o arquivo .INI para leitura
  Ini := TIniFile.Create(CaminhoINI);
  try
    // Lê os valores do arquivo .INI e preenche os componentes
    FileNameEdit3.FileName := Ini.ReadString('ParadaBackup', 'GDcaminho', '');
    FileNameEdit1.FileName := Ini.ReadString('ParadaBackup', 'S1winrar', '');    
    DirectoryEdit3.Text := Ini.ReadString('ParadaBackup', 'S1Ldestino', '');

    // Limpa o Memo antes de adicionar as novas linhas
    Memo1.Lines.Clear;

    // Lê as linhas Lorigem1, Lorigem2, etc., até encontrar uma chave inexistente
    i := 1;
    repeat
      Linha := Ini.ReadString('ParadaBackup', 'S1Lorigem' + IntToStr(i), '');
      if Linha <> '' then
        Memo1.Lines.Add(Linha);
      Inc(i);
    until Linha = '';

  finally
    // Libera a memória
    Ini.Free;
  end;
end;

procedure TForm12.DirectoryEdit1Change(Sender: TObject);
begin
  if DirectoryEdit1.Text <> '' then
  begin
    if Memo1.Lines.IndexOf(DirectoryEdit1.Text) = -1 then
      Memo1.Lines.Add(DirectoryEdit1.Text);
      DirectoryEdit1.Clear ;
  end;
end;

procedure TForm12.Memo1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  CharIndex, LineIndex, LineStart: Integer;
  CursorPos: TPoint;
begin
  if Button = mbLeft then
  begin
    // Evita erro em memo vazio
    if Memo1.Lines.Count = 0 then
      Exit;

    CursorPos := Point(X, Y);

    // Obtém o índice do caractere sob o cursor
    CharIndex := Memo1.Perform(EM_CHARFROMPOS, 0, LPARAM(@CursorPos));
    CharIndex := CharIndex and $FFFF; // Remove parte alta (linha), previne erro no Delphi 12+

    // Verifica se está dentro do texto válido
    if (CharIndex < 0) or (CharIndex >= Memo1.GetTextLen) then
      Exit;

    // Obtém a linha onde está o caractere
    LineIndex := Memo1.Perform(EM_LINEFROMCHAR, CharIndex, 0);

    if (LineIndex < 0) or (LineIndex >= Memo1.Lines.Count) then
      Exit;

    // Seleciona toda a linha
    LineStart := Memo1.Perform(EM_LINEINDEX, LineIndex, 0);
    Memo1.SelStart := LineStart;
    Memo1.SelLength := Length(Memo1.Lines[LineIndex]);
  end;
end;

procedure TForm12.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LineIndex: Integer;
begin
  if Key = VK_DELETE then
  begin
    // Obtém o índice da linha selecionada
    LineIndex := Memo1.Perform(EM_LINEFROMCHAR, Memo1.SelStart, 0);

    if (LineIndex >= 0) and (LineIndex < Memo1.Lines.Count) then
    begin
      // Remove a linha selecionada
      Memo1.Lines.Delete(LineIndex);
      
      // Evita que a tecla DELETE continue sendo processada
      Key := 0;
    end;
  end;

end;

procedure TForm12.Memo1DblClick(Sender: TObject);
begin
//
end;

procedure TForm12.Memo1Exit(Sender: TObject);
var
  i: Integer;
begin
  i := 0;
  while i < Memo1.Lines.Count do
  begin
    if Trim(Memo1.Lines[i]) = '' then
      Memo1.Lines.Delete(i) // Remove a linha vazia
    else
      Inc(i); // Apenas incrementa se não remover, para evitar saltos
  end;

end;

procedure TForm12.BitBtn3Click(Sender: TObject);
begin
Form1.BackupLocalS1(Self);
end;

procedure TForm12.FilenameEdit2Change(Sender: TObject);
begin
  if FileNameEdit2.Text <> '' then
  begin
    if Memo1.Lines.IndexOf(FileNameEdit2.Text) = -1 then
      Memo1.Lines.Add(FileNameEdit2.Text);
      FileNameEdit2.Clear ;
  end;
end;

end.
