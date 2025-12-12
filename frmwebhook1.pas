unit frmwebhook1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus,  Registry;


type
  TForm10 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label2: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm10.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm10.BitBtn2Click(Sender: TObject);
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
    Ini.WriteString('Servidor 1', 'carfinder', Edit6.Text);
    Ini.WriteString('Servidor 2', 'carfinder', Edit7.Text);
    Ini.WriteString('Servidor 3', 'carfinder', Edit8.Text );
  finally
    // Liberar a memória
    Ini.Free;
  end;

  // Exibe uma mensagem de confirmação
  ShowMessage('Configuração salva com sucesso!');
end;

procedure TForm10.FormCreate(Sender: TObject);
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
    Edit6.Text := Ini.ReadString('Servidor 1', 'carfinder', '');
    Edit7.Text := Ini.ReadString('Servidor 2', 'carfinder', '');
    Edit8.Text := Ini.ReadString('Servidor 3', 'carfinder', '');
  finally
    // Libera a memória
    Ini.Free;
  end;

  //checkbox S1
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', False) then
    begin
      if Reg.ValueExists('Not_CarFinderS1') then
        CheckBox2.Checked := Reg.ReadBool('Not_CarFinderS1');
    end;
  finally
    Reg.Free;
  end;

  //checkbox S2
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', False) then
    begin
      if Reg.ValueExists('Not_CarFinderS2') then
        CheckBox3.Checked := Reg.ReadBool('Not_CarFinderS2');
    end;
  finally
    Reg.Free;
  end;

  //checkbox S3
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', False) then
    begin
      if Reg.ValueExists('Not_CarFinderS3') then
        CheckBox1.Checked := Reg.ReadBool('Not_CarFinderS3');
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm10.CheckBox1Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', True) then
    begin
      Reg.WriteBool('Not_CarFinderS3', CheckBox1.Checked);
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm10.CheckBox3Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', True) then
    begin
      Reg.WriteBool('Not_CarFinderS2', CheckBox3.Checked);
    end;
  finally
    Reg.Free;
  end;

end;

procedure TForm10.CheckBox2Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', True) then
    begin
      Reg.WriteBool('Not_CarFinderS1', CheckBox2.Checked);
    end;
  finally
    Reg.Free;
  end;
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

procedure TForm10.Edit6Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit6.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit6.SetFocus;
  end;
end;

procedure TForm10.Edit7Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit7.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit7.SetFocus;
  end;
end;

procedure TForm10.Edit8Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit8.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit8.SetFocus;
  end;
end;

end.
