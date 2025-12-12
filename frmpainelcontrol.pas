unit frmpainelcontrol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, ComCtrls, ENumEd, Mask, IniFiles,
  RxToolEdit, RxCurrEdit;

type
  TForm16 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    IntervaloDayz: TRxCalcEdit;
    UEdit3: TRxCalcEdit;
    Label2: TLabel;
    EncServidor: TRxCalcEdit;
    Edit1: TRxCalcEdit;
    UEdit5: TRxCalcEdit;
    AtualizaArquivo: TRxCalcEdit;
    Label5: TLabel;
    Label4: TLabel;
    IntervaloMod: TRxCalcEdit;
    UEdit1: TRxCalcEdit;
    Label6: TLabel;
    Label7: TLabel;
    RxCalcEdit1: TRxCalcEdit;
    EncServidor1: TRxCalcEdit;
    RxCalcEdit3: TRxCalcEdit;
    AtualizaArquivo1: TRxCalcEdit;
    TabSheet3: TTabSheet;
    Label8: TLabel;
    filebackup: TRxCalcEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure EncServidorChange(Sender: TObject);
    procedure UEdit1Exit(Sender: TObject);
    procedure IntervaloModChange(Sender: TObject);
    procedure UEdit3Exit(Sender: TObject);
    procedure IntervaloDayzChange(Sender: TObject);
    procedure UEdit5Exit(Sender: TObject);
    procedure AtualizaArquivoChange(Sender: TObject);
    procedure RxCalcEdit1Exit(Sender: TObject);
    procedure EncServidor1Change(Sender: TObject);
    procedure AtualizaArquivo1Change(Sender: TObject);
    procedure RxCalcEdit3Exit(Sender: TObject);
    procedure filebackupExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form16: TForm16;

implementation

uses Unit1;



{$R *.dfm}

procedure TForm16.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=(VK_Escape) then
close;
end;

procedure TForm16.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm16.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
begin
Form1.Evfocus.ChangeColor := False;
Form1.Evfocus.ChangeFont  := False;

  //INI
  // Define o caminho do arquivo .INI dentro da pasta Config
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\parametros.ini';

  // Verifica se o arquivo .INI existe antes de tentar ler
  if not FileExists(CaminhoINI) then Exit;

  // Abre o arquivo .INI para leitura
  Ini := TIniFile.Create(CaminhoINI);
  try
    // PagControl Update Dayz
    IntervaloDayz.Text := Ini.ReadString('PARTIMEDAYZ', 'intervalodayz', '');
    EncServidor.Text := Ini.ReadString('PARTIMEDAYZ', 'encservidor', '');
    AtualizaArquivo.Text := Ini.ReadString('PARTIMEDAYZ', 'attarquivo', '');

    // PagControl Update Mod
    IntervaloMod.Text := Ini.ReadString('PARTIMEMOD', 'intervalomod', '');
    EncServidor1.Text := Ini.ReadString('PARTIMEMOD', 'encservidormod', '');
    AtualizaArquivo1.Text := Ini.ReadString('PARTIMEMOD', 'attarquivomod', '');

    // PageControl Backup file
    filebackup.Text := Ini.ReadString('PARBACKUP', 'filebackup', '');

  finally
    // Libera a memória
    Ini.Free;
  end;
end;

procedure TForm16.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini: TIniFile;
  IniPath : string;
  IntervaloMonDayz: integer;
  IntervaloMonMod: integer;
begin
Form1.EvSkinPlus1.Active := true;
Form1.Evfocus.ChangeColor := True;
Form1.Evfocus.ChangeFont  := True;

  // COMANDO PARA ALTERAR O "INTERVAL" DO TIMER DE ACORDO COM O CONFIGURADO NO .INI
  IniPath := ExtractFilePath(Application.ExeName) + 'Config\parametros.ini';
  Ini := TIniFile.Create(IniPath);
  try
   IntervaloMonDayz := Ini.ReadInteger('PARTIMEDAYZ', 'intervalodayz', 1800000); // valor padrão se não existir 30minutos
   IntervaloMonMod := Ini.ReadInteger('PARTIMEMOD', 'intervalomod', 1800000); // valor padrão se não existir 30minutos
   Form1.MonDayz.Interval := IntervaloMonDayz;
   Form1.MonMod.Interval := IntervaloMonMod;
  finally
   Ini.Free;
  end;
  // nota: Esse procedimento tambem existe no OnCreate do form1. Se alterar algum valor aqui, deve-se alterar lá!  
end;

procedure TForm16.BitBtn2Click(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI: string;
begin
  // Define o caminho do arquivo .INI dentro da pasta Config do sistema
  CaminhoINI := ExtractFilePath(ParamStr(0)) + 'Config\parametros.ini';

  // Garante que a pasta Config existe
  if not DirectoryExists(ExtractFilePath(CaminhoINI)) then
    ForceDirectories(ExtractFilePath(CaminhoINI));

  // Criar ou abrir o arquivo de configuração INI
  Ini := TIniFile.Create(CaminhoINI);
  try
    // PageControl Update Dayz
    Ini.WriteString('PARTIMEDAYZ', 'intervalodayz', IntervaloDayz.Text);
    Ini.WriteString('PARTIMEDAYZ', 'encservidor', EncServidor.Text);
    Ini.WriteString('PARTIMEDAYZ', 'attarquivo', AtualizaArquivo.Text);

    // PageControl Update Mod
    Ini.WriteString('PARTIMEMOD', 'intervalomod', IntervaloMod.Text);
    Ini.WriteString('PARTIMEMOD', 'encservidormod', EncServidor1.Text);
    Ini.WriteString('PARTIMEMOD', 'attarquivomod', AtualizaArquivo1.Text);

    // PageControl Backup file
    Ini.WriteString('PARBACKUP', 'filebackup', filebackup.Text);

  finally
    // Liberar a memória
    Ini.Free;
  end;

  // Exibe uma mensagem de confirmação
  ShowMessage('Configuração salva com sucesso!');
end;

procedure TForm16.Edit1Exit(Sender: TObject);
begin
  if Edit1.Value < 1 then
  begin
    ShowMessage('Valor não pode ser inferior a 1 minuto!');
    Edit1.SetFocus; // volta o foco para o campo
  end
  else
  begin
  EncServidor.Value := Edit1.Value * 60000;
  end;
end;

procedure TForm16.EncServidorChange(Sender: TObject);
begin
if EncServidor.Value <> 0 then
  begin
  Edit1.Value := EncServidor.Value / 60000;
  end
  else
  begin
  Edit1.Value := 0;
  end;
end;

procedure TForm16.UEdit1Exit(Sender: TObject);
begin
  if UEdit1.Value < 15 then
  begin
    ShowMessage('Valor não pode ser inferior a 15 minuto!' + #13#10 + 'Valor recomendado: 30');
    UEdit1.SetFocus; // volta o foco para o campo
  end
  else
  begin
  IntervaloMod.Value := UEdit1.Value * 60000;
  end;
end;

procedure TForm16.IntervaloModChange(Sender: TObject);
begin
if IntervaloMod.Value <> 0 then
  begin
  UEdit1.Value := IntervaloMod.Value / 60000;
  end
  else
  begin
  UEdit1.Value := 0;
  end;
end;

procedure TForm16.UEdit3Exit(Sender: TObject);
begin
  if UEdit3.Value < 15 then //15
  begin
    ShowMessage('Valor não pode ser inferior a 15 minuto!' + #13#10 + 'Valor recomendado: 30');
    UEdit3.SetFocus; // volta o foco para o campo
  end
  else
  begin
  IntervaloDayz.Value := UEdit3.Value * 60000;
  end;
end;

procedure TForm16.IntervaloDayzChange(Sender: TObject);
begin
if IntervaloDayz.Value <> 0 then
  begin
  UEdit3.Value := IntervaloDayz.Value / 60000;
  end
  else
  begin
  UEdit3.Value := 0;
  end;
end;

procedure TForm16.UEdit5Exit(Sender: TObject);
begin
  if UEdit5.Value < 1 then
  begin
    ShowMessage('Valor não pode ser inferior a 1 minuto!');
    UEdit5.SetFocus; // volta o foco para o campo
  end
  else
  begin
  AtualizaArquivo.Value := UEdit5.Value * 60000;
  end;
end;

procedure TForm16.AtualizaArquivoChange(Sender: TObject);
begin
if AtualizaArquivo.Value <> 0 then
  begin
  UEdit5.Value := AtualizaArquivo.Value / 60000;
  end
  else
  begin
  UEdit5.Value := 0;
  end;
end;

procedure TForm16.RxCalcEdit1Exit(Sender: TObject);
begin
  if RxCalcEdit1.Value < 1 then
  begin
    ShowMessage('Valor não pode ser inferior a 1 minuto!');
    RxCalcEdit1.SetFocus; // volta o foco para o campo
  end
  else
  begin
  EncServidor1.Value := RxCalcEdit1.Value * 60000;
  end;
end;

procedure TForm16.filebackupExit(Sender: TObject);
begin
  if filebackup.Value < 1 then
  begin
    ShowMessage('Valor não pode ser inferior a 1!');
    filebackup.SetFocus;
  end
end;

procedure TForm16.EncServidor1Change(Sender: TObject);
begin
if EncServidor1.Value <> 0 then
  begin
  RxCalcEdit1.Value := EncServidor1.Value / 60000;
  end
  else
  begin
  RxCalcEdit1.Value := 0;
  end;
end;

procedure TForm16.AtualizaArquivo1Change(Sender: TObject);
begin
if AtualizaArquivo1.Value <> 0 then
  begin
  RxCalcEdit3.Value := AtualizaArquivo1.Value / 60000;
  end
  else
  begin
  RxCalcEdit3.Value := 0;
  end;
end;

procedure TForm16.RxCalcEdit3Exit(Sender: TObject);
begin
  if RxCalcEdit3.Value < 1 then
  begin
    ShowMessage('Valor não pode ser inferior a 1 minuto!');
    RxCalcEdit3.SetFocus; // volta o foco para o campo
  end
  else
  begin
  AtualizaArquivo1.Value := RxCalcEdit3.Value * 60000;
  end;
end;

end.
