unit frmsteam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus,  Registry,
  RxToolEdit, ShellAPI, System.NetEncoding, EPaswd;


type
  Tfrmsteamlogin = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit6: TFilenameEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit6BeforeDialog(Sender: TObject; var AName: string;
      var Action: Boolean);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmsteamlogin: Tfrmsteamlogin;

implementation

uses Unit1;

{$R *.dfm}
//codifica pass
function EncodeSenha(const Senha: string): string;
var
  i: Integer;
  Tmp: string;
begin
  Tmp := '';
  for i := 1 to Length(Senha) do
    Tmp := Tmp + Chr(Ord(Senha[i]) xor $5A); // XOR com 0x5A
  Result := TNetEncoding.Base64.Encode(Tmp);
end;

//decodifica
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

procedure Tfrmsteamlogin.BitBtn2Click(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
  loginIni, senhaIni, steamcmdIni: string;
  resp: Integer;
begin
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  if not DirectoryExists(ExtractFilePath(CaminhoINI)) then
    ForceDirectories(ExtractFilePath(CaminhoINI));

  Ini := TIniFile.Create(CaminhoINI);
  try
    loginIni := Ini.ReadString('STEAM', 'login', '');
    senhaIni := Ini.ReadString('STEAM', 'senha', '');
    steamcmdIni := Ini.ReadString('STEAM', 'steamcmdexe', '');

    // Se o valor do steamcmdexe mudou, salva ele direto e sai
    if steamcmdIni <> Edit6.Text then
    begin
      Ini.WriteString('STEAM', 'steamcmdexe', Edit6.Text);
      ShowMessage('Configuração salva com sucesso!');
      Exit;
    end;

    // Se INI estiver vazio para login ou senha, salva direto
    if (loginIni = '') or (senhaIni = '') then
    begin
      Ini.WriteString('STEAM', 'login', EncodeSenha(Edit1.Text));
      Ini.WriteString('STEAM', 'senha', EncodeSenha(Edit2.Text));
      ShowMessage('Configuração salva com sucesso!');
      Edit1.Text := Ini.ReadString('STEAM', 'login', '');
      Edit2.Text := Ini.ReadString('STEAM', 'senha', '');
      Exit;
    end;

    // Se os valores codificados do Edit são diferentes dos do INI, pede confirmação
    if (loginIni <> Edit1.Text) or (senhaIni <> Edit2.Text) then
    begin
      resp := MessageDlg(
        'Por motivo de segurança, antes de qualquer alteração as credenciais antigas precisam ser apagadas internamente. Confirma?',
        mtConfirmation, [mbYes, mbNo], 0);
      if resp = mrYes then
      begin
        Ini.DeleteKey('STEAM', 'login');
        Ini.DeleteKey('STEAM', 'senha');
        Edit1.Clear;
        Edit2.Clear;
        ShowMessage('Dados removidos com sucesso! Insira os novos valores.');
        Edit1.SetFocus;
      end
      else
        Exit; // Cancelou
    end
    else
    begin
      // Valores iguais, não altera nem mostra mensagem
      Exit;
    end;
  finally
    Ini.Free;
  end;
end;

procedure Tfrmsteamlogin.BitBtn3Click(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
  loginIni, senhaIni: string;
  resp: Integer;
begin
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  if not DirectoryExists(ExtractFilePath(CaminhoINI)) then
    ForceDirectories(ExtractFilePath(CaminhoINI));

  Ini := TIniFile.Create(CaminhoINI);
  try
  // Se os valores codificados do Edit são diferentes dos do INI, pede confirmação
  if (loginIni <> Edit1.Text) or (senhaIni <> Edit2.Text) then
  begin
    resp := MessageDlg(
      'Por motivo de segurança, as credenciais antigas precisam ser apagadas internamente. Confirma?',
      mtConfirmation, [mbYes, mbNo], 0);

    if resp = mrYes then
    begin
      Ini.DeleteKey('STEAM', 'login');
      Ini.DeleteKey('STEAM', 'senha');
      Edit1.Clear;
      Edit2.Clear;

      ShowMessage('Dados removidos com sucesso! Insira os novos valores.');
      Edit1.SetFocus;
    end
    else
      Exit; // Cancelou
  end
  else
  begin
    // Valores iguais, não altera nem mostra mensagem
    Exit;
  end;
  finally
  Ini.Free; // Libera o Ini depois de tudo
  end;
end;

procedure Tfrmsteamlogin.Edit6BeforeDialog(Sender: TObject; var AName: string;
  var Action: Boolean);
begin
Edit6.Dialog.InitialDir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)) + 'steamcmd');
end;

procedure Tfrmsteamlogin.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure Tfrmsteamlogin.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
begin
  // Define o caminho do arquivo .INI dentro da pasta Config
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  // Verifica se o arquivo .INI existe antes de tentar ler
  if not FileExists(CaminhoINI) then Exit;

  // Abre o arquivo .INI para leitura
  Ini := TIniFile.Create(CaminhoINI);
  try
    Edit6.Text := Ini.ReadString('STEAM', 'steamcmdexe', '');
    Edit1.Text := Ini.ReadString('STEAM', 'login', '');
    Edit2.Text := Ini.ReadString('STEAM', 'senha', '');

    // Desembaralha a senha antes de mostrar
    // Edit2.Text := DecodeSenha(Ini.ReadString('STEAM', 'senha', ''));
  finally
    Ini.Free;
  end;
end;


end.
