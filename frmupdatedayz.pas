unit frmupdatedayz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, Mask, IniFiles, FileCtrl, Menus,
  RxToolEdit;

type
  TForm8 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    DirectoryEdit3: TDirectoryEdit;
    BitBtn3: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    DirectoryEdit1: TDirectoryEdit;
    Label4: TLabel;
    Label6: TLabel;
    DirectoryEdit2: TDirectoryEdit;
    DirectoryEdit4: TDirectoryEdit;
    Label7: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm8.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm8.BitBtn2Click(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
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
    Ini.WriteString('UpdateDayz', 'origem', DirectoryEdit3.Text);
    Ini.WriteString('UpdateDayz', 'mpmissioncherno', DirectoryEdit1.Text);
    Ini.WriteString('UpdateDayz', 'mpmissionlivonia', DirectoryEdit2.Text);
    Ini.WriteString('UpdateDayz', 'mpmissionsakhal', DirectoryEdit4.Text);

  finally
    // Liberar a memória
    Ini.Free;
  end;

  // Exibe uma mensagem de confirmação
  ShowMessage('Configuração salva com sucesso!');

end;

procedure TForm8.FormCreate(Sender: TObject);
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
    // Lê os valores do arquivo .INI e preenche os componentes
    DirectoryEdit3.Text := Ini.ReadString('UpdateDayz', 'origem', '');
    DirectoryEdit1.Text := Ini.ReadString('UpdateDayz', 'mpmissioncherno', '');
    DirectoryEdit2.Text := Ini.ReadString('UpdateDayz', 'mpmissionlivonia', '');
    DirectoryEdit4.Text := Ini.ReadString('UpdateDayz', 'mpmissionsakhal', '');


  finally
    // Libera a memória
    Ini.Free;
  end;
end;

procedure TForm8.BitBtn3Click(Sender: TObject);
begin
    if Application.MessageBox('Ao prosseguir, o sistema ficará bloqueado até o término do processo. Não tente fechar o sistema. Deseja verificar atualização do DAYZ agora?',
    'Confirmação', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    Form1.MonDayzTimer(nil); // Chama a função manualmente
  end;
end;

end.
