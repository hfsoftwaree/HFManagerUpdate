unit frmbec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus,  Registry,
  RxToolEdit, ShellAPI;


type
  TForm1234 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label2: TLabel;
    Edit6: TFilenameEdit;
    Edit7: TFilenameEdit;
    Edit8: TFilenameEdit;
    Label3: TLabel;
    Label5: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1234: TForm1234;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm1234.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm1234.BitBtn2Click(Sender: TObject);
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
    Ini.WriteString('Servidor 1', 'BEC', Edit6.Text);
    Ini.WriteString('Servidor 2', 'BEC', Edit7.Text);
    Ini.WriteString('Servidor 3', 'BEC', Edit8.Text );
  finally
    // Liberar a memória
    Ini.Free;
  end;

  // Exibe uma mensagem de confirmação
  ShowMessage('Configuração salva com sucesso!');
end;

procedure TForm1234.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
  Reg: TRegistry;  
begin
  //define o nome dos groupbox conforme nome de servidores
  //carfinder
  Label4.Caption := Form1.Servidor11.Caption;
  Label9.Caption := Form1.Servidor21.Caption;
  Label8.Caption := Form1.Servidor31.Caption;

  // Define o caminho do arquivo .INI dentro da pasta Config
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  // Verifica se o arquivo .INI existe antes de tentar ler
  if not FileExists(CaminhoINI) then Exit;

  // Abre o arquivo .INI para leitura
  Ini := TIniFile.Create(CaminhoINI);
  try
    // Salvar os valores dos componentes no arquivo .INI
    Edit6.Text := Ini.ReadString('Servidor 1', 'BEC', '');
    Edit7.Text := Ini.ReadString('Servidor 2', 'BEC', '');
    Edit8.Text := Ini.ReadString('Servidor 3', 'BEC', '');
  finally
    // Libera a memória
    Ini.Free;
  end;


end;

procedure TForm1234.Label3Click(Sender: TObject);
begin
 ShellExecute(0, 'open', 'https://github.com/TheGamingChief/BattlEye-Extended-Controls', nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1234.CheckBox2Click(Sender: TObject);

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

end.
