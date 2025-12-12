unit frmwebhoook;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus, StrUtils;

type
  TForm9 = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn2: TBitBtn;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Edit6: TEdit;
    Label8: TLabel;
    Edit7: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Panel2: TPanel;
    Label11: TLabel;
    Edit10: TEdit;
    Label12: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm9.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm9.BitBtn2Click(Sender: TObject);
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
    Ini.WriteString('Servidor 1', 'webhookavisos', Edit1.Text);
    Ini.WriteString('Servidor 2', 'webhookavisos', Edit2.Text);
    Ini.WriteString('Servidor 3', 'webhookavisos', Edit3.Text );

    Ini.WriteString('UpdateDayz', 'webhookinfodayz', Edit4.Text);
    Ini.WriteString('UpdateMod', 'webhookinfomod', Edit5.Text);
    Ini.WriteString('UpdateDayz', 'mensagemdayz', Edit7.Text);
    Ini.WriteString('UpdateMod', 'mensagemmod', Edit6.Text);
    Ini.WriteString('UpdateDayz', 'mensagemdayz1', Edit9.Text);
    Ini.WriteString('UpdateMod', 'mensagemmod1', Edit8.Text);
    Ini.WriteString('UpdateDayz', 'mensagemdayzadm1', Edit10.Text);

  finally
    // Liberar a memória
    Ini.Free;
  end;

  // Exibe uma mensagem de confirmação
  ShowMessage('Configuração salva com sucesso!');
end;

procedure TForm9.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
begin
  //define o nome dos groupbox conforme nome de servidores
  //updateavisos
  Label2.Caption := 'Webhook ' + Form1.Servidor11.Caption;
  Label6.Caption := 'Webhook ' + Form1.Servidor21.Caption;
  Label3.Caption := 'Webhook ' + Form1.Servidor31.Caption;
  //end

  //Define o caminho do arquivo .INI dentro da pasta Config
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  // Verifica se o arquivo .INI existe antes de tentar ler
  if not FileExists(CaminhoINI) then Exit;
  // Abre o arquivo .INI para leitura
  Ini := TIniFile.Create(CaminhoINI);
  try
    // Salvar os valores dos componentes no arquivo .INI
    Edit1.Text := Ini.ReadString('Servidor 1', 'webhookavisos', '');
    Edit2.Text := Ini.ReadString('Servidor 2', 'webhookavisos', '');
    Edit3.Text := Ini.ReadString('Servidor 3', 'webhookavisos', '');

    Edit4.Text := Ini.ReadString('UpdateDayz', 'webhookinfodayz', '');
    Edit5.Text := Ini.ReadString('UpdateMod', 'webhookinfomod', '');
    Edit7.Text := Ini.ReadString('UpdateDayz', 'mensagemdayz', '');
    Edit6.Text := Ini.ReadString('UpdateMod', 'mensagemmod', '');
    Edit9.Text := Ini.ReadString('UpdateDayz', 'mensagemdayz1', '');
    Edit8.Text := Ini.ReadString('UpdateMod', 'mensagemmod1', '');
    Edit10.Text := Ini.ReadString('UpdateDayz', 'mensagemdayzadm1', '');
  finally
    // Libera a memória
    Ini.Free;
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

procedure TForm9.Edit1Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit1.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit1.SetFocus;
  end;
end;

procedure TForm9.Edit2Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit2.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit2.SetFocus;
  end;
end;

procedure TForm9.Edit3Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit3.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit3.SetFocus;
  end;
end;

procedure TForm9.Edit4Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit4.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit4.SetFocus;
  end;
end;

procedure TForm9.Edit5Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit5.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit5.SetFocus;
  end;
end;

procedure TForm9.Edit10Exit(Sender: TObject);
begin
  if not ValidarWebhook(Edit10.Text) then
  begin
    ShowMessage('Webhook inválido. Deixe em branco ou insira uma URL válida');
    Edit10.SetFocus;
  end;
end;

end.
