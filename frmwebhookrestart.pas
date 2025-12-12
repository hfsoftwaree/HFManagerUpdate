unit frmwebhookrestart;

interface

uses
  Windows, ShellAPI, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus;

type
  TForm123 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label2: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit2: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit9Exit(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
    procedure Edit11Exit(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form123: TForm123;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm123.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm123.BitBtn2Click(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI, Destino: string;
begin
  // Define o caminho do arquivo .INI dentro da pasta Config do sistema
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  // Garante que a pasta Config existe
  if not DirectoryExists(ExtractFilePath(CaminhoINI)) then
    ForceDirectories(ExtractFilePath(CaminhoINI));

  // Criar ou abrir o arquivo de configuração INI
  Ini := TIniFile.Create(CaminhoINI);
  try
    // Salvar os valores dos componentes no arquivo .INI
    Ini.WriteString('RESTARTWH', 'avisoS1', Edit9.Text);
    Ini.WriteString('RESTARTWH', 'avisoS2', Edit10.Text);
    Ini.WriteString('RESTARTWH', 'avisoS3', Edit11.Text );
    Ini.WriteString('RESTARTWH', 'mensagem', Edit1.Text );
    Ini.WriteString('RESTARTWH', 'mensagem1', Edit2.Text );
    Ini.WriteString('RESTARTWH', 'time', ComboBox1.Text );

  finally
    // Liberar a memória
    Ini.Free;
  end;

  // Exibe uma mensagem de confirmação
  ShowMessage('Configuração salva com sucesso!');
end;

procedure TForm123.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
begin
  //define o nome dos groupbox conforme nome de servidores
  //koth
  Label10.Caption := 'Webhook ' + Form1.Servidor11.Caption;
  Label12.Caption := 'Webhook ' + Form1.Servidor21.Caption;
  Label11.Caption := 'Webhook ' + Form1.Servidor31.Caption;

  // Define o caminho do arquivo .INI dentro da pasta Config
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  // Verifica se o arquivo .INI existe antes de tentar ler
  if not FileExists(CaminhoINI) then Exit;

  // Abre o arquivo .INI para leitura
  Ini := TIniFile.Create(CaminhoINI);
  try
    // Salvar os valores dos componentes no arquivo .INI
    Edit9.Text := Ini.ReadString('RESTARTWH', 'avisoS1', '');
    Edit10.Text := Ini.ReadString('RESTARTWH', 'avisoS2', '');
    Edit11.Text := Ini.ReadString('RESTARTWH', 'avisoS3', '');
    Edit1.Text := Ini.ReadString('RESTARTWH', 'mensagem', '');
    Edit2.Text := Ini.ReadString('RESTARTWH', 'mensagem1', '');
    ComboBox1.Text := Ini.ReadString('RESTARTWH', 'time', '');
  finally
    // Libera a memória
    Ini.Free;
  end;
end;

procedure TForm123.Label5Click(Sender: TObject);
begin

end;

//Valida campo webhook
function ValidarWebhook(const URL: string): Boolean;
begin
  // Permite campo vazio (não envia mensagem se estiver em branco)
  if Trim(URL) = '' then
  begin
    Result := True; // Campo vazio é considerado válido
    Exit;
  end;

  // Verifica se é um webhook do Discord
  Result := Pos('https://discord.com/api/webhooks/', LowerCase(URL)) = 1;
end;

procedure TForm123.Edit9Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit9.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit9.SetFocus;
  end;
end;

procedure TForm123.Edit10Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit10.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit10.SetFocus;
  end;
end;

procedure TForm123.Edit11Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit11.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit11.SetFocus;
  end;
end;

end.
