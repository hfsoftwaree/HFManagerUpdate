unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,  ShellAPI, TlHelp32, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, DateUtils, FileCtrl,
  Buttons, EGrad, Inifiles,  Registry, RxGIF, jpeg,
  EKeyNav, EFocCol, EHintBal, EAppProt,Math, IdHTTP, IdSSLOpenSSL, IdGlobal, StrUtils,
  IdCTypes, IdSSLOpenSSLHeaders, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMultipartFormData,
  EXPStyle, RxAppEvent, ETrayIc, IOUtils, Generics.Defaults,
  Types,
  Generics.Collections, EAppUpd, Vcl.ComCtrls, EStBar, ESkinPlus, System.NetEncoding, EPaswd,
  Winapi.ActiveX, ComObj,System.Threading, PsAPI;

var
  FirstRun1: Boolean = True; // Indica se é a primeira execução do timer FinderCarServer1
  FirstRun2: Boolean = True; // Indica se é a primeira execução do timer FinderCarServer2
  FirstRun3: Boolean = True; // Indica se é a primeira execução do timer FinderCarServer3

  //usado pelo carfinders3 na leitura so script.log koth
  UltimaPosicao: Integer = 0;

  //atualizacao do sistema menu verificar atualizacao
  //AtualizacaoChamadaViaMenu: Boolean;
  AtualizacaoChamadaViaMenu: Boolean = False;
  AtualizacaoChamadaViaOnActivate: Boolean = False;
  AtualizacaoChamadaViaTimer: Boolean = False;
  //usado no steamcmd monitora mod steam
  EmExecucao: Boolean = False;


const
  WM_TRAYICON = WM_USER + 1; // Define uma mensagem personalizada para a bandeja do sistema


  //checkbox iniciar com windows

  REG_KEY = 'Software\Microsoft\Windows\CurrentVersion\Run';

  APP_NAME = 'MeuSistema';



type
  TForm1 = class(TForm)
    Startgoogle: TTimer;
    Closegoogle: TTimer;
    EncServidor: TTimer;
    StartServidor1: TTimer;
    Event: TAppEvents;
    MonServer: TTimer;
    MainMenu1: TMainMenu;
    Sobre1: TMenuItem;
    Movelog: TTimer;
    FinderCarServer1: TTimer;
    Configuracao1: TMenuItem;
    Servidor11: TMenuItem;
    Servidor21: TMenuItem;
    Servidor31: TMenuItem;
    N1: TMenuItem;
    Menu1: TMenuItem;
    AlterarnomeServidor11: TMenuItem;
    AlterarnomeServidor21: TMenuItem;
    AlterarnomeServidor31: TMenuItem;
    Panel1: TPanel;
    BitBtn4: TBitBtn;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel3: TPanel;
    CheckBox2: TCheckBox;
    Image1: TImage;
    EvAppProtect1: TEvAppProtect;
    Evfocus: TEvFocusColor;
    EvKeyNavigator1: TEvKeyNavigator;
    PauseMon: TBitBtn;
    Label1: TLabel;
    Diretrios1: TMenuItem;
    Restart1: TMenuItem;
    N2: TMenuItem;
    UpdateMOD1: TMenuItem;
    UpdateDayz1: TMenuItem;
    MonMod: TTimer;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    FinderCarServer2: TTimer;
    FinderCarServer3: TTimer;
    Restart: TTimer;
    MonDayz: TTimer;
    Webhook1: TMenuItem;
    WinXP2: TEvXPStyle;
    Update1: TMenuItem;
    CarFinder1: TMenuItem;
    KOTH1: TMenuItem;
    backup1: TMenuItem;
    Servidor12: TMenuItem;
    Servidor22: TMenuItem;
    Servidor32: TMenuItem;
    backuplocal: TTimer;
    Parametros1: TMenuItem;
    Paineldecontrole1: TMenuItem;
    CrashLog1: TMenuItem;
    Serverconsolelog1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Panel4: TPanel;
    Label2: TLabel;
    Link: TLabel;
    Timer1: TTimer;
    ServerDZ1: TMenuItem;
    Servidor13: TMenuItem;
    Servidor23: TMenuItem;
    Servidor33: TMenuItem;
    N6: TMenuItem;
    EvAppUpdate1: TEvAppUpdate;
    Sobreaverso1: TMenuItem;
    Verificaratualizao1: TMenuItem;
    EvSkinPlus1: TEvSkinPlus;
    N5: TMenuItem;
    Restart2: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    EvHintBalloon1: TEvHintBalloon;
    ltimasatualizaes1: TMenuItem;
    Sobreosistema1: TMenuItem;
    N7: TMenuItem;
    BEC1: TMenuItem;
    N8: TMenuItem;
    SteamWorkshop1: TMenuItem;
    Baixarmod1: TMenuItem;
    Loginsteam1: TMenuItem;
    Integrao1: TMenuItem;
    N9: TMenuItem;
    Instalarsteamcmd1: TMenuItem;
    N10: TMenuItem;
    CheckBox4: TCheckBox;
    N11: TMenuItem;
    GerenciarMODbaixado1: TMenuItem;
    Donate1: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    CarDestroyedMCK1: TMenuItem;
    TimerMonitor: TTimer;
    BitBtn5: TBitBtn;
    procedure ClosegoogleTimer(Sender: TObject);
    procedure EncServidorTimer(Sender: TObject);
    procedure StartServidor1Timer(Sender: TObject);
    procedure StartgoogleTimer(Sender: TObject);
    procedure EventMinimize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure MonServerTimer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure MovelogTimer(Sender: TObject);
    procedure Servidor11Click(Sender: TObject);
    procedure AlterarnomeServidor11Click(Sender: TObject);
    procedure AlterarnomeServidor21Click(Sender: TObject);
    procedure AlterarnomeServidor31Click(Sender: TObject);
    procedure Configuracao1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Servidor21Click(Sender: TObject);
    procedure Servidor31Click(Sender: TObject);
    procedure PauseMonClick(Sender: TObject);
    procedure Restart1Click(Sender: TObject);
    procedure UpdateMOD1Click(Sender: TObject);
    procedure UpdateDayz1Click(Sender: TObject);
    procedure MonModTimer(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure FinderCarServer1Timer(Sender: TObject);
    procedure FinderCarServer2Timer(Sender: TObject);
    procedure FinderCarServer3Timer(Sender: TObject);
    procedure RestartTimer(Sender: TObject);
    procedure MonDayzTimer(Sender: TObject);
    procedure Update1Click(Sender: TObject);
    procedure CarFinder1Click(Sender: TObject);
    procedure KOTH1Click(Sender: TObject);
    procedure Servidor12Click(Sender: TObject);
    procedure Servidor22Click(Sender: TObject);
    procedure Servidor32Click(Sender: TObject);
//    procedure Button2Click(Sender: TObject);
//    procedure Button3Click(Sender: TObject);
//    procedure Button4Click(Sender: TObject);
    procedure backuplocalTimer(Sender: TObject);
    procedure BackupLocalS1(Sender: TObject);
    procedure BackupLocalS2(Sender: TObject);
    procedure BackupLocalS3(Sender: TObject);
    procedure Paineldecontrole1Click(Sender: TObject);
    procedure CrashLog1Click(Sender: TObject);
    procedure Serverconsolelog1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Servidor13Click(Sender: TObject);
    procedure Parametros1Click(Sender: TObject);
    procedure Servidor23Click(Sender: TObject);
    procedure EvKeyNavigator1KeyPress(Sender: TObject; Key: Word;
      var Action: TEvNavAction);
    procedure Servidor33Click(Sender: TObject);
    procedure EvAppUpdate1DownloadProgress(Sender: TObject; BytesTotal,
      BytesReceived: Double);
    procedure EvAppUpdate1Error(Sender: TObject; Error: TEvUpdateError);
    procedure EvAppUpdate1RequestLogout(Sender: TObject);
    procedure Verificaratualizao1Click(Sender: TObject);
    procedure Sobreaverso1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EvAppUpdate1AppIsUpdated(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Restart2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure ltimasatualizaes1Click(Sender: TObject);
    procedure BEC1Click(Sender: TObject);
    procedure Baixarmod1Click(Sender: TObject);
    procedure Loginsteam1Click(Sender: TObject);
    procedure MonitorarMods;
    procedure CheckBox4Click(Sender: TObject);
    procedure Instalarsteamcmd1Click(Sender: TObject);
    procedure GerenciarMODbaixado1Click(Sender: TObject);
    procedure Integrao1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure Donate1Click(Sender: TObject);
    procedure CarDestroyedMCK1Click(Sender: TObject); //processo criar bat para att mods
    procedure VerificarVeiculosDestruidosS1;
    procedure VerificarVeiculosDestruidosS2;
    procedure VerificarVeiculosDestruidosS3;
    procedure TimerMonitorTimer(Sender: TObject);


  private
    //Declara a função para remover o ícone
    procedure RemoveTrayIcon;
    //muda nome menu
    procedure AlterarNomeServidor(MenuItem: TMenuItem); // Método privado para alterar o nome
    procedure SalvarNomesServidores;
    procedure CarregarNomesServidores;
    //end
    function ModUsadoNoBat(ModName: string; ServidorIndex: Integer): Boolean;
    //metodo para menu baixar mod
    procedure IniciarVerificacaoDLL;
    procedure ContinuarAposDownload(Sender: TObject);
    procedure AbrirFormWebSteam;
    //end
    //metodo para menu gerenciar mod
    procedure IniciarVerificacaoDLL1;
    procedure ContinuarAposDownload1(Sender: TObject);
    procedure AbrirFormWebSteam1;
    //end


  protected
    procedure WndProc(var Msg: TMessage); override; // Declaração correta de WndProc
  public
    procedure ShowTrayIcon; // Declara a função que cria o ícone da bandeja
  end;

var
  Form1: TForm1;
  TrayIconData: TNotifyIconDataW;
  TrayMenu: TPopupMenu;
  UltimoMinutoEnviado: Integer = -1; //usado em EnviarAvisoRestartDiscord

implementation

uses frmsobre, frmconfig, frmconfig2, frmconfig3, frmrestart, frmupdatemod,
  frmupdatedayz, frmwebhoook, frmwebhook1, frmwebhook2, frmbackup,
  frmbackup1, frmbackup2, frmsobreatt, frmpainelcontrol, frmcrashlog,
  frmserverconsole, frmserverconfig, frmserverconfig1, frmserverconfig2,
  frmwebhookrestart, frmbec, frmwebsteam, frmsteam, frmgerenciamod, frmdonate1,
  frmcardestroyed1;

{$R *.dfm}
//GERA LOG NA PASTA TEMP PARA PEGAR O PROPRIETARIO DO VEICULO PARA INFORMAR NO CARFINDER AO INCIAR O SERVIDOR
function ReadIniValueS2(const Section, Key: string): string;
var
  Ini: TIniFile;
  IniPath: string;
begin
  Result := '';
  IniPath := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  if not FileExists(IniPath) then Exit;
  Ini := TIniFile.Create(IniPath);
  try
    Result := Ini.ReadString(Section, Key, '');
  finally
    Ini.Free;
  end;
end;

function EncontrarLogMCKAtivoS2(const ProfileDir: string): string;
var
  SR: TSearchRec;
begin
  Result := '';

  if FindFirst(ProfileDir + '\*.log', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) = 0 then
      begin
        if Pos('mck', LowerCase(SR.Name)) > 0 then
        begin
          Result := ProfileDir + '\' + SR.Name;
          Break;
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure RemoverVeiculosDestruidosS2;
var
  ProfileDir, LogMCK, ArqDonos: string;
  LinhasLog, Donos: TStringList;
  i: Integer;
  Linha, IDVeiculo: string;

  function ExtrairEntre(const S, A, B: string): string;
  var
    p1, p2: Integer;
  begin
    Result := '';
    p1 := Pos(A, S);
    if p1 = 0 then Exit;
    p1 := p1 + Length(A);
    p2 := Pos(B, Copy(S, p1, MaxInt));
    if p2 = 0 then Exit;
    Result := Copy(S, p1, p2 - 1);
  end;

begin
  ProfileDir := ReadIniValueS2('Servidor 2', 'Profile');
  if ProfileDir = '' then Exit;

  LogMCK := EncontrarLogMCKAtivoS2(ProfileDir);
  if LogMCK = '' then Exit;

  ArqDonos := ExtractFilePath(ParamStr(0)) +
              'temp\vehicle_owners_s2.txt';

  if not FileExists(ArqDonos) then Exit;

  LinhasLog := TStringList.Create;
  Donos     := TStringList.Create;
  try
    LinhasLog.LoadFromFile(LogMCK);
    Donos.LoadFromFile(ArqDonos);

    // varre o log procurando veículos destruídos
    for i := 0 to LinhasLog.Count - 1 do
    begin
      Linha := LinhasLog[i];

      if Pos('has been destroyed', Linha) > 0 then
      begin
        IDVeiculo := ExtrairEntre(Linha, '(ID: ', ' - pos');

        if (IDVeiculo <> '') and
           (Donos.IndexOfName(IDVeiculo) <> -1) then
        begin
          Donos.Delete(Donos.IndexOfName(IDVeiculo));
        end;
      end;
    end;

    Donos.SaveToFile(ArqDonos);

  finally
    LinhasLog.Free;
    Donos.Free;
  end;
end;


function CompararPorIDS2(List: TStringList; Index1, Index2: Integer): Integer;
var
  ID1, ID2: Integer;
begin
  ID1 := StrToIntDef(List.Names[Index1], 0);
  ID2 := StrToIntDef(List.Names[Index2], 0);
  Result := ID1 - ID2;
end;

procedure GerarArquivoProprietariosVeiculosS2;
var
  ProfileDir, LogMCK, ArqSaida: string;
  Linhas, Donos: TStringList;
  i: Integer;
  Linha, IDVeiculo, NomePlayer: string;

  function ExtrairEntre(const S, A, B: string): string;
  var
    p1, p2: Integer;
  begin
    Result := '';
    p1 := Pos(A, S);
    if p1 = 0 then Exit;
    p1 := p1 + Length(A);
    p2 := Pos(B, Copy(S, p1, MaxInt));
    if p2 = 0 then Exit;
    Result := Copy(S, p1, p2 - 1);
  end;

begin
  ProfileDir := ReadIniValueS2('Servidor 2', 'Profile');
  if ProfileDir = '' then Exit;

  LogMCK := EncontrarLogMCKAtivoS2(ProfileDir);
  if LogMCK = '' then Exit;

  ArqSaida := ExtractFilePath(ParamStr(0)) +
              'temp\vehicle_owners_s2.txt';

  Linhas := TStringList.Create;
  Donos  := TStringList.Create;
  try
    Donos.NameValueSeparator := '=';

    // ✅ Carrega cache existente (se houver)
    if FileExists(ArqSaida) then
      Donos.LoadFromFile(ArqSaida);

    // ✅ Lê log MCK atual
    Linhas.LoadFromFile(LogMCK);

    // ✅ leitura reversa → último motorista manda
    for i := Linhas.Count - 1 downto 0 do
    begin
      Linha := Linhas[i];

      if Pos('entered in vehicle', Linha) > 0 then
      begin
        IDVeiculo  := ExtrairEntre(Linha, '(ID: ', ')');
        NomePlayer := ExtrairEntre(Linha, 'Player ', ' (');

        if (IDVeiculo <> '') and (NomePlayer <> '') then
        begin
          // ✅ atualiza ou insere (sem perder dados antigos)
          Donos.Values[IDVeiculo] := NomePlayer;
        end;
      end;
    end;

    Donos.CustomSort(CompararPorIDS2);
    ForceDirectories(ExtractFilePath(ArqSaida));
    Donos.SaveToFile(ArqSaida);

  finally
    Linhas.Free;
    Donos.Free;
  end;
end;


//CAR DESTROYED
procedure TForm1.VerificarVeiculosDestruidosS1;
var
  ConfigFilePath, SourceDir, WebhookURL, DirPath, LatestFile, LogLine, OffsetFile, UltimoArquivo: string;
  LatestTime: TDateTime;
  SearchRec: TSearchRec;
  vFileList: TStringList;
  vFileStream: TFileStream;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData: string;
  Offset: Integer;
  i: Integer;
  ArqOffset: TStringList;
begin
  // Caminho do INI
  ConfigFilePath := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  with TIniFile.Create(ConfigFilePath) do
  try
    SourceDir := ReadString('Servidor 1', 'Profile', '');
    WebhookURL := ReadString('Servidor 1', 'cardestroyed', '');
  finally
    Free;
  end;

  if (SourceDir = '') or (WebhookURL = '') then Exit;

  DirPath := IncludeTrailingPathDelimiter(SourceDir);
  LatestFile := '';
  LatestTime := 0;

  // Encontra o log mais recente com "MCK"
  if FindFirst(DirPath + '*MCK*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SearchRec.Time) > LatestTime then
        begin
          LatestTime := FileDateToDateTime(SearchRec.Time);
          LatestFile := SearchRec.Name;
        end;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;

  if LatestFile = '' then Exit;

  // Prepara controle de offset
  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_cardesoffsets1.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToIntDef(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;

  vFileList := TStringList.Create;
  try
    vFileStream := TFileStream.Create(DirPath + LatestFile, fmOpenRead or fmShareDenyNone);
    try
      vFileList.LoadFromStream(vFileStream);
    finally
      vFileStream.Free;
    end;

    // Se o log mudou, reinicia offset
    if LatestFile <> UltimoArquivo then
      Offset := 0;

    // Verifica se ainda há algo novo para ler
    if Offset >= vFileList.Count then Exit;

    IdHTTP := TIdHTTP.Create(nil);
    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      SSL.SSLOptions.Method := sslvTLSv1_2;
      IdHTTP.IOHandler := SSL;
      IdHTTP.Request.ContentType := 'application/json';
      IdHTTP.Request.Accept := 'application/json';
      IdHTTP.Request.UserAgent := 'Mozilla/5.0';

      for i := Offset to vFileList.Count - 1 do
      begin
        LogLine := vFileList.Strings[i];

        if Pos('destroyed', LowerCase(LogLine)) > 0 then
        begin
          JsonData := '{"content": "' + StringReplace(LogLine, '"', '\"', [rfReplaceAll]) + '"}';
          PostData := TStringStream.Create(UTF8Encode(JsonData));
          try
            IdHTTP.Post(WebhookURL, PostData);
          except
            on E: Exception do Sleep(1000);
          end;
          PostData.Free;
          Sleep(1000);
        end;
      end;
    finally
      IdHTTP.Free;
      SSL.Free;
    end;

    // Salva novo offset
    ArqOffset := TStringList.Create;
    try
      ArqOffset.Values[LatestFile] := IntToStr(vFileList.Count);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    vFileList.Free;
  end;
end;

procedure TForm1.VerificarVeiculosDestruidosS2;
var
  ConfigFilePath, SourceDir, WebhookURL, DirPath, LatestFile, LogLine, OffsetFile, UltimoArquivo: string;
  LatestTime: TDateTime;
  SearchRec: TSearchRec;
  vFileList: TStringList;
  vFileStream: TFileStream;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData: string;
  Offset: Integer;
  i: Integer;
  ArqOffset: TStringList;
begin
  // Caminho do INI
  ConfigFilePath := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  with TIniFile.Create(ConfigFilePath) do
  try
    SourceDir := ReadString('Servidor 2', 'Profile', '');
    WebhookURL := ReadString('Servidor 2', 'cardestroyed', '');
  finally
    Free;
  end;

  if (SourceDir = '') or (WebhookURL = '') then Exit;

  DirPath := IncludeTrailingPathDelimiter(SourceDir);
  LatestFile := '';
  LatestTime := 0;

  // Encontra o log mais recente com "MCK"
  if FindFirst(DirPath + '*MCK*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SearchRec.Time) > LatestTime then
        begin
          LatestTime := FileDateToDateTime(SearchRec.Time);
          LatestFile := SearchRec.Name;
        end;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;

  if LatestFile = '' then Exit;

  // Prepara controle de offset
  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_cardesoffsets2.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToIntDef(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;

  vFileList := TStringList.Create;
  try
    vFileStream := TFileStream.Create(DirPath + LatestFile, fmOpenRead or fmShareDenyNone);
    try
      vFileList.LoadFromStream(vFileStream);
    finally
      vFileStream.Free;
    end;

    // Se o log mudou, reinicia offset
    if LatestFile <> UltimoArquivo then
      Offset := 0;

    // Verifica se ainda há algo novo para ler
    if Offset >= vFileList.Count then Exit;

    IdHTTP := TIdHTTP.Create(nil);
    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      SSL.SSLOptions.Method := sslvTLSv1_2;
      IdHTTP.IOHandler := SSL;
      IdHTTP.Request.ContentType := 'application/json';
      IdHTTP.Request.Accept := 'application/json';
      IdHTTP.Request.UserAgent := 'Mozilla/5.0';

      for i := Offset to vFileList.Count - 1 do
      begin
        LogLine := vFileList.Strings[i];

        if Pos('destroyed', LowerCase(LogLine)) > 0 then
        begin
          JsonData := '{"content": "' + StringReplace(LogLine, '"', '\"', [rfReplaceAll]) + '"}';
          PostData := TStringStream.Create(UTF8Encode(JsonData));
          try
            IdHTTP.Post(WebhookURL, PostData);
          except
            on E: Exception do Sleep(1000);
          end;
          PostData.Free;
          Sleep(1000);
        end;
      end;
    finally
      IdHTTP.Free;
      SSL.Free;
    end;

    // Salva novo offset
    ArqOffset := TStringList.Create;
    try
      ArqOffset.Values[LatestFile] := IntToStr(vFileList.Count);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    vFileList.Free;
  end;
end;

procedure TForm1.VerificarVeiculosDestruidosS3;
var
  ConfigFilePath, SourceDir, WebhookURL, DirPath, LatestFile, LogLine, OffsetFile, UltimoArquivo: string;
  LatestTime: TDateTime;
  SearchRec: TSearchRec;
  vFileList: TStringList;
  vFileStream: TFileStream;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData: string;
  Offset: Integer;
  i: Integer;
  ArqOffset: TStringList;
begin
  // Caminho do INI
  ConfigFilePath := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';

  with TIniFile.Create(ConfigFilePath) do
  try
    SourceDir := ReadString('Servidor 3', 'Profile', '');
    WebhookURL := ReadString('Servidor 3', 'cardestroyed', '');
  finally
    Free;
  end;

  if (SourceDir = '') or (WebhookURL = '') then Exit;

  DirPath := IncludeTrailingPathDelimiter(SourceDir);
  LatestFile := '';
  LatestTime := 0;

  // Encontra o log mais recente com "MCK"
  if FindFirst(DirPath + '*MCK*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SearchRec.Time) > LatestTime then
        begin
          LatestTime := FileDateToDateTime(SearchRec.Time);
          LatestFile := SearchRec.Name;
        end;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;

  if LatestFile = '' then Exit;

  // Prepara controle de offset
  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_cardesoffsets3.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToIntDef(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;

  vFileList := TStringList.Create;
  try
    vFileStream := TFileStream.Create(DirPath + LatestFile, fmOpenRead or fmShareDenyNone);
    try
      vFileList.LoadFromStream(vFileStream);
    finally
      vFileStream.Free;
    end;

    // Se o log mudou, reinicia offset
    if LatestFile <> UltimoArquivo then
      Offset := 0;

    // Verifica se ainda há algo novo para ler
    if Offset >= vFileList.Count then Exit;

    IdHTTP := TIdHTTP.Create(nil);
    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      SSL.SSLOptions.Method := sslvTLSv1_2;
      IdHTTP.IOHandler := SSL;
      IdHTTP.Request.ContentType := 'application/json';
      IdHTTP.Request.Accept := 'application/json';
      IdHTTP.Request.UserAgent := 'Mozilla/5.0';

      for i := Offset to vFileList.Count - 1 do
      begin
        LogLine := vFileList.Strings[i];

        if Pos('destroyed', LowerCase(LogLine)) > 0 then
        begin
          JsonData := '{"content": "' + StringReplace(LogLine, '"', '\"', [rfReplaceAll]) + '"}';
          PostData := TStringStream.Create(UTF8Encode(JsonData));
          try
            IdHTTP.Post(WebhookURL, PostData);
          except
            on E: Exception do Sleep(1000);
          end;
          PostData.Free;
          Sleep(1000);
        end;
      end;
    finally
      IdHTTP.Free;
      SSL.Free;
    end;

    // Salva novo offset
    ArqOffset := TStringList.Create;
    try
      ArqOffset.Values[LatestFile] := IntToStr(vFileList.Count);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    vFileList.Free;
  end;
end;


//decodificador
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

//Roda steamcmd para monitorar att de mod e do dayz
procedure TForm1.MonitorarMods;
var
  Ini: TIniFile;
  SteamCmdPath, SteamLoginEnc, SteamSenhaEnc, SteamLogin, SteamSenha: string;
  ScriptFile, WorkshopPath, TempPath, HiddenFolder: string;
  Script: TStringList;
  SearchRec: TSearchRec;
  Sei: TShellExecuteInfo;
begin

  // Verifica se o checkbox está marcado antes de tudo
  if not CheckBox4.Checked then
    Exit;

  // Lê o Config.ini
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\Config.ini');
  try
    SteamCmdPath := Ini.ReadString('STEAM', 'steamcmdexe', '');
    SteamLoginEnc := Ini.ReadString('STEAM', 'login', '');
    SteamSenhaEnc := Ini.ReadString('STEAM', 'senha', '');
  finally
    Ini.Free;
  end;

  // Decodifica login e senha
  SteamLogin := DecodeSenha(SteamLoginEnc);
  SteamSenha := DecodeSenha(SteamSenhaEnc);

  // Verificações com mensagem
  if SteamCmdPath = '' then
  begin
    ShowMessage('Caminho do steamcmd.exe não definido!');
    Exit;
  end;

  if SteamLogin = '' then
  begin
    ShowMessage('Login não definido!');
    Exit;
  end;

  if SteamSenha = '' then
  begin
    ShowMessage('Senha não definida!');
    Exit;
  end;

  // Caminho da pasta workshop do DayZ
  WorkshopPath := ExtractFileDir(SteamCmdPath) + '\steamapps\workshop\content\221100';

  // Pasta temporária oculta
  SetLength(TempPath, MAX_PATH);
  SetLength(TempPath, GetTempPath(MAX_PATH, PChar(TempPath)));
  HiddenFolder := IncludeTrailingPathDelimiter(TempPath) + 'SCmdHidden';

  if not DirectoryExists(HiddenFolder) then
  begin
    CreateDir(HiddenFolder);
    SetFileAttributes(PChar(HiddenFolder), FILE_ATTRIBUTE_HIDDEN);
  end;

  ScriptFile := HiddenFolder + '\hftemp.txt';

  // Gera o script SteamCMD
  Script := TStringList.Create;
  try
    Script.Add('login ' + SteamLogin + ' ' + SteamSenha);
    Script.Add('app_update 223350 validate');

    if DirectoryExists(WorkshopPath) then
    begin
      if FindFirst(WorkshopPath + '\*', faDirectory, SearchRec) = 0 then
      begin
        repeat
          if (SearchRec.Attr and faDirectory <> 0) and
             (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          begin
            Script.Add('workshop_download_item 221100 ' + SearchRec.Name + ' validate');
          end;
        until FindNext(SearchRec) <> 0;
        FindClose(SearchRec);
      end;
    end;

    Script.Add('quit');
    Script.SaveToFile(ScriptFile);
  finally
    Script.Free;
  end;

  // Executa SteamCMD com script
  ZeroMemory(@Sei, SizeOf(Sei));
  Sei.cbSize := SizeOf(Sei);
  Sei.fMask := SEE_MASK_NOCLOSEPROCESS;
  Sei.Wnd := 0;
  Sei.lpVerb := 'open';
  Sei.lpFile := PChar(SteamCmdPath);
  Sei.lpParameters := PChar('+runscript "' + ScriptFile + '"');
  Sei.nShow := SW_SHOWNORMAL; // visível

  if ShellExecuteEx(@Sei) then
  begin
    WaitForSingleObject(Sei.hProcess, INFINITE);
    CloseHandle(Sei.hProcess);
  end;

  // Remove script temporário
  if FileExists(ScriptFile) then
    DeleteFile(PChar(ScriptFile));
end;

//ENVIO DE MENSAGEM SOBRE RESTART
procedure EnviarAvisoRestartDiscord;
var
  Ini: TIniFile;
  ConfigFilePath: string;
  RestTimes: array[1..3, 1..4] of TTime;
  BackupTime, NowTime: TTime;
  WebhookURLs: array[1..3] of string;
  Server, RestIndex: Integer;
  RestartTime: TTime;
  DiffMinutes: Integer;
  AlertTime: Integer;
  MessageBase, BackupMessageBase, FinalMessage, JsonData: string;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  MinutoAtual: Integer;
begin
  MinutoAtual := MinuteOf(Now);
  if MinutoAtual = UltimoMinutoEnviado then
    Exit;  // Já enviou nesse minuto, então sai

  UltimoMinutoEnviado := MinutoAtual;

  ConfigFilePath := ExtractFilePath(ParamStr(0)) + 'Config\Config.ini';
  Ini := TIniFile.Create(ConfigFilePath);
  try
    // Lê os horários de restart de cada servidor
    for Server := 1 to 3 do
    begin
      for RestIndex := 1 to 4 do
        RestTimes[Server, RestIndex] := StrToTimeDef(Ini.ReadString('Servidor ' + IntToStr(Server), 'rest' + IntToStr(RestIndex), ''), 0);

      // Lê os webhooks individuais de cada servidor
      WebhookURLs[Server] := Ini.ReadString('RESTARTWH', 'avisoS' + IntToStr(Server), '');
    end;

    // Lê o horário de backup (único para todos os servidores)
    BackupTime := StrToTimeDef(Ini.ReadString('ParadaBackup', 'das', ''), 0);

    // Tempo de aviso (em minutos)
    AlertTime := Ini.ReadInteger('RESTARTWH', 'time', 5);

    // Mensagens base (personalizáveis pelo usuário)
    MessageBase := Ini.ReadString('RESTARTWH', 'mensagem', '');
    BackupMessageBase := Ini.ReadString('RESTARTWH', 'mensagem1', '');

  finally
    Ini.Free;
  end;

  NowTime := Time;

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    for Server := 1 to 3 do
    begin
      if WebhookURLs[Server] = '' then Continue;  // Se não tem webhook, pula

      // Avisos de restart
      for RestIndex := 1 to 4 do
      begin
        RestartTime := RestTimes[Server, RestIndex];
        if RestartTime = 0 then Continue;

        DiffMinutes := Trunc((RestartTime - NowTime) * 24 * 60);

        // Só envia se estiver dentro da janela de aviso, mas não no zero
        if (DiffMinutes <= AlertTime) and (DiffMinutes >= 1) then
        begin
          FinalMessage := MessageBase + ' ' + IntToStr(DiffMinutes) + ' minuto';
          if DiffMinutes <> 1 then
            FinalMessage := FinalMessage + 's';

          JsonData := '{"content": "' + StringReplace(FinalMessage, '"', '\"', [rfReplaceAll]) + '"}';
          PostData := TStringStream.Create(UTF8Encode(JsonData));
          try
            IdHTTP.Post(WebhookURLs[Server], PostData);
          except
            on E: Exception do Sleep(500);
          end;
          PostData.Free;
        end;
      end;

      // Aviso de backup
      if (BackupTime > 0) and (BackupMessageBase <> '') then
      begin
        DiffMinutes := Trunc((BackupTime - NowTime) * 24 * 60);

        if (DiffMinutes <= AlertTime) and (DiffMinutes >= 1) then
        begin
          FinalMessage := BackupMessageBase + ' ' + IntToStr(DiffMinutes) + ' minuto';
          if DiffMinutes <> 1 then
            FinalMessage := FinalMessage + 's';

          JsonData := '{"content": "' + StringReplace(FinalMessage, '"', '\"', [rfReplaceAll]) + '"}';
          PostData := TStringStream.Create(UTF8Encode(JsonData));
          try
            IdHTTP.Post(WebhookURLs[Server], PostData);
          except
            on E: Exception do Sleep(500);
          end;
          PostData.Free;
        end;
      end;

    end;

  finally
    IdHTTP.Free;
    SSL.Free;
  end;
end;

//COPIA SERVERDZ.CFG
//S1
procedure CopiarCfgParaDestinos1;
var
  PastaInstalacao, ArquivoOrigem, CaminhoIni, DiretorioDestino, DestinoFinal: string;
  Ini: TIniFile;
begin
  try
    // Diretório de instalação do aplicativo
    PastaInstalacao := ExtractFilePath(ParamStr(0));

    // Caminho completo do arquivo de origem
    ArquivoOrigem := TPath.Combine(PastaInstalacao, 'temp\cfgs1\serverDZ.cfg');

    // Caminho do config.ini
    CaminhoIni := TPath.Combine(PastaInstalacao, 'Config\config.ini');

    // Lê o diretório de destino do INI
    Ini := TIniFile.Create(CaminhoIni);
    try
      DiretorioDestino := Ini.ReadString('UpdateMod', 'destinoserver1', '');
    finally
      Ini.Free;
    end;

    // Validação
    if DiretorioDestino = '' then
    exit;
    //  raise Exception.Create('Destino não definido no config.ini (UpdateMod\destinoserver1).');

    // Garante que termina com \ (barra invertida)
    if not DiretorioDestino.EndsWith('\') then
      DiretorioDestino := DiretorioDestino + '\';

    // Monta caminho final com nome do arquivo
    DestinoFinal := DiretorioDestino + 'serverDZ.cfg';

    // Copia o arquivo
    TFile.Copy(ArquivoOrigem, DestinoFinal, True);

    //deleta arquivo origem apos a copia
    TFile.Delete(ArquivoOrigem);

    //ShowMessage('Arquivo copiado com sucesso para: ' + DestinoFinal);
  except
    on E: Exception do
      //ShowMessage('Erro ao copiar o arquivo: ' + E.Message);
  end;
end;

//S1
procedure CopiarCfgParaDestinos2;
var
  PastaInstalacao, ArquivoOrigem, CaminhoIni, DiretorioDestino, DestinoFinal: string;
  Ini: TIniFile;
begin
  try
    // Diretório de instalação do aplicativo
    PastaInstalacao := ExtractFilePath(ParamStr(0));

    // Caminho completo do arquivo de origem
    ArquivoOrigem := TPath.Combine(PastaInstalacao, 'temp\cfgs2\serverDZ.cfg');

    // Caminho do config.ini
    CaminhoIni := TPath.Combine(PastaInstalacao, 'Config\config.ini');

    // Lê o diretório de destino do INI
    Ini := TIniFile.Create(CaminhoIni);
    try
      DiretorioDestino := Ini.ReadString('UpdateMod', 'destinoserver2', '');
    finally
      Ini.Free;
    end;

    // Validação
    if DiretorioDestino = '' then
    exit;
    //  raise Exception.Create('Destino não definido no config.ini (UpdateMod\destinoserver1).');

    // Garante que termina com \ (barra invertida)
    if not DiretorioDestino.EndsWith('\') then
      DiretorioDestino := DiretorioDestino + '\';

    // Monta caminho final com nome do arquivo
    DestinoFinal := DiretorioDestino + 'serverDZ.cfg';

    // Copia o arquivo
    TFile.Copy(ArquivoOrigem, DestinoFinal, True);

    //deleta arquivo origem apos a copia
    TFile.Delete(ArquivoOrigem);

    //ShowMessage('Arquivo copiado com sucesso para: ' + DestinoFinal);
  except
    on E: Exception do
      //ShowMessage('Erro ao copiar o arquivo: ' + E.Message);
  end;
end;

//S3
procedure CopiarCfgParaDestinos3;
var
  PastaInstalacao, ArquivoOrigem, CaminhoIni, DiretorioDestino, DestinoFinal: string;
  Ini: TIniFile;
begin
  try
    // Diretório de instalação do aplicativo
    PastaInstalacao := ExtractFilePath(ParamStr(0));

    // Caminho completo do arquivo de origem
    ArquivoOrigem := TPath.Combine(PastaInstalacao, 'temp\cfgs3\serverDZ.cfg');

    // Caminho do config.ini
    CaminhoIni := TPath.Combine(PastaInstalacao, 'Config\config.ini');

    // Lê o diretório de destino do INI
    Ini := TIniFile.Create(CaminhoIni);
    try
      DiretorioDestino := Ini.ReadString('UpdateMod', 'destinoserver3', '');
    finally
      Ini.Free;
    end;

    // Validação
    if DiretorioDestino = '' then
    exit;
    //  raise Exception.Create('Destino não definido no config.ini (UpdateMod\destinoserver1).');

    // Garante que termina com \ (barra invertida)
    if not DiretorioDestino.EndsWith('\') then
      DiretorioDestino := DiretorioDestino + '\';

    // Monta caminho final com nome do arquivo
    DestinoFinal := DiretorioDestino + 'serverDZ.cfg';

    // Copia o arquivo
    TFile.Copy(ArquivoOrigem, DestinoFinal, True);

    //deleta arquivo origem apos a copia
    TFile.Delete(ArquivoOrigem);

    //ShowMessage('Arquivo copiado com sucesso para: ' + DestinoFinal);
  except
    on E: Exception do
      //ShowMessage('Erro ao copiar o arquivo: ' + E.Message);
  end;
end;
//End

//EXCLUIR BACKUP ANTIGO
function CompareDatasDesc1(List: TStringList; Index1, Index2: Integer): Integer;
begin
  // Ordem decrescente (mais recente primeiro)
  Result := CompareText(List[Index2], List[Index1]);
end;

procedure ExcluirPastaComConteudo1(const Pasta: string);
var
  FO: TSHFileOpStruct;
  PastaComNulo: string;
begin
  FillChar(FO, SizeOf(FO), 0);
  PastaComNulo := IncludeTrailingPathDelimiter(Pasta) + #0#0;
  FO.wFunc := FO_DELETE;
  FO.pFrom := PChar(PastaComNulo);
  FO.fFlags := FOF_NOERRORUI or FOF_SILENT or FOF_NOCONFIRMATION;
  SHFileOperation(FO);
end;

procedure ExcluirBackupsAntigos;
var
  ConfigIni, ParametrosIni: TIniFile;
  ListaCaminhos: TStringList;
  BackupPath, SubPath: string;
  MaxBackups: Integer;
  SR, SR2: TSearchRec;
  ListaBackups: TStringList;
  i, j: Integer;
begin
  ConfigIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\config.ini');
  ParametrosIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\parametros.ini');
  ListaCaminhos := TStringList.Create;
  try
    // Adiciona os caminhos de backup configurados
    if ConfigIni.ValueExists('ParadaBackup', 'S1Ldestino') then
      ListaCaminhos.Add(ConfigIni.ReadString('ParadaBackup', 'S1Ldestino', ''));
    if ConfigIni.ValueExists('ParadaBackup', 'S2Ldestino') then
      ListaCaminhos.Add(ConfigIni.ReadString('ParadaBackup', 'S2Ldestino', ''));
    if ConfigIni.ValueExists('ParadaBackup', 'S3Ldestino') then
      ListaCaminhos.Add(ConfigIni.ReadString('ParadaBackup', 'S3Ldestino', ''));

    MaxBackups := ParametrosIni.ReadInteger('PARBACKUP', 'filebackup', 3);

    // Processa cada caminho individualmente
    for j := 0 to ListaCaminhos.Count - 1 do
    begin
      BackupPath := IncludeTrailingPathDelimiter(ListaCaminhos[j]);

      if not DirectoryExists(BackupPath) then
        Continue;

      if FindFirst(BackupPath + '*', faDirectory, SR) = 0 then
      begin
        repeat
          if ((SR.Attr and faDirectory) = faDirectory) and (SR.Name <> '.') and (SR.Name <> '..') then
          begin
            SubPath := IncludeTrailingPathDelimiter(BackupPath + SR.Name);

            ListaBackups := TStringList.Create;
            try
              if FindFirst(SubPath + '*', faDirectory, SR2) = 0 then
              begin
                repeat
                  if ((SR2.Attr and faDirectory) = faDirectory) and (SR2.Name <> '.') and (SR2.Name <> '..') then
                    ListaBackups.Add(SR2.Name);
                until FindNext(SR2) <> 0;
                FindClose(SR2);
              end;

              // Ordenar por nome (assumindo que segue padrão de datas AAAA-MM-DD)
              ListaBackups.Sort;

              for i := 0 to ListaBackups.Count - MaxBackups - 1 do
                ExcluirPastaComConteudo1(SubPath + ListaBackups[i]);

            finally
              ListaBackups.Free;
            end;
          end;
        until FindNext(SR) <> 0;
        FindClose(SR);
      end;
    end;

  finally
    ConfigIni.Free;
    ParametrosIni.Free;
    ListaCaminhos.Free;
  end;
end;


//End


//ENVIO ARQUIVO SERVERCONSOLE.LOG PARA DISCORD
//S1
procedure EnviarServerConsoleLogS1;
var
  Ini: TIniFile;
  WebhookURL, ArquivoLog, ControleEnvio: string;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FormData: TIdMultiPartFormDataStream;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\config.ini');
  try
    WebhookURL := Ini.ReadString('CONSOLE', 'LogS1', '');
  finally
    Ini.Free;
  end;

  if WebhookURL = '' then Exit;

  ArquivoLog := ExtractFilePath(ParamStr(0)) + 'temp\serverconsoleS1.log';
  //ControleEnvio := ExtractFilePath(ParamStr(0)) + 'temp\serverconsole_enviadoS1.txt';

  if not FileExists(ArquivoLog) then Exit;

  //if FileExists(ControleEnvio) then
    //if Trim(LowerCase(ReadLnFromFile(ControleEnvio))) = Trim(LowerCase(ArquivoLog)) then Exit;

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FormData := TIdMultiPartFormDataStream.Create;
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := FormData.RequestContentType;
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    FormData.AddFormField('content', 'Log da ultima sessao:');
    FormData.AddFile('file', ArquivoLog, 'application/octet-stream');

    try
      IdHTTP.Post(WebhookURL, FormData);
      //WriteLnToFile(ControleEnvio, ArquivoLog);
    except
      on E: Exception do
        Exit;
    end;
  finally
    FormData.Free;
    SSL.Free;
    IdHTTP.Free;
  end;
end;

procedure EnviarServerConsoleLogS2;
var
  Ini: TIniFile;
  WebhookURL, ArquivoLog, ControleEnvio: string;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FormData: TIdMultiPartFormDataStream;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\config.ini');
  try
    WebhookURL := Ini.ReadString('CONSOLE', 'LogS2', '');
  finally
    Ini.Free;
  end;

  if WebhookURL = '' then Exit;

  ArquivoLog := ExtractFilePath(ParamStr(0)) + 'temp\serverconsoleS2.log';
  //ControleEnvio := ExtractFilePath(ParamStr(0)) + 'temp\serverconsole_enviadoS2.txt';

  if not FileExists(ArquivoLog) then Exit;

  //if FileExists(ControleEnvio) then
    //if Trim(LowerCase(ReadLnFromFile(ControleEnvio))) = Trim(LowerCase(ArquivoLog)) then Exit;

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FormData := TIdMultiPartFormDataStream.Create;
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := FormData.RequestContentType;
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    FormData.AddFormField('content', 'Log da ultima sessao:');
    FormData.AddFile('file', ArquivoLog, 'application/octet-stream');

    try
      IdHTTP.Post(WebhookURL, FormData);
      //WriteLnToFile(ControleEnvio, ArquivoLog);
    except
      on E: Exception do
        Exit;
    end;
  finally
    FormData.Free;
    SSL.Free;
    IdHTTP.Free;
  end;
end;

procedure EnviarServerConsoleLogS3;
var
  Ini: TIniFile;
  WebhookURL, ArquivoLog, ControleEnvio: string;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FormData: TIdMultiPartFormDataStream;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\config.ini');
  try
    WebhookURL := Ini.ReadString('CONSOLE', 'LogS3', '');
  finally
    Ini.Free;
  end;

  if WebhookURL = '' then Exit;

  ArquivoLog := ExtractFilePath(ParamStr(0)) + 'temp\serverconsoleS3.log';
  //ControleEnvio := ExtractFilePath(ParamStr(0)) + 'temp\serverconsole_enviadoS3.txt';

  if not FileExists(ArquivoLog) then Exit;

  //if FileExists(ControleEnvio) then
    //if Trim(LowerCase(ReadLnFromFile(ControleEnvio))) = Trim(LowerCase(ArquivoLog)) then Exit;

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FormData := TIdMultiPartFormDataStream.Create;
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := FormData.RequestContentType;
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    FormData.AddFormField('content', 'Log da ultima sessao:');
    FormData.AddFile('file', ArquivoLog, 'application/octet-stream');

    try
      IdHTTP.Post(WebhookURL, FormData);
      //WriteLnToFile(ControleEnvio, ArquivoLog);
    except
      on E: Exception do
        Exit;
    end;
  finally
    FormData.Free;
    SSL.Free;
    IdHTTP.Free;
  end;
end;
//End


//Cria serverconsoleS1
procedure CriarServerConsoleS1;
var
  Ini: TIniFile;
  ProfilePath, ScriptFullPath, DestPath, Line, NewScriptPath: string;
  SR: TSearchRec;
  SLInput, SLOutput: TStringList;
  FileStream: TFileStream;
  I: Integer;
  UltimaData: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\Config.ini');
  try
    ProfilePath := Ini.ReadString('Servidor 1', 'Profile', '');
  finally
    Ini.Free;
  end;

  if ProfilePath = '' then
    Exit;

  // Procurar o arquivo serverconsole.log mais recente
  UltimaData := 0;
  ScriptFullPath := '';
  if FindFirst(IncludeTrailingPathDelimiter(ProfilePath) + 'serverconsole.log', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SR.Time) > UltimaData then
        begin
          UltimaData := FileDateToDateTime(SR.Time);
          ScriptFullPath := IncludeTrailingPathDelimiter(ProfilePath) + SR.Name;
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end
  else
    Exit;

  if ScriptFullPath = '' then
    Exit;

  SLInput := TStringList.Create;
  SLOutput := TStringList.Create;
  try
    // Abrir o arquivo com compartilhamento de leitura
    FileStream := TFileStream.Create(ScriptFullPath, fmOpenRead or fmShareDenyNone);
    try
      SLInput.LoadFromStream(FileStream);
    finally
      FileStream.Free;
    end;

    for I := 0 to SLInput.Count - 1 do
    begin
      Line := SLInput[I];
      SLOutput.Add(Line);
      if Pos('save processed', LowerCase(Line)) > 0 then
        Break;
    end;

    DestPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'temp\';
    if not DirectoryExists(DestPath) then
      CreateDir(DestPath);

    NewScriptPath := DestPath + 'serverconsoleS1.log';
    SLOutput.SaveToFile(NewScriptPath);
  finally
    SLInput.Free;
    SLOutput.Free;
  end;
end;


//Cria serverconsoleS2
procedure CriarServerConsoleS2;
var
  Ini: TIniFile;
  ProfilePath, ScriptFullPath, DestPath, Line, NewScriptPath: string;
  SR: TSearchRec;
  SLInput, SLOutput: TStringList;
  FileStream: TFileStream;
  I: Integer;
  UltimaData: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\Config.ini');
  try
    ProfilePath := Ini.ReadString('Servidor 2', 'Profile', '');
  finally
    Ini.Free;
  end;

  if ProfilePath = '' then
    Exit;

  // Procurar o arquivo serverconsole.log mais recente
  UltimaData := 0;
  ScriptFullPath := '';
  if FindFirst(IncludeTrailingPathDelimiter(ProfilePath) + 'serverconsole.log', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SR.Time) > UltimaData then
        begin
          UltimaData := FileDateToDateTime(SR.Time);
          ScriptFullPath := IncludeTrailingPathDelimiter(ProfilePath) + SR.Name;
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end
  else
    Exit;

  if ScriptFullPath = '' then
    Exit;

  SLInput := TStringList.Create;
  SLOutput := TStringList.Create;
  try
    // Abrir o arquivo com compartilhamento de leitura
    FileStream := TFileStream.Create(ScriptFullPath, fmOpenRead or fmShareDenyNone);
    try
      SLInput.LoadFromStream(FileStream);
    finally
      FileStream.Free;
    end;

    for I := 0 to SLInput.Count - 1 do
    begin
      Line := SLInput[I];
      SLOutput.Add(Line);
      if Pos('save processed', LowerCase(Line)) > 0 then
        Break;
    end;

    DestPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'temp\';
    if not DirectoryExists(DestPath) then
      CreateDir(DestPath);

    NewScriptPath := DestPath + 'serverconsoleS2.log';
    SLOutput.SaveToFile(NewScriptPath);
  finally
    SLInput.Free;
    SLOutput.Free;
  end;
end;

//Cria serverconsoleS3
procedure CriarServerConsoleS3;
var
  Ini: TIniFile;
  ProfilePath, ScriptFullPath, DestPath, Line, NewScriptPath: string;
  SR: TSearchRec;
  SLInput, SLOutput: TStringList;
  FileStream: TFileStream;
  I: Integer;
  UltimaData: TDateTime;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\Config.ini');
  try
    ProfilePath := Ini.ReadString('Servidor 3', 'Profile', '');
  finally
    Ini.Free;
  end;

  if ProfilePath = '' then
    Exit;

  // Procurar o arquivo serverconsole.log mais recente
  UltimaData := 0;
  ScriptFullPath := '';
  if FindFirst(IncludeTrailingPathDelimiter(ProfilePath) + 'serverconsole.log', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SR.Time) > UltimaData then
        begin
          UltimaData := FileDateToDateTime(SR.Time);
          ScriptFullPath := IncludeTrailingPathDelimiter(ProfilePath) + SR.Name;
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end
  else
    Exit;

  if ScriptFullPath = '' then
    Exit;

  SLInput := TStringList.Create;
  SLOutput := TStringList.Create;
  try
    // Abrir o arquivo com compartilhamento de leitura
    FileStream := TFileStream.Create(ScriptFullPath, fmOpenRead or fmShareDenyNone);
    try
      SLInput.LoadFromStream(FileStream);
    finally
      FileStream.Free;
    end;

    for I := 0 to SLInput.Count - 1 do
    begin
      Line := SLInput[I];
      SLOutput.Add(Line);
      if Pos('save processed', LowerCase(Line)) > 0 then
        Break;
    end;

    DestPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'temp\';
    if not DirectoryExists(DestPath) then
      CreateDir(DestPath);

    NewScriptPath := DestPath + 'serverconsoleS3.log';
    SLOutput.SaveToFile(NewScriptPath);
  finally
    SLInput.Free;
    SLOutput.Free;
  end;
end;

//LOG TIMER ENCSERVIDOR
procedure GravarLogTimerEncServidor(const NomeLogArquivo, Msg: string);
var
  LogFile: TextFile;
  BaseLogDir, DataSubPasta, LogDirCompleto, LogPath, NomeArquivoComData: string;
  IsNovoArquivo: Boolean;
begin
  // Define a pasta base \log dentro do diretório do executável
  BaseLogDir := ExtractFilePath(ParamStr(0)) + 'log\';

  // Nome da subpasta com a data atual (formato YYYYMMDD)
  DataSubPasta := FormatDateTime('yyyymmdd', Date);

  // Caminho completo da pasta de log do dia
  LogDirCompleto := IncludeTrailingPathDelimiter(BaseLogDir + DataSubPasta);

  // Cria a subpasta de data, se não existir
  if not DirectoryExists(LogDirCompleto) then
    ForceDirectories(LogDirCompleto);

  // Nome do arquivo de log com a data (sem hora)
  NomeArquivoComData := NomeLogArquivo + '.log';
  
  LogPath := LogDirCompleto + NomeArquivoComData;

  IsNovoArquivo := not FileExists(LogPath);
  AssignFile(LogFile, LogPath);

  if FileExists(LogPath) then
    Append(LogFile)
  else
    Rewrite(LogFile);

  try
    if IsNovoArquivo then
    begin
      Writeln(LogFile, '==== ' + UpperCase(NomeLogArquivo) + ' ====');
      Writeln(LogFile, '');
    end;

    Writeln(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + Msg);
  finally
    CloseFile(LogFile);
  end;
end;


//LOG TIMER BACKUPLOCAL
procedure GravarLogTimerBackup(const NomeLogArquivo, Msg: string);
var
  LogFile: TextFile;
  BaseLogDir, DataSubPasta, LogDirCompleto, LogPath, NomeArquivoComData: string;
  IsNovoArquivo: Boolean;
begin
  // Pasta base "log\" no diretório do executável
  BaseLogDir := ExtractFilePath(ParamStr(0)) + 'log\';

  // Subpasta com a data atual (ex: 20250429)
  DataSubPasta := FormatDateTime('yyyymmdd', Date);

  // Caminho completo: log\20250429\
  LogDirCompleto := IncludeTrailingPathDelimiter(BaseLogDir + DataSubPasta);

  // Cria a subpasta se não existir
  if not DirectoryExists(LogDirCompleto) then
    ForceDirectories(LogDirCompleto);

  // Nome do arquivo: ex. LogBackup_20250429.log
  NomeArquivoComData := NomeLogArquivo + '.log';
  LogPath := LogDirCompleto + NomeArquivoComData;

  IsNovoArquivo := not FileExists(LogPath);
  AssignFile(LogFile, LogPath);

  if FileExists(LogPath) then
    Append(LogFile)
  else
    Rewrite(LogFile);

  try
    if IsNovoArquivo then
    begin
      Writeln(LogFile, '==== ' + UpperCase(NomeLogArquivo) + ' ====');
      Writeln(LogFile, '');
    end;

    Writeln(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + Msg);
  finally
    CloseFile(LogFile);
  end;
end;


//LOG TIMER STARTGOOGLE
procedure GravarLogTimerStartGoogle(const NomeLogArquivo, Msg: string);
var
  LogFile: TextFile;
  BaseLogDir, DataSubPasta, LogDirCompleto, LogPath, NomeArquivoComData: string;
  IsNovoArquivo: Boolean;
begin
  // Pasta base "log\" no diretório do executável
  BaseLogDir := ExtractFilePath(ParamStr(0)) + 'log\';

  // Subpasta com a data atual (ex: 20250429)
  DataSubPasta := FormatDateTime('yyyymmdd', Date);

  // Caminho completo: log\20250429\
  LogDirCompleto := IncludeTrailingPathDelimiter(BaseLogDir + DataSubPasta);

  // Cria a subpasta se não existir
  if not DirectoryExists(LogDirCompleto) then
    ForceDirectories(LogDirCompleto);

  // Nome do arquivo: ex. LogStartGoogle_20250429.log
  NomeArquivoComData := NomeLogArquivo + '.log';
  LogPath := LogDirCompleto + NomeArquivoComData;

  IsNovoArquivo := not FileExists(LogPath);
  AssignFile(LogFile, LogPath);

  if FileExists(LogPath) then
    Append(LogFile)
  else
    Rewrite(LogFile);

  try
    if IsNovoArquivo then
    begin
      Writeln(LogFile, '==== ' + UpperCase(NomeLogArquivo) + ' ====');
      Writeln(LogFile, '');
    end;

    Writeln(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + Msg);
  finally
    CloseFile(LogFile);
  end;
end;


//LOG TIMER CLOSEGOOGLE
procedure GravarLogTimerCloseGoogle(const NomeLogArquivo, Msg: string);
var
  LogFile: TextFile;
  BaseLogDir, DataSubPasta, LogDirCompleto, LogPath, NomeArquivoComData: string;
  IsNovoArquivo: Boolean;
begin
  // Pasta base "log\" no diretório do executável
  BaseLogDir := ExtractFilePath(ParamStr(0)) + 'log\';

  // Subpasta com a data atual (ex: 20250429)
  DataSubPasta := FormatDateTime('yyyymmdd', Date);

  // Caminho completo: log\20250429\
  LogDirCompleto := IncludeTrailingPathDelimiter(BaseLogDir + DataSubPasta);

  // Cria a subpasta se não existir
  if not DirectoryExists(LogDirCompleto) then
    ForceDirectories(LogDirCompleto);

  // Nome do arquivo: ex. LogCloseGoogle_20250429.log
  NomeArquivoComData := NomeLogArquivo + '.log';
  LogPath := LogDirCompleto + NomeArquivoComData;

  IsNovoArquivo := not FileExists(LogPath);
  AssignFile(LogFile, LogPath);

  if FileExists(LogPath) then
    Append(LogFile)
  else
    Rewrite(LogFile);

  try
    if IsNovoArquivo then
    begin
      Writeln(LogFile, '==== ' + UpperCase(NomeLogArquivo) + ' ====');
      Writeln(LogFile, '');
    end;

    Writeln(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + Msg);
  finally
    CloseFile(LogFile);
  end;
end;


//LOG TIMER MOVELOG
procedure GravarLogTimerMoveLog(const NomeLogArquivo, Msg: string);
var
  LogFile: TextFile;
  BaseLogDir, DataSubPasta, LogDirCompleto, LogPath, NomeArquivoComData: string;
  IsNovoArquivo: Boolean;
begin
  // Pasta base "log\" no diretório do executável
  BaseLogDir := ExtractFilePath(ParamStr(0)) + 'log\';

  // Subpasta com a data atual (ex: 20250429)
  DataSubPasta := FormatDateTime('yyyymmdd', Date);

  // Caminho completo da pasta de log do dia: log\20250429\
  LogDirCompleto := IncludeTrailingPathDelimiter(BaseLogDir + DataSubPasta);

  // Cria a subpasta se não existir
  if not DirectoryExists(LogDirCompleto) then
    ForceDirectories(LogDirCompleto);

  // Nome do arquivo de log: NomeArquivo_20250429.log
  NomeArquivoComData := NomeLogArquivo + '.log';
  LogPath := LogDirCompleto + NomeArquivoComData;

  IsNovoArquivo := not FileExists(LogPath);
  AssignFile(LogFile, LogPath);

  if FileExists(LogPath) then
    Append(LogFile)
  else
    Rewrite(LogFile);

  try
    if IsNovoArquivo then
    begin
      Writeln(LogFile, '==== ' + UpperCase(NomeLogArquivo) + ' ====');
      Writeln(LogFile, '');
    end;

    Writeln(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + Msg);
  finally
    CloseFile(LogFile);
  end;
end;

//LOG TIMER STARTSERVIDOR
procedure GravarLogTimerStartServer(const NomeLogArquivo, Msg: string);
var
  LogFile: TextFile;
  BaseLogDir, DataSubPasta, LogDirCompleto, LogPath, NomeArquivoComData: string;
  IsNovoArquivo: Boolean;
begin
  // Pasta base "log\" no diretório do executável
  BaseLogDir := ExtractFilePath(ParamStr(0)) + 'log\';

  // Subpasta com a data atual (ex: 20250429)
  DataSubPasta := FormatDateTime('yyyymmdd', Date);

  // Caminho completo da pasta de log do dia: log\20250429\
  LogDirCompleto := IncludeTrailingPathDelimiter(BaseLogDir + DataSubPasta);

  // Cria a subpasta se não existir
  if not DirectoryExists(LogDirCompleto) then
    ForceDirectories(LogDirCompleto);

  // Nome do arquivo de log: NomeArquivo_20250429.log
  NomeArquivoComData := NomeLogArquivo + '.log';
  LogPath := LogDirCompleto + NomeArquivoComData;

  IsNovoArquivo := not FileExists(LogPath);
  AssignFile(LogFile, LogPath);

  if FileExists(LogPath) then
    Append(LogFile)
  else
    Rewrite(LogFile);

  try
    if IsNovoArquivo then
    begin
      Writeln(LogFile, '==== ' + UpperCase(NomeLogArquivo) + ' ====');
      Writeln(LogFile, '');
    end;

    Writeln(LogFile, FormatDateTime('dd/mm/yyyy hh:nn:ss', Now) + ' - ' + Msg);
  finally
    CloseFile(LogFile);
  end;
end;


//End


//CRASH
// Funções auxiliares
procedure FindAllDirectories(List: TStrings; const RootDir: string; Recursive: Boolean);
var
  SR: TSearchRec;
  Dir: string;
begin
  Dir := IncludeTrailingPathDelimiter(RootDir);
  if FindFirst(Dir + '*.*', faDirectory, SR) = 0 then
  repeat
    if (SR.Attr and faDirectory <> 0) and (SR.Name[1] <> '.') then
      List.Add(Dir + SR.Name);
  until FindNext(SR) <> 0;
  FindClose(SR);
end;

procedure FindAllFiles(List: TStrings; const Folder, Mask: string; Recurse: Boolean);
var
  SR: TSearchRec;
  Path: string;
begin
  Path := IncludeTrailingPathDelimiter(Folder);
  if FindFirst(Path + Mask, faAnyFile, SR) = 0 then
  repeat
    if (SR.Attr and faDirectory = 0) then
      List.Add(Path + SR.Name);
  until FindNext(SR) <> 0;
  FindClose(SR);
end;

function ReadLnFromFile(const FileName: string): string;
var
  SL: TStringList;
begin
  Result := '';
  if not FileExists(FileName) then Exit;
  SL := TStringList.Create;
  try
    SL.LoadFromFile(FileName);
    if SL.Count > 0 then
      Result := SL[0];
  finally
    SL.Free;
  end;
end;

function TentarConverterDataISO8601(const NomePasta: string; out Data: TDateTime): Boolean;
var
  Ano, Mes, Dia: Word;
begin
  Result := False;
  if Length(NomePasta) <> 10 then Exit; // 'YYYY-MM-DD'
  try
    Ano := StrToInt(Copy(NomePasta, 1, 4));
    Mes := StrToInt(Copy(NomePasta, 6, 2));
    Dia := StrToInt(Copy(NomePasta, 9, 2));
    Data := EncodeDate(Ano, Mes, Dia);
    Result := True;
  except
    Result := False;
  end;
end;


procedure WriteLnToFile(const FileName, Text: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Add(Text);
    SL.SaveToFile(FileName);
  finally
    SL.Free;
  end;
end;

//Servidor 1
procedure EnviarCrashLogS1;
var
  Ini: TIniFile;
  PastaLog, SubpastaMaisRecente, ArquivoMaisRecente, ControleEnvio, WebhookURL: string;
  Pastas: TStringList;
  i: Integer;
  DataMax, DataAtual, DataArqMax: TDateTime;
  Arquivos: TStringList;
  Arq: string;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FormData: TIdMultiPartFormDataStream;
  Stream: TFileStream;
begin
  //ShowMessage('Iniciando envio do crash log...');

  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\config.ini');
  try
    PastaLog := Ini.ReadString('Servidor 1', 'log', '');
    ControleEnvio := ExtractFilePath(ParamStr(0)) + 'temp\crash_enviadoS1.txt';
    WebhookURL := Ini.ReadString('CRASH', 'logS1', '');
  finally
    Ini.Free;
  end;

  if WebhookURL = '' then
  begin
    //ShowMessage('Webhook do Discord não encontrado no arquivo INI.');
    Exit;
  end;

  if not DirectoryExists(PastaLog) then
  begin
    //ShowMessage('A pasta de log "' + PastaLog + '" não existe.');
    Exit;
  end;

  //ShowMessage('Pasta de log: ' + PastaLog);

  Pastas := TStringList.Create;
  try
    FindAllDirectories(Pastas, PastaLog, False);
    DataMax := 0;
    SubpastaMaisRecente := '';

    for i := 0 to Pastas.Count - 1 do
    begin
      if TentarConverterDataISO8601(ExtractFileName(Pastas[i]), DataAtual) then
      begin
        if DataAtual > DataMax then
        begin
          DataMax := DataAtual;
          SubpastaMaisRecente := Pastas[i];
        end;
      end;
    end;
  finally
    Pastas.Free;
  end;

  if SubpastaMaisRecente = '' then
  begin
    //ShowMessage('Nenhuma subpasta válida (YYYY-MM-DD) encontrada.');
    Exit;
  end;

  //ShowMessage('Subpasta mais recente encontrada: ' + SubpastaMaisRecente);

  Arquivos := TStringList.Create;
  try
    FindAllFiles(Arquivos, SubpastaMaisRecente, '*.log', False);
    ArquivoMaisRecente := '';
    DataArqMax := 0;

    for i := 0 to Arquivos.Count - 1 do
    begin
      Arq := Arquivos[i];
      if Pos('crash', LowerCase(ExtractFileName(Arq))) > 0 then
      begin
        DataAtual := FileDateToDateTime(FileAge(Arq));
        if DataAtual > DataArqMax then
        begin
          DataArqMax := DataAtual;
          ArquivoMaisRecente := Arq;
        end;
      end;
    end;
  finally
    Arquivos.Free;
  end;

  if ArquivoMaisRecente = '' then
  begin
    //ShowMessage('Nenhum arquivo com "crash" no nome foi encontrado.');
    Exit;
  end;

  //ShowMessage('Crash da ultima sessão: ' + ArquivoMaisRecente);

  if FileExists(ControleEnvio) then
  begin
    if Trim(LowerCase(ArquivoMaisRecente)) = Trim(LowerCase(Trim(ReadLnFromFile(ControleEnvio)))) then
    begin
      //ShowMessage('Arquivo já foi enviado anteriormente.');
      Exit;
    end;
  end;

  //ShowMessage('Preparando para enviar o arquivo...');

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FormData := TIdMultiPartFormDataStream.Create;
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;

    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := FormData.RequestContentType;
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    Stream := TFileStream.Create(ArquivoMaisRecente, fmOpenRead or fmShareDenyWrite);
    try
      FormData.AddFormField('content', 'Crash da ultima sessao:');
      FormData.AddFile('file', ArquivoMaisRecente, 'application/octet-stream');

      try
        IdHTTP.Post(WebhookURL, FormData);
        //ShowMessage('Arquivo enviado com sucesso!');
        WriteLnToFile(ControleEnvio, ArquivoMaisRecente);
      except
        on E: Exception do
        begin
          //ShowMessage('Erro ao enviar para o Discord: ' + E.Message);
          Exit;
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FormData.Free;
    SSL.Free;
    IdHTTP.Free;
  end;
end;

//Servidor 2
procedure EnviarCrashLogS2;
var
  Ini: TIniFile;
  PastaLog, SubpastaMaisRecente, ArquivoMaisRecente, ControleEnvio, WebhookURL: string;
  Pastas: TStringList;
  i: Integer;
  DataMax, DataAtual, DataArqMax: TDateTime;
  Arquivos: TStringList;
  Arq: string;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FormData: TIdMultiPartFormDataStream;
  Stream: TFileStream;
begin
  //ShowMessage('Iniciando envio do crash log...');

  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\config.ini');
  try
    PastaLog := Ini.ReadString('Servidor 2', 'log', '');
    ControleEnvio := ExtractFilePath(ParamStr(0)) + 'temp\crash_enviadoS2.txt';
    WebhookURL := Ini.ReadString('CRASH', 'logS2', '');
  finally
    Ini.Free;
  end;

  if WebhookURL = '' then
  begin
    //ShowMessage('Webhook do Discord não encontrado no arquivo INI.');
    Exit;
  end;

  if not DirectoryExists(PastaLog) then
  begin
    //ShowMessage('A pasta de log "' + PastaLog + '" não existe.');
    Exit;
  end;

  //ShowMessage('Pasta de log: ' + PastaLog);

  Pastas := TStringList.Create;
  try
    FindAllDirectories(Pastas, PastaLog, False);
    DataMax := 0;
    SubpastaMaisRecente := '';

    for i := 0 to Pastas.Count - 1 do
    begin
      if TentarConverterDataISO8601(ExtractFileName(Pastas[i]), DataAtual) then
      begin
        if DataAtual > DataMax then
        begin
          DataMax := DataAtual;
          SubpastaMaisRecente := Pastas[i];
        end;
      end;
    end;
  finally
    Pastas.Free;
  end;

  if SubpastaMaisRecente = '' then
  begin
    //ShowMessage('Nenhuma subpasta válida (YYYY-MM-DD) encontrada.');
    Exit;
  end;

  //ShowMessage('Subpasta mais recente encontrada: ' + SubpastaMaisRecente);

  Arquivos := TStringList.Create;
  try
    FindAllFiles(Arquivos, SubpastaMaisRecente, '*.log', False);
    ArquivoMaisRecente := '';
    DataArqMax := 0;

    for i := 0 to Arquivos.Count - 1 do
    begin
      Arq := Arquivos[i];
      if Pos('crash', LowerCase(ExtractFileName(Arq))) > 0 then
      begin
        DataAtual := FileDateToDateTime(FileAge(Arq));
        if DataAtual > DataArqMax then
        begin
          DataArqMax := DataAtual;
          ArquivoMaisRecente := Arq;
        end;
      end;
    end;
  finally
    Arquivos.Free;
  end;

  if ArquivoMaisRecente = '' then
  begin
    //ShowMessage('Nenhum arquivo com "crash" no nome foi encontrado.');
    Exit;
  end;

  //ShowMessage('Crash da ultima sessão: ' + ArquivoMaisRecente);

  if FileExists(ControleEnvio) then
  begin
    if Trim(LowerCase(ArquivoMaisRecente)) = Trim(LowerCase(Trim(ReadLnFromFile(ControleEnvio)))) then
    begin
      //ShowMessage('Arquivo já foi enviado anteriormente.');
      Exit;
    end;
  end;

  //ShowMessage('Preparando para enviar o arquivo...');

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FormData := TIdMultiPartFormDataStream.Create;
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;

    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := FormData.RequestContentType;
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    Stream := TFileStream.Create(ArquivoMaisRecente, fmOpenRead or fmShareDenyWrite);
    try
      FormData.AddFormField('content', 'Crash da ultima sessao:');
      FormData.AddFile('file', ArquivoMaisRecente, 'application/octet-stream');

      try
        IdHTTP.Post(WebhookURL, FormData);
        //ShowMessage('Arquivo enviado com sucesso!');
        WriteLnToFile(ControleEnvio, ArquivoMaisRecente);
      except
        on E: Exception do
        begin
          //ShowMessage('Erro ao enviar para o Discord: ' + E.Message);
          Exit;
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FormData.Free;
    SSL.Free;
    IdHTTP.Free;
  end;
end;

//Servidor 3
procedure EnviarCrashLogS3;
var
  Ini: TIniFile;
  PastaLog, SubpastaMaisRecente, ArquivoMaisRecente, ControleEnvio, WebhookURL: string;
  Pastas: TStringList;
  i: Integer;
  DataMax, DataAtual, DataArqMax: TDateTime;
  Arquivos: TStringList;
  Arq: string;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  FormData: TIdMultiPartFormDataStream;
  Stream: TFileStream;
begin
  //ShowMessage('Iniciando envio do crash log...');

  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\config.ini');
  try
    PastaLog := Ini.ReadString('Servidor 3', 'log', '');
    ControleEnvio := ExtractFilePath(ParamStr(0)) + 'temp\crash_enviadoS3.txt';
    WebhookURL := Ini.ReadString('CRASH', 'logS3', '');
  finally
    Ini.Free;
  end;

  if WebhookURL = '' then
  begin
    //ShowMessage('Webhook do Discord não encontrado no arquivo INI.');
    Exit;
  end;

  if not DirectoryExists(PastaLog) then
  begin
    //ShowMessage('A pasta de log "' + PastaLog + '" não existe.');
    Exit;
  end;

  //ShowMessage('Pasta de log: ' + PastaLog);

  Pastas := TStringList.Create;
  try
    FindAllDirectories(Pastas, PastaLog, False);
    DataMax := 0;
    SubpastaMaisRecente := '';

    for i := 0 to Pastas.Count - 1 do
    begin
      if TentarConverterDataISO8601(ExtractFileName(Pastas[i]), DataAtual) then
      begin
        if DataAtual > DataMax then
        begin
          DataMax := DataAtual;
          SubpastaMaisRecente := Pastas[i];
        end;
      end;
    end;
  finally
    Pastas.Free;
  end;

  if SubpastaMaisRecente = '' then
  begin
    //ShowMessage('Nenhuma subpasta válida (YYYY-MM-DD) encontrada.');
    Exit;
  end;

  //ShowMessage('Subpasta mais recente encontrada: ' + SubpastaMaisRecente);

  Arquivos := TStringList.Create;
  try
    FindAllFiles(Arquivos, SubpastaMaisRecente, '*.log', False);
    ArquivoMaisRecente := '';
    DataArqMax := 0;

    for i := 0 to Arquivos.Count - 1 do
    begin
      Arq := Arquivos[i];
      if Pos('crash', LowerCase(ExtractFileName(Arq))) > 0 then
      begin
        DataAtual := FileDateToDateTime(FileAge(Arq));
        if DataAtual > DataArqMax then
        begin
          DataArqMax := DataAtual;
          ArquivoMaisRecente := Arq;
        end;
      end;
    end;
  finally
    Arquivos.Free;
  end;

  if ArquivoMaisRecente = '' then
  begin
    //ShowMessage('Nenhum arquivo com "crash" no nome foi encontrado.');
    Exit;
  end;

  //ShowMessage('Crash da ultima sessão: ' + ArquivoMaisRecente);

  if FileExists(ControleEnvio) then
  begin
    if Trim(LowerCase(ArquivoMaisRecente)) = Trim(LowerCase(Trim(ReadLnFromFile(ControleEnvio)))) then
    begin
      //ShowMessage('Arquivo já foi enviado anteriormente.');
      Exit;
    end;
  end;

  //ShowMessage('Preparando para enviar o arquivo...');

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FormData := TIdMultiPartFormDataStream.Create;
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;

    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := FormData.RequestContentType;
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    Stream := TFileStream.Create(ArquivoMaisRecente, fmOpenRead or fmShareDenyWrite);
    try
      FormData.AddFormField('content', 'Crash da ultima sessao:');
      FormData.AddFile('file', ArquivoMaisRecente, 'application/octet-stream');

      try
        IdHTTP.Post(WebhookURL, FormData);
        //ShowMessage('Arquivo enviado com sucesso!');
        WriteLnToFile(ControleEnvio, ArquivoMaisRecente);
      except
        on E: Exception do
        begin
          //ShowMessage('Erro ao enviar para o Discord: ' + E.Message);
          Exit;
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FormData.Free;
    SSL.Free;
    IdHTTP.Free;
  end;
end;
//End CrashLog

//KING OF THE HILL
//funcao para limpar arquivo de lgo no restart do servidor
function GetFileSizeByName(const FileName: string): Int64;
var
  FS: TFileStream;
begin
  Result := 0;
  if not FileExists(FileName) then Exit;
  FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    Result := FS.Size;
  finally
    FS.Free;
  end;
end;

//S1
function ObterArquivoMaisRecenteComNomeS1(parteNome, caminhoPasta: string): string;
var
  SR: TSearchRec;
  DataMaisRecente: TDateTime;
  NomeMaisRecente: string;
begin
  Result := '';
  DataMaisRecente := 0;

  if FindFirst(IncludeTrailingPathDelimiter(caminhoPasta) + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (Pos(parteNome, SR.Name) > 0) and ((SR.Attr and faDirectory) = 0) then
      begin
        if FileDateToDateTime(SR.Time) > DataMaisRecente then
        begin
          DataMaisRecente := FileDateToDateTime(SR.Time);
          NomeMaisRecente := SR.Name;
        end;
      end;
    until FindNext(SR) <> 0;
    SysUtils.FindClose(SR);
  end;

  if NomeMaisRecente <> '' then
    Result := IncludeTrailingPathDelimiter(caminhoPasta) + NomeMaisRecente;
end;

procedure ProcurarTodasKingOfTheHillS1DESATIVADOKOTHANTIGO;
var
  Ini: TIniFile;
  CaminhoIni, PastaProfile, ArquivoLog, OffsetFile, UltimoArquivo, LinhaOriginal, LinhaLimpa, TextoSubstituto, Hora, Linha, WebhookURL, JsonData: string;
  Offset: Int64;
  FS: TFileStream;
  SL: TStringList;
  Buffer: TMemoryStream;
  i, PosKOTH: Integer;
  ArqOffset: TStringList;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(CaminhoIni);
  try
    PastaProfile := Ini.ReadString('Servidor 1', 'profile', '');
    TextoSubstituto := Ini.ReadString('KOTH', 'localS1', '');
    WebhookURL := Ini.ReadString('KOTH', 'avisoS1', '');
  finally
    Ini.Free;
  end;

  if (PastaProfile = '') or (WebhookURL = '') or (not DirectoryExists(PastaProfile)) then Exit;

  ArquivoLog := ObterArquivoMaisRecenteComNomeS1('script', PastaProfile);
  if (ArquivoLog = '') or (not FileExists(ArquivoLog)) then Exit;

  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_offsets1.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToInt64Def(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;
  //essas 3 linhas era usadas no cod inicial, mas estava falhando porque ao reinciiar o servidor nao zerava o contador do log
  //if not SameText(UltimoArquivo, ArquivoLog) then
  //  Offset := 0;

  //nova funcao para zerar o contador do log no restart do servidor, substituido as 3 linhas acima
    if not SameText(UltimoArquivo, ArquivoLog) then
      begin
        Offset := 0;
        end
        else
      begin
  // Verifica se o arquivo atual é menor que o offset salvo (log reiniciado)
   if Offset > GetFileSizeByName(ArquivoLog) then
      begin
        Offset := 0;
        DeleteFile(OffsetFile);
      end;
   end;

  FS := nil;
  Buffer := TMemoryStream.Create;
  try
    FS := TFileStream.Create(ArquivoLog, fmOpenRead or fmShareDenyNone);
    if Offset < FS.Size then
    begin
      FS.Seek(Offset, soBeginning);
      Buffer.CopyFrom(FS, FS.Size - Offset);
      Buffer.Position := 0;

      SL := TStringList.Create;
      try
        SL.LoadFromStream(Buffer);

        IdHTTP := TIdHTTP.Create(nil);
        SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        try
          SSL.SSLOptions.Method := sslvTLSv1_2;
          IdHTTP.IOHandler := SSL;
          IdHTTP.Request.ContentType := 'application/json';
          IdHTTP.Request.Accept := 'application/json';
          IdHTTP.Request.UserAgent := 'Mozilla/5.0';

          for i := 0 to SL.Count - 1 do
          begin
            LinhaOriginal := SL[i];

            if Pos('[King of the Hill]', LinhaOriginal) > 0 then
            begin
              LinhaLimpa := LinhaOriginal;

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, 'SCRIPT', '', [rfReplaceAll, rfIgnoreCase]);

              // Remove ":" antes de [King of the Hill]
              PosKOTH := Pos('[King of the Hill]', LinhaLimpa);
              if (PosKOTH > 1) and (LinhaLimpa[PosKOTH - 1] = ':') then
                Delete(LinhaLimpa, PosKOTH - 1, 1);

              // Limpeza inicial
              while (Length(LinhaLimpa) > 0) and (LinhaLimpa[1] in [' ', ':']) do
                Delete(LinhaLimpa, 1, 1);

              // Substituição personalizada
              if TextoSubstituto <> '' then
                LinhaLimpa := StringReplace(LinhaLimpa, 'Start Fresh Event:', TextoSubstituto, [rfReplaceAll]);

              // Monta mensagem
              Hora := FormatDateTime('hh:nn:ss', Now);
              Linha := Hora + ' - ' + Trim(LinhaLimpa);

              // Envia para Discord
              JsonData := '{"content": "' + StringReplace(Linha, '"', '\"', [rfReplaceAll]) + '"}';
              PostData := TStringStream.Create(UTF8Encode(JsonData));
              try
                IdHTTP.Post(WebhookURL, PostData);
              except
                on E: Exception do Sleep(1000); // Silencioso
              end;
              PostData.Free;

              Sleep(500); // Evita spam/erro 429
            end;
          end;

        finally
          IdHTTP.Free;
          SSL.Free;
        end;

      finally
        SL.Free;
      end;
    end;

    // Atualiza posição
    ArqOffset := TStringList.Create;
    try
//    ArqOffset.Values[ArquivoLog] := IntToStr(FS.Size);
      ArqOffset.Values[ArquivoLog] := IntToStr(Offset + Buffer.Size);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    FS.Free;
    Buffer.Free;
  end;
end;

//NOVO KOTH MZ S1
procedure ProcurarTodasKingOfTheHillS1;
var
  Ini: TIniFile;
  CaminhoIni, PastaProfile, ArquivoLog, OffsetFile, UltimoArquivo, LinhaOriginal, LinhaLimpa, TextoSubstituto, Hora, Linha, WebhookURL, JsonData: string;
  Offset: Int64;
  FS: TFileStream;
  SL: TStringList;
  Buffer: TMemoryStream;
  i, PosKOTH: Integer;
  ArqOffset: TStringList;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(CaminhoIni);
  try
    PastaProfile := Ini.ReadString('Servidor 1', 'profile', '');
    TextoSubstituto := Ini.ReadString('KOTH', 'localS1', '');
    WebhookURL := Ini.ReadString('KOTH', 'avisoS1', '');
  finally
    Ini.Free;
  end;

  if (PastaProfile = '') or (WebhookURL = '') or (not DirectoryExists(PastaProfile)) then Exit;

  ArquivoLog := ObterArquivoMaisRecenteComNomeS1('script', PastaProfile);
  if (ArquivoLog = '') or (not FileExists(ArquivoLog)) then Exit;

  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_offsets1.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToInt64Def(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;

  //essas 3 linhas era usadas no cod inicial, mas estava falhando porque ao reinciiar o servidor nao zerava o contador do log
  //if not SameText(UltimoArquivo, ArquivoLog) then
  //  Offset := 0;

  //nova funcao para zerar o contador do log no restart do servidor, substituido as 3 linhas acima
    if not SameText(UltimoArquivo, ArquivoLog) then
      begin
        Offset := 0;
        end
        else
      begin
  // Verifica se o arquivo atual é menor que o offset salvo (log reiniciado)
   if Offset > GetFileSizeByName(ArquivoLog) then
      begin
        Offset := 0;
        DeleteFile(OffsetFile);
      end;
   end;

  FS := nil;
  Buffer := TMemoryStream.Create;
  try
    FS := TFileStream.Create(ArquivoLog, fmOpenRead or fmShareDenyNone);
    if Offset < FS.Size then
    begin
      FS.Seek(Offset, soBeginning);
      Buffer.CopyFrom(FS, FS.Size - Offset);
      Buffer.Position := 0;

      SL := TStringList.Create;
      try
        SL.LoadFromStream(Buffer);

        IdHTTP := TIdHTTP.Create(nil);
        SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        try
          SSL.SSLOptions.Method := sslvTLSv1_2;
          IdHTTP.IOHandler := SSL;
          IdHTTP.Request.ContentType := 'application/json';
          IdHTTP.Request.Accept := 'application/json';
          IdHTTP.Request.UserAgent := 'Mozilla/5.0';

          for i := 0 to SL.Count - 1 do
          begin
            LinhaOriginal := SL[i];

            if Pos('Spawning KOTH flag', LinhaOriginal) > 0 then
            begin
              LinhaLimpa := LinhaOriginal;

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, 'SCRIPT', '', [rfReplaceAll, rfIgnoreCase]);

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, '[MerkZone KOTH]', '', [rfReplaceAll, rfIgnoreCase]);


              // Remove ":" antes de [King of the Hill]
              PosKOTH := Pos('[MerkZone KOTH]', LinhaLimpa);
              if (PosKOTH > 1) and (LinhaLimpa[PosKOTH - 1] = ':') then
                Delete(LinhaLimpa, PosKOTH - 1, 1);

              // Limpeza inicial
              while (Length(LinhaLimpa) > 0) and (LinhaLimpa[1] in [' ', ':']) do
                Delete(LinhaLimpa, 1, 1);

              // Substituição personalizada
              if TextoSubstituto <> '' then
                LinhaLimpa := StringReplace(LinhaLimpa, 'Spawning KOTH flag.', TextoSubstituto, [rfReplaceAll]);

              // Monta mensagem
              Hora := FormatDateTime('hh:nn:ss', Now);
              Linha := Hora + ' - ' + Trim(LinhaLimpa);

              // Envia para Discord
              JsonData := '{"content": "' + StringReplace(Linha, '"', '\"', [rfReplaceAll]) + '"}';
              PostData := TStringStream.Create(UTF8Encode(JsonData));
              try
                IdHTTP.Post(WebhookURL, PostData);
              except
                on E: Exception do Sleep(1000); // Silencioso
              end;
              PostData.Free;

              Sleep(500); // Evita spam/erro 429
            end;
          end;

        finally
          IdHTTP.Free;
          SSL.Free;
        end;

      finally
        SL.Free;
      end;
    end;

    // Atualiza posição
    ArqOffset := TStringList.Create;
    try
//    ArqOffset.Values[ArquivoLog] := IntToStr(FS.Size);
      ArqOffset.Values[ArquivoLog] := IntToStr(Offset + Buffer.Size);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    FS.Free;
    Buffer.Free;
  end;
end;
//TESTE NOVO KOTH END

//S2
function ObterArquivoMaisRecenteComNomeS2(parteNome, caminhoPasta: string): string;
var
  SR: TSearchRec;
  DataMaisRecente: TDateTime;
  NomeMaisRecente: string;
begin
  Result := '';
  DataMaisRecente := 0;

  if FindFirst(IncludeTrailingPathDelimiter(caminhoPasta) + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (Pos(parteNome, SR.Name) > 0) and ((SR.Attr and faDirectory) = 0) then
      begin
        if FileDateToDateTime(SR.Time) > DataMaisRecente then
        begin
          DataMaisRecente := FileDateToDateTime(SR.Time);
          NomeMaisRecente := SR.Name;
        end;
      end;
    until FindNext(SR) <> 0;
    SysUtils.FindClose(SR);
  end;

  if NomeMaisRecente <> '' then
    Result := IncludeTrailingPathDelimiter(caminhoPasta) + NomeMaisRecente;
end;

procedure ProcurarTodasKingOfTheHillS2DESATIVADOKOTHANTIGO;
var
  Ini: TIniFile;
  CaminhoIni, PastaProfile, ArquivoLog, OffsetFile, UltimoArquivo, LinhaOriginal, LinhaLimpa, TextoSubstituto, Hora, Linha, WebhookURL, JsonData: string;
  Offset: Int64;
  FS: TFileStream;
  SL: TStringList;
  Buffer: TMemoryStream;
  i, PosKOTH: Integer;
  ArqOffset: TStringList;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(CaminhoIni);
  try
    PastaProfile := Ini.ReadString('Servidor 2', 'profile', '');
    TextoSubstituto := Ini.ReadString('KOTH', 'localS1', '');
    WebhookURL := Ini.ReadString('KOTH', 'avisoS2', '');
  finally
    Ini.Free;
  end;

  if (PastaProfile = '') or (WebhookURL = '') or (not DirectoryExists(PastaProfile)) then Exit;

  ArquivoLog := ObterArquivoMaisRecenteComNomeS2('script', PastaProfile);
  if (ArquivoLog = '') or (not FileExists(ArquivoLog)) then Exit;

  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_offsets2.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToInt64Def(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;

  //essas 3 linhas era usadas no cod inicial, mas estava falhando porque ao reinciiar o servidor nao zerava o contador do log
  //if not SameText(UltimoArquivo, ArquivoLog) then
  //  Offset := 0;

  //nova funcao para zerar o contador do log no restart do servidor, substituido as 3 linhas acima
    if not SameText(UltimoArquivo, ArquivoLog) then
      begin
        Offset := 0;
        end
        else
      begin
  // Verifica se o arquivo atual é menor que o offset salvo (log reiniciado)
   if Offset > GetFileSizeByName(ArquivoLog) then
      begin
        Offset := 0;
        DeleteFile(OffsetFile);
      end;
   end;

  FS := nil;
  Buffer := TMemoryStream.Create;
  try
    FS := TFileStream.Create(ArquivoLog, fmOpenRead or fmShareDenyNone);
    if Offset < FS.Size then
    begin
      FS.Seek(Offset, soBeginning);
      Buffer.CopyFrom(FS, FS.Size - Offset);
      Buffer.Position := 0;

      SL := TStringList.Create;
      try
        SL.LoadFromStream(Buffer);

        IdHTTP := TIdHTTP.Create(nil);
        SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        try
          SSL.SSLOptions.Method := sslvTLSv1_2;
          IdHTTP.IOHandler := SSL;
          IdHTTP.Request.ContentType := 'application/json';
          IdHTTP.Request.Accept := 'application/json';
          IdHTTP.Request.UserAgent := 'Mozilla/5.0';

          for i := 0 to SL.Count - 1 do
          begin
            LinhaOriginal := SL[i];

            if Pos('[King of the Hill]', LinhaOriginal) > 0 then
            begin
              LinhaLimpa := LinhaOriginal;

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, 'SCRIPT', '', [rfReplaceAll, rfIgnoreCase]);

              // Remove ":" antes de [King of the Hill]
              PosKOTH := Pos('[King of the Hill]', LinhaLimpa);
              if (PosKOTH > 1) and (LinhaLimpa[PosKOTH - 1] = ':') then
                Delete(LinhaLimpa, PosKOTH - 1, 1);

              // Limpeza inicial
              while (Length(LinhaLimpa) > 0) and (LinhaLimpa[1] in [' ', ':']) do
                Delete(LinhaLimpa, 1, 1);

              // Substituição personalizada
              if TextoSubstituto <> '' then
                LinhaLimpa := StringReplace(LinhaLimpa, 'Start Fresh Event:', TextoSubstituto, [rfReplaceAll]);

              // Monta mensagem
              Hora := FormatDateTime('hh:nn:ss', Now);
              Linha := Hora + ' - ' + Trim(LinhaLimpa);

              // Envia para Discord
              JsonData := '{"content": "' + StringReplace(Linha, '"', '\"', [rfReplaceAll]) + '"}';
              PostData := TStringStream.Create(UTF8Encode(JsonData));
              try
                IdHTTP.Post(WebhookURL, PostData);
              except
                on E: Exception do Sleep(1000); // Silencioso
              end;
              PostData.Free;

              Sleep(500); // Evita spam/erro 429
            end;
          end;

        finally
          IdHTTP.Free;
          SSL.Free;
        end;

      finally
        SL.Free;
      end;
    end;

    // Atualiza posição
    ArqOffset := TStringList.Create;
    try
//    ArqOffset.Values[ArquivoLog] := IntToStr(FS.Size);
      ArqOffset.Values[ArquivoLog] := IntToStr(Offset + Buffer.Size);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    FS.Free;
    Buffer.Free;
  end;
end;

//NOVO KOTH MZ S2
procedure ProcurarTodasKingOfTheHillS2;
var
  Ini: TIniFile;
  CaminhoIni, PastaProfile, ArquivoLog, OffsetFile, UltimoArquivo, LinhaOriginal, LinhaLimpa, TextoSubstituto, Hora, Linha, WebhookURL, JsonData: string;
  Offset: Int64;
  FS: TFileStream;
  SL: TStringList;
  Buffer: TMemoryStream;
  i, PosKOTH: Integer;
  ArqOffset: TStringList;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(CaminhoIni);
  try
    PastaProfile := Ini.ReadString('Servidor 2', 'profile', '');
    TextoSubstituto := Ini.ReadString('KOTH', 'localS1', '');
    WebhookURL := Ini.ReadString('KOTH', 'avisoS2', '');
  finally
    Ini.Free;
  end;

  if (PastaProfile = '') or (WebhookURL = '') or (not DirectoryExists(PastaProfile)) then Exit;

  ArquivoLog := ObterArquivoMaisRecenteComNomeS2('script', PastaProfile);
  if (ArquivoLog = '') or (not FileExists(ArquivoLog)) then Exit;

  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_offsets2.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToInt64Def(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;

  //essas 3 linhas era usadas no cod inicial, mas estava falhando porque ao reinciiar o servidor nao zerava o contador do log
  //if not SameText(UltimoArquivo, ArquivoLog) then
  //  Offset := 0;

  //nova funcao para zerar o contador do log no restart do servidor, substituido as 3 linhas acima
    if not SameText(UltimoArquivo, ArquivoLog) then
      begin
        Offset := 0;
        end
        else
      begin
  // Verifica se o arquivo atual é menor que o offset salvo (log reiniciado)
   if Offset > GetFileSizeByName(ArquivoLog) then
      begin
        Offset := 0;
        DeleteFile(OffsetFile);
      end;
   end;

  FS := nil;
  Buffer := TMemoryStream.Create;
  try
    FS := TFileStream.Create(ArquivoLog, fmOpenRead or fmShareDenyNone);
    if Offset < FS.Size then
    begin
      FS.Seek(Offset, soBeginning);
      Buffer.CopyFrom(FS, FS.Size - Offset);
      Buffer.Position := 0;

      SL := TStringList.Create;
      try
        SL.LoadFromStream(Buffer);

        IdHTTP := TIdHTTP.Create(nil);
        SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        try
          SSL.SSLOptions.Method := sslvTLSv1_2;
          IdHTTP.IOHandler := SSL;
          IdHTTP.Request.ContentType := 'application/json';
          IdHTTP.Request.Accept := 'application/json';
          IdHTTP.Request.UserAgent := 'Mozilla/5.0';

          for i := 0 to SL.Count - 1 do
          begin
            LinhaOriginal := SL[i];

            if Pos('Spawning KOTH flag', LinhaOriginal) > 0 then
            begin
              LinhaLimpa := LinhaOriginal;

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, 'SCRIPT', '', [rfReplaceAll, rfIgnoreCase]);

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, '[MerkZone KOTH]', '', [rfReplaceAll, rfIgnoreCase]);


              // Remove ":" antes de [King of the Hill]
              PosKOTH := Pos('[MerkZone KOTH]', LinhaLimpa);
              if (PosKOTH > 1) and (LinhaLimpa[PosKOTH - 1] = ':') then
                Delete(LinhaLimpa, PosKOTH - 1, 1);

              // Limpeza inicial
              while (Length(LinhaLimpa) > 0) and (LinhaLimpa[1] in [' ', ':']) do
                Delete(LinhaLimpa, 1, 1);

              // Substituição personalizada
              if TextoSubstituto <> '' then
                LinhaLimpa := StringReplace(LinhaLimpa, 'Spawning KOTH flag.', TextoSubstituto, [rfReplaceAll]);

              // Monta mensagem
              Hora := FormatDateTime('hh:nn:ss', Now);
              Linha := Hora + ' - ' + Trim(LinhaLimpa);

              // Envia para Discord
              JsonData := '{"content": "' + StringReplace(Linha, '"', '\"', [rfReplaceAll]) + '"}';
              PostData := TStringStream.Create(UTF8Encode(JsonData));
              try
                IdHTTP.Post(WebhookURL, PostData);
              except
                on E: Exception do Sleep(1000); // Silencioso
              end;
              PostData.Free;

              Sleep(500); // Evita spam/erro 429
            end;
          end;

        finally
          IdHTTP.Free;
          SSL.Free;
        end;

      finally
        SL.Free;
      end;
    end;

    // Atualiza posição
    ArqOffset := TStringList.Create;
    try
//    ArqOffset.Values[ArquivoLog] := IntToStr(FS.Size);
      ArqOffset.Values[ArquivoLog] := IntToStr(Offset + Buffer.Size);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    FS.Free;
    Buffer.Free;
  end;
end;
//TESTE NOVO KOTH END

//S3
function ObterArquivoMaisRecenteComNomeS3(parteNome, caminhoPasta: string): string;
var
  SR: TSearchRec;
  DataMaisRecente: TDateTime;
  NomeMaisRecente: string;
begin
  Result := '';
  DataMaisRecente := 0;

  if FindFirst(IncludeTrailingPathDelimiter(caminhoPasta) + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (Pos(parteNome, SR.Name) > 0) and ((SR.Attr and faDirectory) = 0) then
      begin
        if FileDateToDateTime(SR.Time) > DataMaisRecente then
        begin
          DataMaisRecente := FileDateToDateTime(SR.Time);
          NomeMaisRecente := SR.Name;
        end;
      end;
    until FindNext(SR) <> 0;
    SysUtils.FindClose(SR);
  end;

  if NomeMaisRecente <> '' then
    Result := IncludeTrailingPathDelimiter(caminhoPasta) + NomeMaisRecente;
end;

procedure ProcurarTodasKingOfTheHillS3DESATIVADOKOTHANTIGO;
var
  Ini: TIniFile;
  CaminhoIni, PastaProfile, ArquivoLog, OffsetFile, UltimoArquivo, LinhaOriginal, LinhaLimpa, TextoSubstituto, Hora, Linha, WebhookURL, JsonData: string;
  Offset: Int64;
  FS: TFileStream;
  SL: TStringList;
  Buffer: TMemoryStream;
  i, PosKOTH: Integer;
  ArqOffset: TStringList;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(CaminhoIni);
  try
    PastaProfile := Ini.ReadString('Servidor 3', 'profile', '');
    TextoSubstituto := Ini.ReadString('KOTH', 'localS1', '');
    WebhookURL := Ini.ReadString('KOTH', 'avisoS3', '');
  finally
    Ini.Free;
  end;

  if (PastaProfile = '') or (WebhookURL = '') or (not DirectoryExists(PastaProfile)) then Exit;

  ArquivoLog := ObterArquivoMaisRecenteComNomeS3('script', PastaProfile);
  if (ArquivoLog = '') or (not FileExists(ArquivoLog)) then Exit;

  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_offsets3.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToInt64Def(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;

  if not SameText(UltimoArquivo, ArquivoLog) then
    Offset := 0;

  FS := nil;
  Buffer := TMemoryStream.Create;
  try
    FS := TFileStream.Create(ArquivoLog, fmOpenRead or fmShareDenyNone);
    if Offset < FS.Size then
    begin
      FS.Seek(Offset, soBeginning);
      Buffer.CopyFrom(FS, FS.Size - Offset);
      Buffer.Position := 0;

      SL := TStringList.Create;
      try
        SL.LoadFromStream(Buffer);

        IdHTTP := TIdHTTP.Create(nil);
        SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        try
          SSL.SSLOptions.Method := sslvTLSv1_2;
          IdHTTP.IOHandler := SSL;
          IdHTTP.Request.ContentType := 'application/json';
          IdHTTP.Request.Accept := 'application/json';
          IdHTTP.Request.UserAgent := 'Mozilla/5.0';

          for i := 0 to SL.Count - 1 do
          begin
            LinhaOriginal := SL[i];

            if Pos('[King of the Hill]', LinhaOriginal) > 0 then
            begin
              LinhaLimpa := LinhaOriginal;

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, 'SCRIPT', '', [rfReplaceAll, rfIgnoreCase]);

              // Remove ":" antes de [King of the Hill]
              PosKOTH := Pos('[King of the Hill]', LinhaLimpa);
              if (PosKOTH > 1) and (LinhaLimpa[PosKOTH - 1] = ':') then
                Delete(LinhaLimpa, PosKOTH - 1, 1);

              // Limpeza inicial
              while (Length(LinhaLimpa) > 0) and (LinhaLimpa[1] in [' ', ':']) do
                Delete(LinhaLimpa, 1, 1);

              // Substituição personalizada
              if TextoSubstituto <> '' then
                LinhaLimpa := StringReplace(LinhaLimpa, 'Start Fresh Event:', TextoSubstituto, [rfReplaceAll]);

              // Monta mensagem
              Hora := FormatDateTime('hh:nn:ss', Now);
              Linha := Hora + ' - ' + Trim(LinhaLimpa);

              // Envia para Discord
              JsonData := '{"content": "' + StringReplace(Linha, '"', '\"', [rfReplaceAll]) + '"}';
              PostData := TStringStream.Create(UTF8Encode(JsonData));
              try
                IdHTTP.Post(WebhookURL, PostData);
              except
                on E: Exception do Sleep(1000); // Silencioso
              end;
              PostData.Free;

              Sleep(500); // Evita spam/erro 429
            end;
          end;

        finally
          IdHTTP.Free;
          SSL.Free;
        end;

      finally
        SL.Free;
      end;
    end;

    // Atualiza posição
    ArqOffset := TStringList.Create;
    try
//    ArqOffset.Values[ArquivoLog] := IntToStr(FS.Size);
      ArqOffset.Values[ArquivoLog] := IntToStr(Offset + Buffer.Size);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    FS.Free;
    Buffer.Free;
  end;
end;
//END

//NOVO KOTH MZ S3
procedure ProcurarTodasKingOfTheHillS3;
var
  Ini: TIniFile;
  CaminhoIni, PastaProfile, ArquivoLog, OffsetFile, UltimoArquivo, LinhaOriginal, LinhaLimpa, TextoSubstituto, Hora, Linha, WebhookURL, JsonData: string;
  Offset: Int64;
  FS: TFileStream;
  SL: TStringList;
  Buffer: TMemoryStream;
  i, PosKOTH: Integer;
  ArqOffset: TStringList;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(CaminhoIni);
  try
    PastaProfile := Ini.ReadString('Servidor 3', 'profile', '');
    TextoSubstituto := Ini.ReadString('KOTH', 'localS1', '');
    WebhookURL := Ini.ReadString('KOTH', 'avisoS3', '');
  finally
    Ini.Free;
  end;

  if (PastaProfile = '') or (WebhookURL = '') or (not DirectoryExists(PastaProfile)) then Exit;

  ArquivoLog := ObterArquivoMaisRecenteComNomeS3('script', PastaProfile);
  if (ArquivoLog = '') or (not FileExists(ArquivoLog)) then Exit;

  OffsetFile := ExtractFilePath(ParamStr(0)) + 'temp\log_offsets3.txt';
  ForceDirectories(ExtractFilePath(OffsetFile));

  Offset := 0;
  UltimoArquivo := '';

  if FileExists(OffsetFile) then
  begin
    ArqOffset := TStringList.Create;
    try
      ArqOffset.LoadFromFile(OffsetFile);
      if ArqOffset.Count > 0 then
      begin
        UltimoArquivo := Trim(ArqOffset.Names[0]);
        Offset := StrToInt64Def(ArqOffset.ValueFromIndex[0], 0);
      end;
    finally
      ArqOffset.Free;
    end;
  end;

  //essas 3 linhas era usadas no cod inicial, mas estava falhando porque ao reinciiar o servidor nao zerava o contador do log
  //if not SameText(UltimoArquivo, ArquivoLog) then
  //  Offset := 0;

  //nova funcao para zerar o contador do log no restart do servidor, substituido as 3 linhas acima
    if not SameText(UltimoArquivo, ArquivoLog) then
      begin
        Offset := 0;
        end
        else
      begin
  // Verifica se o arquivo atual é menor que o offset salvo (log reiniciado)
   if Offset > GetFileSizeByName(ArquivoLog) then
      begin
        Offset := 0;
        DeleteFile(OffsetFile);
      end;
   end;

  FS := nil;
  Buffer := TMemoryStream.Create;
  try
    FS := TFileStream.Create(ArquivoLog, fmOpenRead or fmShareDenyNone);
    if Offset < FS.Size then
    begin
      FS.Seek(Offset, soBeginning);
      Buffer.CopyFrom(FS, FS.Size - Offset);
      Buffer.Position := 0;

      SL := TStringList.Create;
      try
        SL.LoadFromStream(Buffer);

        IdHTTP := TIdHTTP.Create(nil);
        SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        try
          SSL.SSLOptions.Method := sslvTLSv1_2;
          IdHTTP.IOHandler := SSL;
          IdHTTP.Request.ContentType := 'application/json';
          IdHTTP.Request.Accept := 'application/json';
          IdHTTP.Request.UserAgent := 'Mozilla/5.0';

          for i := 0 to SL.Count - 1 do
          begin
            LinhaOriginal := SL[i];

            if Pos('Spawning KOTH flag', LinhaOriginal) > 0 then
            begin
              LinhaLimpa := LinhaOriginal;

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, 'SCRIPT', '', [rfReplaceAll, rfIgnoreCase]);

              // Remove SCRIPT
              LinhaLimpa := StringReplace(LinhaLimpa, '[MerkZone KOTH]', '', [rfReplaceAll, rfIgnoreCase]);


              // Remove ":" antes de [King of the Hill]
              PosKOTH := Pos('[MerkZone KOTH]', LinhaLimpa);
              if (PosKOTH > 1) and (LinhaLimpa[PosKOTH - 1] = ':') then
                Delete(LinhaLimpa, PosKOTH - 1, 1);

              // Limpeza inicial
              while (Length(LinhaLimpa) > 0) and (LinhaLimpa[1] in [' ', ':']) do
                Delete(LinhaLimpa, 1, 1);

              // Substituição personalizada
              if TextoSubstituto <> '' then
                LinhaLimpa := StringReplace(LinhaLimpa, 'Spawning KOTH flag.', TextoSubstituto, [rfReplaceAll]);

              // Monta mensagem
              Hora := FormatDateTime('hh:nn:ss', Now);
              Linha := Hora + ' - ' + Trim(LinhaLimpa);

              // Envia para Discord
              JsonData := '{"content": "' + StringReplace(Linha, '"', '\"', [rfReplaceAll]) + '"}';
              PostData := TStringStream.Create(UTF8Encode(JsonData));
              try
                IdHTTP.Post(WebhookURL, PostData);
              except
                on E: Exception do Sleep(1000); // Silencioso
              end;
              PostData.Free;

              Sleep(500); // Evita spam/erro 429
            end;
          end;

        finally
          IdHTTP.Free;
          SSL.Free;
        end;

      finally
        SL.Free;
      end;
    end;

    // Atualiza posição
    ArqOffset := TStringList.Create;
    try
//    ArqOffset.Values[ArquivoLog] := IntToStr(FS.Size);
      ArqOffset.Values[ArquivoLog] := IntToStr(Offset + Buffer.Size);
      ArqOffset.SaveToFile(OffsetFile);
    finally
      ArqOffset.Free;
    end;

  finally
    FS.Free;
    Buffer.Free;
  end;
end;
//TESTE NOVO KOTH END

//MONITORA IP E INFORMA NO DISCORD SUA MUDANCA
procedure EnviarParaDiscord(const WebhookURL, Mensagem: string);
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  JsonData: string;
  PostData: TStringStream;
begin
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    JsonData := '{"content": "' + StringReplace(Mensagem, '"', '\"', [rfReplaceAll]) + '"}';
    PostData := TStringStream.Create(UTF8Encode(JsonData));
    try
      IdHTTP.Post(WebhookURL, PostData);
    finally
      PostData.Free;
    end;

  finally
    IdHTTP.Free;
    SSL.Free;
  end;
end;

procedure VerificarIPModem;
var
  Http: TIdHTTP;
  IpAtual, IpAnterior: string;
  Ini: TIniFile;
  CaminhoIni: string;
  ListaWebhooks: TStringList;
  i: Integer;
begin
  CaminhoIni := ExtractFilePath(Application.ExeName) + 'Config\config.ini';

  if not DirectoryExists(ExtractFilePath(CaminhoIni)) then
    ForceDirectories(ExtractFilePath(CaminhoIni));

  Ini := TIniFile.Create(CaminhoIni);
  Http := TIdHTTP.Create(nil);
  try
    Http.HandleRedirects := True;
    try
      IpAtual := Trim(Http.Get('https://checkip.amazonaws.com'));
    except
      on E: Exception do
      begin
        //ShowMessage('Erro ao obter IP: ' + E.Message);
        Exit;
      end;
    end;

    IpAnterior := Ini.ReadString('IP', 'ip', '');

    if IpAnterior = '' then
    begin
      Ini.WriteString('IP', 'ip', IpAtual);
      //ShowMessage('IP registrado pela primeira vez: ' + IpAtual);
    end
    else if IpAtual <> IpAnterior then
    begin
      Ini.WriteString('IP', 'ip', IpAtual);
      //ShowMessage('IP mudou de ' + IpAnterior + ' para ' + IpAtual);

      // Coleta e evita webhooks duplicados
      ListaWebhooks := TStringList.Create;
      try
        ListaWebhooks.Sorted := True;
        ListaWebhooks.Duplicates := dupIgnore;

        ListaWebhooks.Add(Ini.ReadString('Servidor 1', 'webhookavisos', ''));
        ListaWebhooks.Add(Ini.ReadString('Servidor 2', 'webhookavisos', ''));
        ListaWebhooks.Add(Ini.ReadString('Servidor 3', 'webhookavisos', ''));

        for i := 0 to ListaWebhooks.Count - 1 do
        begin
          if ListaWebhooks[i] <> '' then
            EnviarParaDiscord(ListaWebhooks[i], '====================\nIMPORTANTE!\n\nO IP do servidor mudou para: ' + IpAtual + '\nPor favor, pesquise novamente pelo servidor na aba da comunidade.\nDesculpe o transtorno e obrigado pela compreensão!');
        end;
      finally
        ListaWebhooks.Free;
      end;

    end
    else
    begin
      //ShowMessage('IP não mudou. IP atual: ' + IpAtual);
    end;
  finally
    Ini.Free;
    Http.Free;
  end;
end;

//END


//FUNCAO PARA LOCALIZAR O EXECUTAVEL DO GOOGLE DRIVER E MANTER O CAMINHO SEMPRE ATUALIZADO MESMO O GOOGLE MUDANDO-O
function LocalizarGoogleDriveExe(const PastaBase: string): string;
var
  SR: TSearchRec;
begin
  Result := '';

  // Procura recursivamente o executável
  if FindFirst(PastaBase + '\*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) <> 0 then
      begin
        if (SR.Name <> '.') and (SR.Name <> '..') then
          Result := LocalizarGoogleDriveExe(PastaBase + '\' + SR.Name); // entra nas subpastas
      end
      else if AnsiSameText(SR.Name, 'GoogleDriveFS.exe') then
      begin
        Result := PastaBase + '\' + SR.Name;
        Break;
      end;
    until (FindNext(SR) <> 0) or (Result <> '');
    SysUtils.FindClose(SR);
  end;
end;
//END

//FINDER CAR

//BANOV
procedure TForm1.FinderCarServer1Timer(Sender: TObject);
var
  vFileList, IgnorarLista: TStringList;
  vFileStream: TFileStream;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData, DirPath, LatestFile, LogLine, TimestampStr: string;
  SearchRec: TSearchRec;
  LatestTime, LogStartTime, LogEntryTime: TDateTime;
  PosIndex, EndIndex, i, j: Integer;
  TimeDiff: Double;
  Ini: TIniFile;
  SourceDir: string;
  ConfigFilePath: string;
  IgnorarFiltroAtivo: Boolean;
  NomeVeiculo, LinhaLimpa: string;
  Reg: TRegistry;
begin
  if FirstRun1 then
  begin
    FirstRun1 := False;
    FinderCarServer1.Interval := 300000; // 5 minutos
    Exit;
  end;

  ConfigFilePath := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(ConfigFilePath);
  try
    SourceDir := Ini.ReadString('Servidor 1', 'Profile', '');
    WebhookURL := Ini.ReadString('Servidor 1', 'carfinder', '');
  finally
    Ini.Free;
  end;

  EnviarServerConsoleLogS1;

  if (SourceDir = '') or (WebhookURL = '') then Exit;

  DirPath := IncludeTrailingPathDelimiter(SourceDir);

  LatestFile := '';
  LatestTime := 0;
  if FindFirst(DirPath + '*MCK*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SearchRec.Time) > LatestTime then
        begin
          LatestTime := FileDateToDateTime(SearchRec.Time);
          LatestFile := SearchRec.Name;
        end;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;

  if LatestFile = '' then Exit;

  vFileList := TStringList.Create;
  IgnorarLista := TStringList.Create;
  Reg := TRegistry.Create;
  try
    vFileStream := TFileStream.Create(DirPath + LatestFile, fmOpenRead or fmShareDenyNone);
    try
      vFileList.LoadFromStream(vFileStream);
    finally
      vFileStream.Free;
    end;

    // Verifica se o filtro está ativado no registro
    IgnorarFiltroAtivo := False;
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly('\SOFTWARE\HFManager\Config') then
    begin
      if Reg.ValueExists('Not_CarFinderS1') then
        IgnorarFiltroAtivo := Reg.ReadInteger('Not_CarFinderS1') = 1;
      Reg.CloseKey;
    end;

    if IgnorarFiltroAtivo then
    begin
      try
        IgnorarLista.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Config\not_carfinder.txt');
      except
        IgnorarFiltroAtivo := False;
      end;
    end;

    LogStartTime := 0;

    IdHTTP := TIdHTTP.Create(nil);
    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      SSL.SSLOptions.Method := sslvTLSv1_2;
      IdHTTP.IOHandler := SSL;
      IdHTTP.Request.ContentType := 'application/json';
      IdHTTP.Request.Accept := 'application/json';
      IdHTTP.Request.UserAgent := 'Mozilla/5.0';

      for i := 0 to vFileList.Count - 1 do
      begin
        LogLine := vFileList.Strings[i];
        if Pos('PLAYER', UpperCase(LogLine)) > 0 then Continue;
        if Trim(LogLine) = '' then Continue;

        // Tenta extrair timestamp
        if Length(LogLine) >= 8 then
        begin
          TimestampStr := Copy(LogLine, 1, 8);
          try
            LogEntryTime := StrToTime(TimestampStr);
            if LogStartTime = 0 then
              LogStartTime := LogEntryTime;

            TimeDiff := (LogEntryTime - LogStartTime) * 86400;
            if TimeDiff > 240 then Continue;
          except
          end;
        end;

        // Aplica filtro de veículos ignorados
        if IgnorarFiltroAtivo then
        begin
          LinhaLimpa := Trim(Copy(LogLine, 10, MaxInt)); // remove timestamp
          PosIndex := Pos('(', LinhaLimpa);
          if PosIndex > 0 then
            NomeVeiculo := Trim(Copy(LinhaLimpa, 1, PosIndex - 1))
          else
            NomeVeiculo := LinhaLimpa;

          for j := 0 to IgnorarLista.Count - 1 do
          begin
            if Pos(LowerCase(Trim(IgnorarLista[j])), LowerCase(NomeVeiculo)) > 0 then
            begin
              LogLine := ''; // Ignorar linha
              Break;
            end;
          end;
          if LogLine = '' then Continue;
        end;

        // Ajusta a posição
        PosIndex := Pos('pos <', LogLine);
        if PosIndex > 0 then
        begin
          EndIndex := Pos('>', LogLine);
          if EndIndex > PosIndex then
            LogLine := Copy(LogLine, 1, EndIndex + 1);
        end;

        JsonData := '{"content": "' + StringReplace(LogLine, '"', '\"', [rfReplaceAll]) + '"}';
        PostData := TStringStream.Create(UTF8Encode(JsonData));
        try
          IdHTTP.Post(WebhookURL, PostData);
        except
          on E: Exception do Sleep(1000);
        end;
        PostData.Free;
        Sleep(1000);
      end;

      JsonData := '{"content": "\n=> End"}';
      PostData := TStringStream.Create(UTF8Encode(JsonData));
      try
        IdHTTP.Post(WebhookURL, PostData);
        Form1.FinderCarServer1.Enabled := False;

      except
        on E: Exception do Sleep(1000);
      end;
      PostData.Free;

    finally
      IdHTTP.Free;
      SSL.Free;
    end;
  finally
    vFileList.Free;
    IgnorarLista.Free;
    Reg.Free;
  end;
end;

//FINDER CAR CHERNO
function ExtrairIDVeiculo(const Linha: string): string;
var
  p1, p2: Integer;
begin
  Result := '';
  p1 := Pos('(ID: ', Linha);
  if p1 = 0 then Exit;
  p1 := p1 + Length('(ID: ');
  p2 := Pos(' -', Copy(Linha, p1, MaxInt));
  if p2 = 0 then Exit;
  Result := Copy(Linha, p1, p2 - 1);
end;

function ObterDonoVeiculo(const Donos: TStringList; const ID: string): string;
var
  idx: Integer;
begin
  Result := '';
  idx := Donos.IndexOfName(ID);
  if idx <> -1 then
    Result := Donos.ValueFromIndex[idx];
end;

procedure TForm1.FinderCarServer2Timer(Sender: TObject);
var
  vFileList, IgnorarLista, DonosVeiculos: TStringList;
  vFileStream: TFileStream;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData, DirPath, LatestFile, LogLine, TimestampStr: string;
  SearchRec: TSearchRec;
  LatestTime, LogStartTime, LogEntryTime: TDateTime;
  PosIndex, EndIndex, i, j: Integer;
  TimeDiff: Double;
  Ini: TIniFile;
  SourceDir, ConfigFilePath, NomeVeiculo, LinhaLimpa: string;
  Reg: TRegistry;
  IgnorarFiltroAtivo: Boolean;
  IDVeiculo, Dono: string;

  function ExtrairIDVeiculo(const Linha: string): string;
  var
    p1, p2: Integer;
  begin
    Result := '';
    p1 := Pos('(ID: ', Linha);
    if p1 = 0 then Exit;
    p1 := p1 + Length('(ID: ');
    p2 := Pos(' -', Copy(Linha, p1, MaxInt));
    if p2 = 0 then Exit;
    Result := Copy(Linha, p1, p2 - 1);
  end;

begin
  if FirstRun2 then
  begin
    FirstRun2 := False;
    FinderCarServer2.Interval := 300000;
    Exit;
  end;

  ConfigFilePath := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(ConfigFilePath);
  try
    SourceDir := Ini.ReadString('Servidor 2', 'Profile', '');
    WebhookURL := Ini.ReadString('Servidor 2', 'carfinder', '');
  finally
    Ini.Free;
  end;

  EnviarServerConsoleLogS2;

  if (SourceDir = '') or (WebhookURL = '') then Exit;

  DirPath := IncludeTrailingPathDelimiter(SourceDir);

  LatestFile := '';
  LatestTime := 0;
  if FindFirst(DirPath + '*MCK*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SearchRec.Time) > LatestTime then
        begin
          LatestTime := FileDateToDateTime(SearchRec.Time);
          LatestFile := SearchRec.Name;
        end;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;

  if LatestFile = '' then Exit;

  vFileList := TStringList.Create;
  IgnorarLista := TStringList.Create;
  DonosVeiculos := TStringList.Create;
  Reg := TRegistry.Create;
  try
    if FileExists(ExtractFilePath(ParamStr(0)) + 'temp\vehicle_owners_s2.txt') then
      DonosVeiculos.LoadFromFile(
        ExtractFilePath(ParamStr(0)) + 'temp\vehicle_owners_s2.txt'
      );

    vFileStream := TFileStream.Create(DirPath + LatestFile, fmOpenRead or fmShareDenyNone);
    try
      vFileList.LoadFromStream(vFileStream);
    finally
      vFileStream.Free;
    end;

    IgnorarFiltroAtivo := False;
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly('\SOFTWARE\HFManager\Config') then
    begin
      if Reg.ValueExists('Not_CarFinderS2') then
        IgnorarFiltroAtivo := Reg.ReadInteger('Not_CarFinderS2') = 1;
      Reg.CloseKey;
    end;

    if IgnorarFiltroAtivo then
    begin
      try
        IgnorarLista.LoadFromFile(
          ExtractFilePath(ParamStr(0)) + 'Config\not_carfinder.txt'
        );
      except
        IgnorarFiltroAtivo := False;
      end;
    end;

    LogStartTime := 0;

    IdHTTP := TIdHTTP.Create(nil);
    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      SSL.SSLOptions.Method := sslvTLSv1_2;
      IdHTTP.IOHandler := SSL;
      IdHTTP.Request.ContentType := 'application/json';
      IdHTTP.Request.Accept := 'application/json';
      IdHTTP.Request.UserAgent := 'Mozilla/5.0';

      for i := 0 to vFileList.Count - 1 do
      begin
        LogLine := vFileList[i];
        if Pos('PLAYER', UpperCase(LogLine)) > 0 then Continue;
        if Trim(LogLine) = '' then Continue;

        if Length(LogLine) >= 8 then
        begin
          TimestampStr := Copy(LogLine, 1, 8);
          try
            LogEntryTime := StrToTime(TimestampStr);
            if LogStartTime = 0 then
              LogStartTime := LogEntryTime;
            TimeDiff := (LogEntryTime - LogStartTime) * 86400;
            if TimeDiff > 240 then Continue;
          except
          end;
        end;

        if IgnorarFiltroAtivo then
        begin
          LinhaLimpa := Trim(Copy(LogLine, 10, MaxInt));
          PosIndex := Pos('(', LinhaLimpa);
          if PosIndex > 0 then
            NomeVeiculo := Trim(Copy(LinhaLimpa, 1, PosIndex - 1))
          else
            NomeVeiculo := LinhaLimpa;

          for j := 0 to IgnorarLista.Count - 1 do
            if Pos(LowerCase(IgnorarLista[j]), LowerCase(NomeVeiculo)) > 0 then
              Continue;
        end;

        IDVeiculo := ExtrairIDVeiculo(LogLine);
        if IDVeiculo <> '' then
        begin
          j := DonosVeiculos.IndexOfName(IDVeiculo);
          if j <> -1 then
          begin
            Dono := DonosVeiculos.ValueFromIndex[j];
            LogLine := StringReplace(
              LogLine,
              '(ID: ' + IDVeiculo,
              '(ID: ' + IDVeiculo + ' - ' + Dono,
              []
            );
          end;
        end;

        PosIndex := Pos('pos <', LogLine);
        if PosIndex > 0 then
        begin
          EndIndex := Pos('>', LogLine);
          if EndIndex > PosIndex then
            LogLine := Copy(LogLine, 1, EndIndex + 1);
        end;

        JsonData := '{"content": "' + StringReplace(LogLine, '"', '\"', [rfReplaceAll]) + '"}';
        PostData := TStringStream.Create(UTF8Encode(JsonData));
        try
          IdHTTP.Post(WebhookURL, PostData);
        except
          Sleep(1000);
        end;
        PostData.Free;
        Sleep(1000);
      end;

      PostData := TStringStream.Create('{"content":"=> End"}');
      IdHTTP.Post(WebhookURL, PostData);
      PostData.Free;

      FinderCarServer2.Enabled := False;

    finally
      IdHTTP.Free;
      SSL.Free;
    end;
  finally
    vFileList.Free;
    IgnorarLista.Free;
    DonosVeiculos.Free;
    Reg.Free;
  end;
end;


//FINDER CAR LIVONIA
procedure TForm1.FinderCarServer3Timer(Sender: TObject);
var
  vFileList, IgnorarLista: TStringList;
  vFileStream: TFileStream;
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData, DirPath, LatestFile, LogLine, TimestampStr: string;
  SearchRec: TSearchRec;
  LatestTime, LogStartTime, LogEntryTime: TDateTime;
  PosIndex, EndIndex, i, j: Integer;
  TimeDiff: Double;
  Ini: TIniFile;
  SourceDir: string;
  ConfigFilePath: string;
  IgnorarFiltroAtivo: Boolean;
  NomeVeiculo, LinhaLimpa: string;
  Reg: TRegistry;
begin
  if FirstRun3 then
  begin
    FirstRun3 := False;
    FinderCarServer3.Interval := 300000; // 5 minutos
    Exit;
  end;
 

  ConfigFilePath := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(ConfigFilePath);
  try
    SourceDir := Ini.ReadString('Servidor 3', 'Profile', '');
    WebhookURL := Ini.ReadString('Servidor 3', 'carfinder', '');
  finally
    Ini.Free;
  end;

  EnviarServerConsoleLogS3;

  if (SourceDir = '') or (WebhookURL = '') then Exit;

  DirPath := IncludeTrailingPathDelimiter(SourceDir);

  LatestFile := '';
  LatestTime := 0;
  if FindFirst(DirPath + '*MCK*.*', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory) = 0 then
      begin
        if FileDateToDateTime(SearchRec.Time) > LatestTime then
        begin
          LatestTime := FileDateToDateTime(SearchRec.Time);
          LatestFile := SearchRec.Name;
        end;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;

  if LatestFile = '' then Exit;

  vFileList := TStringList.Create;
  IgnorarLista := TStringList.Create;
  Reg := TRegistry.Create;
  try
    // Carrega o log
    vFileStream := TFileStream.Create(DirPath + LatestFile, fmOpenRead or fmShareDenyNone);
    try
      vFileList.LoadFromStream(vFileStream);
    finally
      vFileStream.Free;
    end;

    // Verifica se o filtro está ativado no registro
    IgnorarFiltroAtivo := False;
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly('\SOFTWARE\HFManager\Config') then
    begin
      if Reg.ValueExists('Not_CarFinderS3') then
        IgnorarFiltroAtivo := Reg.ReadInteger('Not_CarFinderS3') = 1;
      Reg.CloseKey;
    end;

    if IgnorarFiltroAtivo then
    begin
      try
        IgnorarLista.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Config\not_carfinder.txt');
      except
        IgnorarFiltroAtivo := False;
      end;
    end;

    LogStartTime := 0;

    IdHTTP := TIdHTTP.Create(nil);
    SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      SSL.SSLOptions.Method := sslvTLSv1_2;
      IdHTTP.IOHandler := SSL;
      IdHTTP.Request.ContentType := 'application/json';
      IdHTTP.Request.Accept := 'application/json';
      IdHTTP.Request.UserAgent := 'Mozilla/5.0';

      for i := 0 to vFileList.Count - 1 do
      begin
        LogLine := vFileList.Strings[i];
        if Pos('PLAYER', UpperCase(LogLine)) > 0 then Continue;
        if Trim(LogLine) = '' then Continue;

        // Tenta extrair timestamp da linha
        if Length(LogLine) >= 8 then
        begin
          TimestampStr := Copy(LogLine, 1, 8);
          try
            LogEntryTime := StrToTime(TimestampStr);
            if LogStartTime = 0 then
              LogStartTime := LogEntryTime;

            TimeDiff := (LogEntryTime - LogStartTime) * 86400;
            if TimeDiff > 240 then Continue; // 4 minutos
          except
            // ignorar erro de conversão
          end;
        end;

        // Aplica filtro de veículos ignorados
        if IgnorarFiltroAtivo then
begin
  LinhaLimpa := Trim(Copy(LogLine, 10, MaxInt)); // remove timestamp inicial
  PosIndex := Pos('(', LinhaLimpa);
  if PosIndex > 0 then
    NomeVeiculo := Trim(Copy(LinhaLimpa, 1, PosIndex - 1))
  else
    NomeVeiculo := LinhaLimpa;

  for j := 0 to IgnorarLista.Count - 1 do
  begin
    if Pos(LowerCase(Trim(IgnorarLista[j])), LowerCase(NomeVeiculo)) > 0 then
    begin
      LogLine := ''; // ignorar
      Break;
    end;
  end;
  if LogLine = '' then Continue;
end;

        // Ajusta posição se tiver pos <>
        PosIndex := Pos('pos <', LogLine);
        if PosIndex > 0 then
        begin
          EndIndex := Pos('>', LogLine);
          if EndIndex > PosIndex then
            LogLine := Copy(LogLine, 1, EndIndex + 1);
        end;

        JsonData := '{"content": "' + StringReplace(LogLine, '"', '\"', [rfReplaceAll]) + '"}';
        PostData := TStringStream.Create(UTF8Encode(JsonData));
        try
          IdHTTP.Post(WebhookURL, PostData);
        except
          on E: Exception do Sleep(1000);
        end;
        PostData.Free;
        Sleep(1000);
      end;

      // Mensagem final
      JsonData := '{"content": "\n=> End"}';
      PostData := TStringStream.Create(UTF8Encode(JsonData));
      try
        IdHTTP.Post(WebhookURL, PostData);
        Form1.FinderCarServer3.Enabled := False;

        
      except
        on E: Exception do Sleep(1000);
      end;
      PostData.Free;

    finally
      IdHTTP.Free;
      SSL.Free;
    end;
  finally
    vFileList.Free;
    IgnorarLista.Free;
    Reg.Free;
  end;
end;

// ENCERRA TODOS OS SERVIDORES AUTOMATICAMENTE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
function GetIniFilePath: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'Config\Config.ini';
end;

function ReadIniValue(const Section, Key: string): string;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(GetIniFilePath);
  try
    Result := Ini.ReadString(Section, Key, '');
    if Result = '' then
    exit;
      //ShowMessage(Format('Erro: Chave "%s" na seção "%s" não encontrada ou vazia.', [Key, Section]));
  finally
    Ini.Free;
  end;
end;

function IsServerRunning(const ExePath: string): Boolean;
var
  Snapshot: THandle;
  Process: TProcessEntry32;
begin
  Result := False;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if Snapshot <> INVALID_HANDLE_VALUE then
  begin
    Process.dwSize := SizeOf(Process);
    if Process32First(Snapshot, Process) then
    begin
      repeat
        // Verifica se o nome do processo corresponde ao nome do executável
        if CompareText(Process.szExeFile, ExtractFileName(ExePath)) = 0 then
        begin
          Result := True;
          Break;
        end;
      until not Process32Next(Snapshot, Process);
    end;
    CloseHandle(Snapshot);
  end;
end;

//Funcao que encerra todos os servidores de uma vez
procedure EncerraServidor;
var
  PathBanov, PathCherno, PathLivonia: string;
  ExeBanov, ExeCherno, ExeLivonia: string;
begin
  PathBanov := ReadIniValue('Servidor 1', 'Shutdown');
  PathCherno := ReadIniValue('Servidor 2', 'Shutdown');
  PathLivonia := ReadIniValue('Servidor 3', 'Shutdown');

  // Extrai apenas o nome do executável
  ExeBanov := ExtractFileName(ReadIniValue('Servidor 1', 'exe'));
  ExeCherno := ExtractFileName(ReadIniValue('Servidor 2', 'exe'));
  ExeLivonia := ExtractFileName(ReadIniValue('Servidor 3', 'exe'));

  // Atualiza labels para verificar a leitura correta
//  Form1.lblExeBanov.Caption := 'Banov: ' + ExeBanov;
//  Form1.lblExeCherno.Caption := 'Chernarus: ' + ExeCherno;
//  Form1.lblExeLivonia.Caption := 'Livonia: ' + ExeLivonia;

  // Banov
  if (PathBanov <> '') and IsServerRunning(ExeBanov) then
  begin
    if ShellExecute(0, 'open', PChar(PathBanov), nil, nil, SW_SHOWNORMAL) > 32 then
      Sleep(2000);
  end;

  // Chernarus
  if (PathCherno <> '') and IsServerRunning(ExeCherno) then
  begin
    if ShellExecute(0, 'open', PChar(PathCherno), nil, nil, SW_SHOWNORMAL) > 32 then
      Sleep(2000);
  end;

  // Livonia
  if (PathLivonia <> '') and IsServerRunning(ExeLivonia) then
  begin
    if ShellExecute(0, 'open', PChar(PathLivonia), nil, nil, SW_SHOWNORMAL) <= 32 then;
  end;
end;

//Procedimento para encerrar somente o servidor que o mod consta na lista do bat
procedure EncerraServidor1(IndiceServidor: Integer);
var
  Path, Exe: string;
  Secao: string;
begin
  case IndiceServidor of
    0: Secao := 'Servidor 1';
    1: Secao := 'Servidor 2';
    2: Secao := 'Servidor 3';
  else
    Exit; // índice inválido
  end;

  Path := ReadIniValue(Secao, 'Shutdown');
  Exe := ExtractFileName(ReadIniValue(Secao, 'exe'));

  if (Path <> '') and IsServerRunning(Exe) then
  begin
    if ShellExecute(0, 'open', PChar(Path), nil, nil, SW_SHOWNORMAL) > 32 then
      Sleep(2000);
  end;
end;
//---END

//ENCERRA SERVIDOR PELO BOTAO NO FORM PRINCIPALxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
procedure shutdowbanov;
var
  PathBanov: string;
begin
  PathBanov := ReadIniValue('Servidor 1', 'Shutdown');
  // Banov
  //if (PathBanov <> '') and (ShellExecute(0, 'open', PChar(PathBanov), nil, nil, SW_SHOWNORMAL) <= 32) then
  //ShowMessage('Falha ao encerrar Banov');

  // Verifica se o caminho não está vazio e tenta executar com o diretório de trabalho correto
  if (PathBanov <> '') and
     (ShellExecute(0, 'open', PChar(PathBanov), nil, PChar(ExtractFilePath(PathBanov)), SW_SHOWNORMAL) <= 32) then
  begin
    // Pode exibir um log ou ativar algo se necessário
    // ShowMessage('Falha ao encerrar Banov');
  end;
end;

procedure shutdowcherno;
var
  PathCherno: string;
begin
  PathCherno := ReadIniValue('Servidor 2', 'Shutdown');
  // Chernarus
  //if (PathCherno <> '') and (ShellExecute(0, 'open', PChar(PathCherno), nil, nil, SW_SHOWNORMAL) <= 32) then
  //ShowMessage('Falha ao encerrar Chernarus');
  // Chernarus
  if (PathCherno <> '') and
     (ShellExecute(0, 'open', PChar(PathCherno), nil, PChar(ExtractFilePath(PathCherno)), SW_SHOWNORMAL) <= 32) then
  begin
    // Pode exibir uma mensagem, log ou tomar alguma ação em caso de erro
    // ShowMessage('Falha ao encerrar Chernarus');
  end;
end;

procedure shutdowlivonia;
var
  PathLivonia: string;
begin
  PathLivonia := ReadIniValue('Servidor 3', 'Shutdown');

  //if (PathLivonia <> '') and (ShellExecute(0, 'open', PChar(PathLivonia), nil, nil, SW_SHOWNORMAL) <= 32) then
  //ShowMessage('Falha ao encerrar Livonia');
  if (PathLivonia <> '') and
     (ShellExecute(0, 'open', PChar(PathLivonia), nil, PChar(ExtractFilePath(PathLivonia)), SW_SHOWNORMAL) <= 32) then
  begin
    // Pode adicionar log ou mensagem de erro aqui, se quiser
    // ShowMessage('Falha ao encerrar Livonia');
  end;
end;



// START GOOGLE DRIVE
procedure IniciarGoogleDrive;
var
  PathDrive: string;
begin
  PathDrive := ReadIniValue('ParadaBackup', 'GDCaminho');
  // Banov
  if (PathDrive <> '') and (ShellExecute(0, 'open', PChar(PathDrive), nil, nil, SW_SHOWNORMAL) <= 32) then
    //ShowMessage('Falha ao iniciar Google Drive');
end;

// SHUTDOWN GOOGLE DRIVE
procedure EncerraGoogleDrive(ExeName: string);
var
  hSnapShot: THandle;
  pe: TProcessEntry32;
  hProcess: THandle;
begin
  hSnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapShot = INVALID_HANDLE_VALUE then Exit;

  pe.dwSize := SizeOf(pe);
  if Process32First(hSnapShot, pe) then
  begin
    repeat
      // Verifica se o nome do processo corresponde ao ExeName
      if AnsiCompareText(pe.szExeFile, ExeName) = 0 then
      begin
        // Obtém o handle do processo
        hProcess := OpenProcess(PROCESS_TERMINATE, False, pe.th32ProcessID);
        if hProcess <> 0 then
        begin
          // Encerra o processo
          TerminateProcess(hProcess, 0);
          CloseHandle(hProcess);
          // ShowMessage(ExeName + ' foi encerrado com sucesso.');
        end
        else
          // ShowMessage('Falha ao encerrar o processo ' + ExeName);
        Break;
      end;
    until not Process32Next(hSnapShot, pe);
  end;

  CloseHandle(hSnapShot);
end;

// START NOVAMENTE SERVIDOR
procedure StartServidor;
var
  PathBanov, PathCherno, PathLivonia: string;
begin
  PathBanov := ReadIniValue('Servidor 1', 'Start');
  PathCherno := ReadIniValue('Servidor 2', 'Start');
  PathLivonia := ReadIniValue('Servidor 3', 'Start');

  // Banov
  if (PathBanov <> '') and (ShellExecute(0, 'open', PChar(PathBanov), nil, nil, SW_SHOWNORMAL) <= 32) then
      //FindCarLog Banov discord
      //Form1.FinderCarServer1.Enabled := true;
      Sleep(10000); // Aguarda 10 segundos antes de prosseguir
    //ShowMessage('Falha ao iniciar Banov');

  // Chernarus
  if (PathCherno <> '') and (ShellExecute(0, 'open', PChar(PathCherno), nil, nil, SW_SHOWNORMAL) <= 32) then
      //Form1.FinderCarServer2.Enabled := true;
      Sleep(10000); // Aguarda 10 segundos antes de prosseguir
    //ShowMessage('Falha ao iniciar Chernarus');

  // Livonia
  if (PathLivonia <> '') and (ShellExecute(0, 'open', PChar(PathLivonia), nil, nil, SW_SHOWNORMAL) <= 32) then
      //Form1.FinderCarServer3.Enabled := true;
    //ShowMessage('Falha ao iniciar Livonia');

  //verifica ip
  VerificarIPModem;
end;

//MOVE OS LOG DE PROFILE PARA PASTA PADRAO
//Banov
function GerarNomeUnico(DestFile: string): string;
var
  BaseName, Ext: string;
  Count: Integer;
begin
  BaseName := ChangeFileExt(DestFile, '');
  Ext := ExtractFileExt(DestFile);
  Count := 1;
  Result := DestFile;

  while FileExists(Result) do
  begin
    Result := Format('%s_%d%s', [BaseName, Count, Ext]);
    Inc(Count);
  end;
end;

procedure MoveLogFilesBanov;
const
  Extensions: array[0..3] of string = ('.log', '.RPT', '.ADM', '.mdmp');
var
  SourceDir, DestBaseDir, DestDir, SourceFile, DestFile: string;
  SearchRec: TSearchRec;
  I: Integer;
begin
  SourceDir := ReadIniValue('Servidor 1', 'Profile');
  DestBaseDir := ReadIniValue('Servidor 1', 'Log');

  if (SourceDir = '') or (DestBaseDir = '') then Exit;

  if SourceDir[Length(SourceDir)] <> '\' then
    SourceDir := SourceDir + '\';
  if DestBaseDir[Length(DestBaseDir)] <> '\' then
    DestBaseDir := DestBaseDir + '\';

  DestDir := DestBaseDir + FormatDateTime('yyyy-mm-dd', Date);
  if not DirectoryExists(DestDir) then
    if not CreateDir(DestDir) then Exit;

  for I := 0 to High(Extensions) do
  begin
    if FindFirst(SourceDir + '*' + Extensions[I], faAnyFile, SearchRec) = 0 then
    begin
      repeat
        if (SearchRec.Attr and faDirectory) = 0 then
        begin
          SourceFile := SourceDir + SearchRec.Name;
          DestFile := DestDir + '\' + SearchRec.Name;

          // Garante nome único no destino
          DestFile := GerarNomeUnico(DestFile);

          // Copia e depois remove o original
          if CopyFile(PChar(SourceFile), PChar(DestFile), True) then
            DeleteFile(SourceFile)
          else
            OutputDebugString(PChar('Erro ao mover ' + SourceFile));
        end;
      until FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
    end;
  end;
end;


//Cherno
procedure MoveLogFilesCherno;
const
  Extensions: array[0..3] of string = ('.log', '.RPT', '.ADM', '.mdmp');
var
  SourceDir, DestBaseDir, DestDir, SourceFile, DestFile: string;
  SearchRec: TSearchRec;
  I: Integer;
begin
  SourceDir := ReadIniValue('Servidor 2', 'Profile');
  DestBaseDir := ReadIniValue('Servidor 2', 'Log');

  if (SourceDir = '') or (DestBaseDir = '') then Exit;

  if SourceDir[Length(SourceDir)] <> '\' then
    SourceDir := SourceDir + '\';
  if DestBaseDir[Length(DestBaseDir)] <> '\' then
    DestBaseDir := DestBaseDir + '\';

  DestDir := DestBaseDir + FormatDateTime('yyyy-mm-dd', Date);
  if not DirectoryExists(DestDir) then
    if not CreateDir(DestDir) then Exit;

  for I := 0 to High(Extensions) do
  begin
    if FindFirst(SourceDir + '*' + Extensions[I], faAnyFile, SearchRec) = 0 then
    begin
      repeat
        if (SearchRec.Attr and faDirectory) = 0 then
        begin
          SourceFile := SourceDir + SearchRec.Name;
          DestFile := DestDir + '\' + SearchRec.Name;

          // Garante nome único no destino
          DestFile := GerarNomeUnico(DestFile);

          // Copia e depois remove o original
          if CopyFile(PChar(SourceFile), PChar(DestFile), True) then
            DeleteFile(SourceFile)
          else
            OutputDebugString(PChar('Erro ao mover ' + SourceFile));
        end;
      until FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
    end;
  end;
end;

//Livonia
procedure MoveLogFilesLivonia;
const
  Extensions: array[0..3] of string = ('.log', '.RPT', '.ADM', '.mdmp');
var
  SourceDir, DestBaseDir, DestDir, SourceFile, DestFile: string;
  SearchRec: TSearchRec;
  I: Integer;
begin
  SourceDir := ReadIniValue('Servidor 3', 'Profile');
  DestBaseDir := ReadIniValue('Servidor 3', 'Log');

  if (SourceDir = '') or (DestBaseDir = '') then Exit;

  if SourceDir[Length(SourceDir)] <> '\' then
    SourceDir := SourceDir + '\';
  if DestBaseDir[Length(DestBaseDir)] <> '\' then
    DestBaseDir := DestBaseDir + '\';

  DestDir := DestBaseDir + FormatDateTime('yyyy-mm-dd', Date);
  if not DirectoryExists(DestDir) then
    if not CreateDir(DestDir) then Exit;

  for I := 0 to High(Extensions) do
  begin
    if FindFirst(SourceDir + '*' + Extensions[I], faAnyFile, SearchRec) = 0 then
    begin
      repeat
        if (SearchRec.Attr and faDirectory) = 0 then
        begin
          SourceFile := SourceDir + SearchRec.Name;
          DestFile := DestDir + '\' + SearchRec.Name;

          // Garante nome único no destino
          DestFile := GerarNomeUnico(DestFile);

          // Copia e depois remove o original
          if CopyFile(PChar(SourceFile), PChar(DestFile), True) then
            DeleteFile(SourceFile)
          else
            OutputDebugString(PChar('Erro ao mover ' + SourceFile));
        end;
      until FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
    end;
  end;
end;

//MONITORAMENTO PARA VERIFICAR SE ESTA RODANDO
function IsProcessRunning(const ExePath: string): Boolean;
var
  Snapshot: THandle;
  Process: TProcessEntry32;
begin
  Result := False;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

  if Snapshot <> INVALID_HANDLE_VALUE then
  begin
    Process.dwSize := SizeOf(Process);
    if Process32First(Snapshot, Process) then
    begin
      repeat
        // Verifica se o nome do processo corresponde ao nome do executável
        if CompareText(Process.szExeFile, ExtractFileName(ExePath)) = 0 then
        begin
          Result := True;
          Break;
        end;
      until not Process32Next(Snapshot, Process);
    end;
    CloseHandle(Snapshot);
  end;
end;

// Função para verificar atividade dentro do horário especificado
function IsWithinAllowedTime: Boolean;
var
  CurrentTime, StartTime, EndTime: TTime;
  StartStr, EndStr: string;
  TempDateTime: TDateTime;
begin
  CurrentTime := Time;

  // Lendo os horários do arquivo INI
  StartStr := ReadIniValue('ParadaBackup', 'das'); // Início da parada (03:00)
  EndStr := ReadIniValue('ParadaBackup', 'ate');   // Fim da parada (04:00)

  // Convertendo strings para horário
  if not TryStrToTime(StartStr, TempDateTime) then
  begin
    Result := True; // Se falhar ao converter, assume que pode rodar
    Exit;
  end;
  StartTime := TimeOf(TempDateTime);

  if not TryStrToTime(EndStr, TempDateTime) then
  begin
    Result := True; // Se falhar ao converter, assume que pode rodar
    Exit;
  end;
  EndTime := TimeOf(TempDateTime);

  // Ajustando os horários de parada (com margem de segurança)
  StartTime := IncMinute(StartTime, -5); // -5 Ajusta para 02:55
  EndTime := IncMinute(EndTime, 5); // 5 Ajusta para 04:05

  // O monitoramento deve rodar **fora do intervalo de parada**
  if StartTime < EndTime then
    Result := not ((CurrentTime >= StartTime) and (CurrentTime <= EndTime)) // Intervalo normal
  else
    Result := not ((CurrentTime >= StartTime) or (CurrentTime <= EndTime)); // Intervalo cruza meia-noite
end;

//Procedimento para verificar e iniciar o servidor BANOV caso tenha caido
procedure CheckAndRestartServerBanov;
var
  ServerExe, StartBat, startBatBEC, ExePath: string;
begin
  // Lendo os caminhos do INI
  StartBat := ReadIniValue('Servidor 1', 'Start');      // Caminho completo para start.bat
  ExePath := ReadIniValue('Servidor 1', 'exe');         // Caminho completo do executável
  startBatBEC := ReadIniValue('Servidor 1', 'BEC');     // Caminho completo do BEC para startbec.bat

  // Verifica se os caminhos essenciais do servidor foram carregados corretamente
  if (ExePath = '') or (StartBat = '') then
    Exit;

  // Verifica se o servidor está dentro do horário permitido e não está em execução
  if IsWithinAllowedTime then
  begin
    if not IsProcessRunning(ExePath) then
    begin
      try
        CopiarCfgParaDestinos1;
        CriarServerConsoleS1;
        MoveLogFilesBanov;
      except
        // Ignora erros ao mover arquivos
      end;

      // Inicia o servidor
      if not IsProcessRunning(ExePath) then
       ShellExecute(0, 'open', PChar(StartBat), nil, nil, SW_SHOWNORMAL);

      // Ativa monitoramento e tarefas
      Form1.FinderCarServer1.Enabled := true;
      VerificarIPModem;
      EnviarCrashlogS1;
    end;


      // Inicia o BEC apenas se o caminho estiver definido e não estiver rodando
      if (startBatBEC <> '') and (not IsProcessRunning('BecS1.exe')) then
        ShellExecute(0, 'open', PChar(startBatBEC), nil, nil, SW_SHOWNORMAL);
  end;
end;


//Procedimento para verificar e iniciar o servidor CHERNARUS caso tenha caido
procedure CheckAndRestartServerCherno;
var
  ServerExe, StartBat, startBatBEC, ExePath: string;
begin
  // Lendo os caminhos do INI
  StartBat := ReadIniValue('Servidor 2', 'Start');
  ExePath := ReadIniValue('Servidor 2', 'exe');
  startBatBEC := ReadIniValue('Servidor 2', 'BEC');

  // Se faltar informações essenciais do servidor, aborta
  if (ExePath = '') or (StartBat = '') then
    Exit;

  if IsWithinAllowedTime then
  begin
    if not IsProcessRunning(ExePath) then
    begin
      try
        CopiarCfgParaDestinos2;
        CriarServerConsoleS2;
        GerarArquivoProprietariosVeiculosS2;
        RemoverVeiculosDestruidosS2;
        MoveLogFilesCherno;
      except
        // Ignora erros
      end;

      // Inicia o servidor
      if not IsProcessRunning(ExePath) then
        ShellExecute(0, 'open', PChar(StartBat), nil, nil, SW_SHOWNORMAL);

      Form1.FinderCarServer2.Enabled := true;
      VerificarIPModem;
      EnviarCrashlogS2;
    end;

      // Inicia o BEC apenas se o caminho estiver definido
      if (startBatBEC <> '') and (not IsProcessRunning('BecS2.exe')) then
        ShellExecute(0, 'open', PChar(startBatBEC), nil, nil, SW_SHOWNORMAL);
  end;
end;

//Procedimento para verificar e iniciar o servidor LIVONIA caso tenha caido
procedure CheckAndRestartServerLivonia;
var
  ServerExe, StartBat, startBatBEC, ExePath: string;
begin
  // Lendo os caminhos do INI
  StartBat := ReadIniValue('Servidor 3', 'Start');      // Caminho completo para start.bat
  ExePath := ReadIniValue('Servidor 3', 'exe');         // Caminho completo do executável
  startBatBEC := ReadIniValue('Servidor 3', 'BEC');     // Caminho completo para o .bat do BEC

  // Verifica se os caminhos essenciais do servidor foram carregados corretamente
  if (ExePath = '') or (StartBat = '') then
    Exit;

  // Verifica se está dentro do horário permitido e o servidor ainda não está em execução
  if IsWithinAllowedTime then
  begin
    if not IsProcessRunning(ExePath) then
    begin
      try
        CopiarCfgParaDestinos3;
        CriarServerConsoleS3;
        MoveLogFilesLivonia;
      except
        // Ignora erros ao mover arquivos
      end;

      // Inicia o servidor
      if not IsProcessRunning(ExePath) then
        ShellExecute(0, 'open', PChar(StartBat), nil, nil, SW_SHOWNORMAL);

      // Ativa monitoramento e tarefas adicionais
      Form1.FinderCarServer3.Enabled := true;
      VerificarIPModem;
      EnviarCrashlogS3;
    end;


      // Inicia o BEC apenas se o caminho estiver definido e ele ainda não estiver rodando
      if (startBatBEC <> '') and (not IsProcessRunning('BecS3.exe')) then
        ShellExecute(0, 'open', PChar(startBatBEC), nil, nil, SW_SHOWNORMAL);
  end;
end;

//END

//ATIVA NOVAMENTE O SISTEMA PARA AREA DE TRABALHO
procedure TForm1.WndProc(var Msg: TMessage);
begin
  if Msg.Msg = WM_TRAYICON then
  begin
    case Msg.LParam of
      WM_LBUTTONUP:  // Clique simples com o botão esquerdo
      begin
        // Restaurar ou mostrar a janela
        if IsIconic(Application.Handle) then
          Application.Restore;
        Self.Show;
        Self.BringToFront;
      end;
    end;
  end
  else
    inherited WndProc(Msg); // chama o processamento padrão
end;

//MINIMIZA PARA RODAR EM SEGUNDO PLANO
procedure TForm1.ShowTrayIcon;
begin
  FillChar(TrayIconData, SizeOf(TrayIconData), 0);
  TrayIconData.cbSize := SizeOf(TrayIconData);
  TrayIconData.Wnd := Handle;
  TrayIconData.uID := 1;
  TrayIconData.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
  TrayIconData.uCallbackMessage := WM_TRAYICON;
  TrayIconData.hIcon := Application.Icon.Handle;
  StrLCopy(TrayIconData.szTip, PChar('HF Manager'), Length(TrayIconData.szTip));
  Shell_NotifyIcon(NIM_ADD, @TrayIconData);
end;

procedure TForm1.RemoveTrayIcon;
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

//Função necessária para verificar se steamcmd esta rodando e não execute novamente
function IsUmdBatRunning: Boolean;
var
  WMIService, WMIObjectSet, WMIObject, SWbemLocator: OleVariant;
  Enum: IEnumvariant;
  Value: Cardinal;
  CommandLine: string;
begin
  Result := False;

  CoInitialize(nil);
  try
    SWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
    WMIService := SWbemLocator.ConnectServer('.', 'root\CIMV2');

    WMIObjectSet := WMIService.ExecQuery('SELECT CommandLine FROM Win32_Process WHERE Name="cmd.exe"');

    Enum := IUnknown(WMIObjectSet._NewEnum) as IEnumVariant;

    while Enum.Next(1, WMIObject, Value) = 0 do
    begin
      CommandLine := LowerCase(WMIObject.CommandLine);
      if Pos('umd.bat', CommandLine) > 0 then
      begin
        Result := True;
        Break;
      end;
    end;
  finally
    CoUninitialize;
  end;
end;

//verifica se ja tem um terminal steamcmd aberto
function ProcessoEmExecucao(const NomeProcesso: string): Boolean;
var
  SnapShot: THandle;
  ProcEntry: TProcessEntry32;
begin
  Result := False;
  SnapShot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if SnapShot = INVALID_HANDLE_VALUE then
    Exit;

  ProcEntry.dwSize := SizeOf(TProcessEntry32);
  if Process32First(SnapShot, ProcEntry) then
  begin
    repeat
      if SameText(ExtractFileName(ProcEntry.szExeFile), NomeProcesso) then
      begin
        Result := True;
        Break;
      end;
    until not Process32Next(SnapShot, ProcEntry);
  end;
  CloseHandle(SnapShot);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Reg: TRegistry;
  //Localiza caminho do google drive
  CaminhoExe: string;
  INI: TIniFile;

  //funcao do ttimer
  IniPath : string;
  IntervaloMonDayz: integer;
  IntervaloMonMod: integer;

begin
  TimerMonitor.Interval := 600000; // 10 minutos
  TimerMonitor.Enabled := True;

  // COMANDO PARA ALTERAR O "INTERVAL" DO TIMER DE ACORDO COM O CONFIGURADO NO .INI
  IniPath := ExtractFilePath(Application.ExeName) + 'Config\parametros.ini';
  Ini := TIniFile.Create(IniPath);
  try
   IntervaloMonDayz := Ini.ReadInteger('PARTIMEDAYZ', 'intervalodayz', 1800000); // valor padrão se não existir 30minutos
   IntervaloMonMod := Ini.ReadInteger('PARTIMEMOD', 'intervalomod', 1800000); // valor padrão se não existir 30minutos
   MonDayz.Interval := IntervaloMonDayz;
   MonMod.Interval := IntervaloMonMod;
  finally
   Ini.Free;
  end;
  // nota: Esse procedimento tambem existe no OnClose do form16. Se alterar algum valor aqui, deve-se alterar lá!


  //localiza e atualiza caminho do google drive no ini
  CaminhoExe := LocalizarGoogleDriveExe('C:\Program Files\Google\Drive File Stream');
  if CaminhoExe <> '' then
  begin
    INI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\config.ini');
    try
      INI.WriteString('ParadaBackup', 'GDcaminho', CaminhoExe);
    finally
      INI.Free;
    end;
  end;
  //end

  ShowTrayIcon; // Exibe o ícone na bandeja ao iniciar
  CarregarNomesServidores;
  BitBtn1.Caption := Servidor11.Caption;
  BitBtn2.Caption := Servidor21.Caption;
  BitBtn3.Caption := Servidor31.Caption;

  //checkbox2
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly(REG_KEY) then
    begin
      CheckBox2.Checked := Reg.ValueExists(APP_NAME);
    end;
  finally
    Reg.Free;
  end;

  //checkbox3 monitora att
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', False) then
    begin
      if Reg.ValueExists('Monatt') then
        CheckBox3.Checked := Reg.ReadBool('MonAtt');
    end;
  finally
    Reg.Free;
  end;

  // verifica se chebox3 esta ativado/desativado e executa acao
  if CheckBox3.Checked then
  begin
    MonMod.Enabled := True;
    MonDayz.Enabled := True;
    //showmessage('ativado');
  end
  else
  begin
    MonMod.Enabled := False;
    MonDayz.Enabled := False;
    //showmessage('inativado');    
  end;

   // checkbox4 monitora att steamcmd
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', False) then
    begin
      if Reg.ValueExists('Monsteamcmd') then
      begin
        CheckBox4.Checked := Reg.ReadBool('Monsteamcmd');

        if CheckBox4.Checked then
        begin
          // Verifica se já está rodando a thread OU o processo steamcmd.exe
          if not EmExecucao and not ProcessoEmExecucao('steamcmd.exe') then
          begin
            EmExecucao := True;
            TTask.Run(
              procedure
              begin
                try
                  MonitorarMods;
                finally
                  TThread.Queue(nil,
                    procedure
                    begin
                      EmExecucao := False;
                    end);
                end;
              end);
          end
          else
          begin
            // Opcional: Log ou alerta se necessário
            // ShowMessage('Monitoramento do SteamCMD já está em execução.');
          end;
        end;
      end;
    end;
  finally
    Reg.Free;
  end;

end;

//Busca versao do executavel para informar no caption do form
function GetFileVersion(const FileName: string): string;
var
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  VerSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  Result := '';
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize > 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
      begin
        if VerQueryValue(VerBuf, '\', Pointer(VerValue), VerSize) then
        begin
          Result := Format('%d.%d.%d.%d', [
            HiWord(VerValue^.dwFileVersionMS),
            LoWord(VerValue^.dwFileVersionMS),
            HiWord(VerValue^.dwFileVersionLS),
            LoWord(VerValue^.dwFileVersionLS)
          ]);
        end;
      end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  FilePath, Line, ExeVersion: string;
  FileLines: TStringList;
  i: Integer;
  FoundVersion: Boolean;
begin
  //FoundVersion := False;
  //FilePath := ExtractFilePath(Application.ExeName) + 'tmp\hfmanager.inf';
  //FileLines := TStringList.Create;
  //try
    //if FileExists(FilePath) then
    //begin
      //FileLines.LoadFromFile(FilePath);
      //for i := 0 to FileLines.Count - 1 do
      //begin
        //Line := Trim(FileLines[i]);
        //if Pos('Version=', Line) = 1 then
        //begin
          //Caption := 'HF Manager v' + Copy(Line, Length('Version=') + 1, MaxInt);
          //FoundVersion := True;
          //Break;
        //end;
      //end;
    //end;
  //finally
    //FileLines.Free;
  //end;

  // Se não encontrou a versão no arquivo, pega do executável
  //if not FoundVersion then
  begin
    ExeVersion := GetFileVersion(Application.ExeName);
    if ExeVersion <> '' then
      Caption := 'HF Manager v' + ExeVersion
    else
      Caption := 'HF Manager - Versão desconhecida';
  end;

  //verifica atualizacao do sistema
  //EvAppUpdate1.Execute;

end;

//METODO PARA GERENCIAR MOD - VERIFICA SE DLL EXISTE
//verifica e baixa dll MIDAS
procedure VerificarEBaixarDLLs1;
const
  BaseURL = 'https://github.com/hfsoftwaree/hfmanagerupdate/releases/download/installer/';
//  Arquivos: array[0..1] of string = ('midas.dll', 'WebView2Loader.dll');
  Arquivos: array[0..0] of string = ('midas.dll');
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  NomeArquivo, URL, Destino, LogDir, LogPath: string;
  I: Integer;
  MemStream: TMemoryStream;
begin
  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;

    // Define pasta de log: .\Log
    LogDir := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Log');
    if not DirectoryExists(LogDir) then
      ForceDirectories(LogDir);
    LogPath := TPath.Combine(LogDir, 'erros_download_AppUpdate.log');

    for I := Low(Arquivos) to High(Arquivos) do
    begin
      NomeArquivo := Arquivos[I];
      Destino := TPath.Combine(ExtractFilePath(ParamStr(0)), NomeArquivo);

      if not FileExists(Destino) then
      begin
        URL := BaseURL + NomeArquivo;
        try
          MemStream := TMemoryStream.Create;
          try
            HTTP.Get(URL, MemStream);
            MemStream.SaveToFile(Destino);
          finally
            MemStream.Free;
          end;
        except
          on E: Exception do
          begin
            // Salva o erro no log da pasta \Log
            TFile.AppendAllText(LogPath,
              Format('[%s] Falha ao baixar %s: %s' + sLineBreak,
                [DateTimeToStr(Now), NomeArquivo, E.Message]));
          end;
        end;
      end;
    end;
  finally
    HTTP.Free;
    SSL.Free;
  end;
end;

procedure TForm1.IniciarVerificacaoDLL1;
var
  DllPath: string;
  Timer: TTimer;
begin
  DllPath := ExtractFilePath(Application.ExeName) + 'midas.dll';

  if not FileExists(DllPath) then
  begin
    ShowMessage('Alguns ajustes são necessários. No término do processo o sistema proceguira automaticamente, por favor aguarde!');
    VerificarEBaixarDLLs1;

    // Cria o timer que vai aguardar sem travar
    Timer := TTimer.Create(Self);
    Timer.Interval := 3000; // 3 segundos
    Timer.OnTimer := ContinuarAposDownload1;
    Timer.Enabled := True;
  end
  else
  begin
    AbrirFormWebSteam1;
  end;
end;

procedure TForm1.ContinuarAposDownload1(Sender: TObject);
var
  DllPath: string;
begin
  // Desativa e destrói o timer
  TTimer(Sender).Enabled := False;
  TTimer(Sender).Free;

  DllPath := ExtractFilePath(Application.ExeName) + 'midas.dll';

  if FileExists(DllPath) then
    AbrirFormWebSteam1
  else
    ShowMessage('Falha ao baixar a DLL. Tente novamente ou contate o suporte.');
end;

procedure TForm1.AbrirFormWebSteam1;
begin
  try
    Application.CreateForm(Tfrmgerenciarmod, frmgerenciarmod);
    frmgerenciarmod.ShowModal;
  finally
    frmgerenciarmod.Free;
  end;
end;

procedure TForm1.GerenciarMODbaixado1Click(Sender: TObject);
begin
 //try
    //Application.CreateForm(Tfrmgerenciarmod, frmgerenciarmod);
    //frmgerenciarmod.ShowModal;
  //finally
    //frmgerenciarmod.Free;
  //end;
  IniciarVerificacaoDLL1;
end;

//verifica e baixa STEAMCMD
procedure VerificarEBaixarSteamcmd;
const
  BaseURL = 'https://github.com/hfsoftwaree/hfmanagerupdate/releases/download/installer/';
  NomeArquivo = 'steamcmd.exe';
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  URL, Destino, PastaSteamCMD, LogDir, LogPath: string;
  MemStream: TMemoryStream;
begin
  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;

    PastaSteamCMD := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Steamcmd');
    if not DirectoryExists(PastaSteamCMD) then
      ForceDirectories(PastaSteamCMD);

    Destino := TPath.Combine(PastaSteamCMD, NomeArquivo);

    // Pasta de log
    LogDir := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Log');
    if not DirectoryExists(LogDir) then
      ForceDirectories(LogDir);
    LogPath := TPath.Combine(LogDir, 'erros_download_AppUpdate.log');

    if not FileExists(Destino) then
    begin
      URL := BaseURL + NomeArquivo;
      try
        MemStream := TMemoryStream.Create;
        try
          HTTP.Get(URL, MemStream);
          MemStream.SaveToFile(Destino);
        finally
          MemStream.Free;
        end;
      except
        on E: Exception do
        begin
          // Salva erro no log
          TFile.AppendAllText(LogPath,
            Format('[%s] Falha ao baixar %s: %s' + sLineBreak,
              [DateTimeToStr(Now), NomeArquivo, E.Message]));
        end;
      end;
    end;
  finally
    HTTP.Free;
    SSL.Free;
  end;
end;

procedure TForm1.Instalarsteamcmd1Click(Sender: TObject);
var
  SteamCMDPath, SteamLogin, SteamSenha: string;
  Ini: TIniFile;
  SteamLoginEnc, SteamSenhaEnc: string;
  Resposta: Integer;
  SEInfo: TShellExecuteInfo;
begin
  SteamCMDPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'steamcmd\steamcmd.exe';

  if not FileExists(SteamCMDPath) then
  begin
    Resposta := MessageDlg(
      'Arquivo steamcmd.exe não encontrado. Deseja baixá-lo agora?' + sLineBreak +
      'Local da instalação: ' + SteamCMDPath,
      mtConfirmation, [mbYes, mbNo], 0
    );

    if Resposta = mrYes then
    begin
      VerificarEBaixarSteamcmd;

      if not FileExists(SteamCMDPath) then
      begin
        ShowMessage('Falha ao baixar steamcmd.exe. Verifique sua conexão ou tente novamente.');
        Exit;
      end;
    end
    else
    begin
      Exit;
    end;
  end;

  // Lê login/senha do INI
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\Config.ini');
  try
    SteamLoginEnc := Ini.ReadString('STEAM', 'login', '');
    SteamSenhaEnc := Ini.ReadString('STEAM', 'senha', '');
  finally
    Ini.Free;
  end;

  SteamLogin := DecodeSenha(SteamLoginEnc);
  SteamSenha := DecodeSenha(SteamSenhaEnc);

  if (SteamLogin = '') or (SteamSenha = '') then
  begin
    Resposta := MessageDlg(
      'Para prosseguir com a instalação é necessário informar suas credenciais Steam.' + sLineBreak +
      'Deseja informar agora?',
      mtConfirmation, [mbYes, mbNo], 0
    );

    if Resposta = mrYes then
    begin
      try
        Application.CreateForm(Tfrmsteamlogin, frmsteamlogin);
        frmsteamlogin.ShowModal;
      finally
        frmsteamlogin.Free;
      end;
    end;

    Exit;
  end;

  Resposta := MessageDlg(
    'O SteamCMD será instalado agora. O processo fechará automaticamente quando terminar.' + sLineBreak +
    'Deseja continuar?',
    mtConfirmation, [mbYes, mbNo], 0
  );

  if Resposta <> mrYes then
    Exit;

  ZeroMemory(@SEInfo, SizeOf(SEInfo));
  SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  SEInfo.Wnd := 0;
  SEInfo.lpFile := PChar(SteamCMDPath);
  SEInfo.lpParameters := PChar('+login "' + SteamLogin + '" "' + SteamSenha + '" +app_update 223350 validate +quit');
  SEInfo.lpDirectory := PChar(ExtractFilePath(SteamCMDPath));
  SEInfo.nShow := SW_SHOWNORMAL;

  if ShellExecuteEx(@SEInfo) then
  begin
    WaitForSingleObject(SEInfo.hProcess, INFINITE);
    CloseHandle(SEInfo.hProcess);
    ShowMessage('Instalação do SteamCMD concluída.');
  end
  else
  begin
    ShowMessage('Falha ao executar o SteamCMD.');
  end;
end;


procedure TForm1.Integrao1Click(Sender: TObject);
begin
if label1.Visible = false then
  begin
    PauseMon.Click;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;

if checkbox3.Checked then
  begin
    checkbox3.Checked := false;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
AtualizacaoChamadaViaOnActivate := True;
//EvAppUpdate1.Execute;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Hide; // Oculta a aplicação
  ShowTrayIcon; // Adiciona o ícone na bandeja
  CanClose := False; // Impede o fechamento real
end;


//ALTERACAO NOME MENU
//Salva nome
procedure TForm1.SalvarNomesServidores;
var
  Arquivo: TextFile;
  PastaConfig: string;
  CaminhoArquivo: string;
begin
  PastaConfig := ExtractFilePath(Application.ExeName) + 'config\';
  CaminhoArquivo := PastaConfig + 'menu_config.txt';

  // Criar a pasta "config" se não existir
  if not DirectoryExists(PastaConfig) then
    ForceDirectories(PastaConfig);

  // Salvar os nomes no arquivo
  AssignFile(Arquivo, CaminhoArquivo);
  Rewrite(Arquivo);
  WriteLn(Arquivo, StringReplace(Servidor11.Caption, '&', '', [rfReplaceAll]));
  WriteLn(Arquivo, StringReplace(Servidor21.Caption, '&', '', [rfReplaceAll]));
  WriteLn(Arquivo, StringReplace(Servidor31.Caption, '&', '', [rfReplaceAll]));
  CloseFile(Arquivo);
end;

//Carrega nome
procedure TForm1.CarregarNomesServidores;
var
  Arquivo: TextFile;
  Nome: string;
  CaminhoArquivo: string;
begin
  CaminhoArquivo := ExtractFilePath(Application.ExeName) + 'config\menu_config.txt';

  if FileExists(CaminhoArquivo) then
  begin
    AssignFile(Arquivo, CaminhoArquivo);
    Reset(Arquivo);

    if not EOF(Arquivo) then
    begin
      ReadLn(Arquivo, Nome);
      Servidor11.Caption := StringReplace(Nome, '&', '', [rfReplaceAll]);  // Remover o "&"
    end;
    if not EOF(Arquivo) then
    begin
      ReadLn(Arquivo, Nome);
      Servidor21.Caption := StringReplace(Nome, '&', '', [rfReplaceAll]);  // Remover o "&"
    end;
    if not EOF(Arquivo) then
    begin
      ReadLn(Arquivo, Nome);
      Servidor31.Caption := StringReplace(Nome, '&', '', [rfReplaceAll]);  // Remover o "&"
    end;

    CloseFile(Arquivo);
  end;
end;

//Altera nome
procedure TForm1.AlterarNomeServidor(MenuItem: TMenuItem);
var
  NovoNome: string;
begin
  // Remove o '&' do nome antes de abrir o InputBox
  NovoNome := StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll]);

  // Exibe a caixa de diálogo com o nome já sem o '&'
  NovoNome := InputBox('Alterar Nome', 'Digite o novo nome (máx. 10 caracteres):', NovoNome);

  // Verifica se ultrapassa 10 caracteres
  if Length(NovoNome) > 10 then
  begin
    ShowMessage('O nome não pode ter mais de 10 caracteres!');
    Exit;
  end;

  // Altera e salva os nomes
  if NovoNome <> '' then
  begin
    MenuItem.Caption := NovoNome;
    SalvarNomesServidores;

    BitBtn1.Caption := Servidor11.Caption;
    BitBtn2.Caption := Servidor21.Caption;
    BitBtn3.Caption := Servidor31.Caption;
  end;
end;
//END


//COMANDOS NO FORMULARIO PRINCIPAL
//Encerra Servidor
procedure TForm1.EncServidorTimer(Sender: TObject);
var
  Ini: TIniFile;
  HorarioParada: string;
  HoraParada, HoraAtual: TDateTime;
  MinutosRestantes: Integer;
begin
  // Lê o horário de parada do INI
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config\Config.ini');
  try
    HorarioParada := Ini.ReadString('ParadaBackup', 'das', '');
    if HorarioParada = '' then
      Exit; // Nada a fazer se horário não estiver definido
  finally
    Ini.Free;
  end;

  try
    HoraParada := StrToTime(HorarioParada);           // Hora alvo (ex: 03:00)
    HoraParada := Trunc(Now) + HoraParada;            // Combina com a data atual
    HoraAtual := Trunc(Now) + EncodeTime(HourOf(Now), MinuteOf(Now), 0, 0);  // Ignora os segundos

    MinutosRestantes := MinutesBetween(HoraParada, HoraAtual);

    // Só começa a gravar log se faltarem '1' minutos ou menos
    if (MinutosRestantes <= 1) and (MinutosRestantes >= 0) then
    begin
      GravarLogTimerEncServidor('LogEncServidor', 'Processo iniciado');

      if HoraAtual = HoraParada then
      begin
        GravarLogTimerEncServidor('LogEncServidor', 'Horário de parada atingido. Executando procedimentos');

        EncServidor.Enabled := False;
        GravarLogTimerEncServidor('LogEncServidor', 'Timer EncServidor desativado');

        MonServer.Enabled := False;
        GravarLogTimerEncServidor('LogEncServidor', 'Timer MonServer desativado');

        MonMod.Enabled := False;
        GravarLogTimerEncServidor('LogEncServidor', 'Timer MonMod desativado');

        Restart.Enabled := False;
        GravarLogTimerEncServidor('LogEncServidor', 'Timer Restart desativado');

        MonDayz.Enabled := False;
        GravarLogTimerEncServidor('LogEncServidor', 'Timer MonDayz desativado');

        EncerraServidor;
        GravarLogTimerEncServidor('LogEncServidor', 'Procedimento EncerraServidor chamado');

        backuplocal.Enabled := True;
        GravarLogTimerEncServidor('LogEncServidor', 'Timer BackupLocal ativado');

        if MonServer.Enabled then
        begin
          PauseMon.Caption := 'Pausar Monitoramento';
          link.Visible := True;
          label1.Visible := False;
          Label1.Visible := False;
          PauseMon.Enabled := True;
        end
        else
        begin
          PauseMon.Caption := 'Retomar Monitoramento';
          link.Visible := False;
          label3.Visible := True;
          Label1.Visible := True;
          PauseMon.Enabled := False;
        end;
      end
      else
      begin
        GravarLogTimerEncServidor('LogEncServidor', Format('Horário atual (%s) não corresponde ao horário de início (%s)', [
          FormatDateTime('hh:nn', HoraAtual), FormatDateTime('hh:nn', HoraParada)
        ]));
      end;
    end;
  except
    on E: Exception do
      GravarLogTimerEncServidor('LogEncServidor', 'Erro: ' + E.Message);
  end;
end;

//Inicia Google drive
procedure TForm1.StartgoogleTimer(Sender: TObject);
var
  ini: TIniFile;
  horaDas, horaCom5Minutos: TTime;
  horaDasStr, horaCom5MinutosStr: string;
  TempDateTime: TDateTime;
  IniFilePath: string;
begin
  // Aguarda 3 minutos após a hora 'das' para começar a registrar log
  IniFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config\Config.ini';

  if not FileExists(IniFilePath) then Exit;

  ini := TIniFile.Create(IniFilePath);
  try
    horaDasStr := Trim(ini.ReadString('ParadaBackup', 'das', ''));
    if (horaDasStr <> '') and (Length(horaDasStr) = 5) and (horaDasStr[3] = ':') then
    begin
      if TryStrToTime(horaDasStr, TempDateTime) then
      begin
        horaDas := TimeOf(TempDateTime);
        horaCom5Minutos := EncodeTime(HourOf(IncMinute(horaDas, 3)), MinuteOf(IncMinute(horaDas, 3)), 0, 0); //99 Inicio reg do log '3'minutos apos hporario chave 'das'

        if Time < horaCom5Minutos then Exit;
      end;
    end;
  finally
    ini.Free;
  end;

  // A partir daqui permanece igual
  GravarLogTimerStartGoogle('LogStartGD', 'Processo iniciado');

  IniFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config\Config.ini';

  if not FileExists(IniFilePath) then
  begin
    GravarLogTimerStartGoogle('LogStartGD', 'Arquivo "Config.ini" inexistente. Encerrando processo');
    Exit;
  end;
  GravarLogTimerStartGoogle('LogStartGD', 'Arquivo "Config.ini" encontrado');

  ini := TIniFile.Create(IniFilePath);
  try
    horaDasStr := Trim(ini.ReadString('ParadaBackup', 'das', ''));
    GravarLogTimerStartGoogle('LogStartGD', 'Horário lido da chave "das": ' + horaDasStr);

    if horaDasStr = '' then
    begin
      GravarLogTimerStartGoogle('LogStartGD', 'Parada para Backup não definido');
      Exit;
    end;

    if (Length(horaDasStr) = 5) and (horaDasStr[3] = ':') then
    begin
      if TryStrToTime(horaDasStr, TempDateTime) then
      begin
        horaDas := TimeOf(TempDateTime);
        horaCom5Minutos := EncodeTime(HourOf(IncMinute(horaDas, 4)), MinuteOf(IncMinute(horaDas, 4)), 0, 0); //10 aqui continua como estava no seu código
        horaCom5MinutosStr := FormatDateTime('hh:nn', horaCom5Minutos);

        GravarLogTimerStartGoogle('LogStartGD', 'Horário alvo para iniciar: ' + horaCom5MinutosStr);

        if FormatDateTime('hh:nn', Now) = horaCom5MinutosStr then
        begin
          GravarLogTimerStartGoogle('LogStartGD', 'Horário dentro do intervalo. Iniciando Google Drive');
          try
            Startgoogle.Enabled := False;
            GravarLogTimerStartGoogle('LogStartGD', 'Timer StartGoogle desativado');
            IniciarGoogleDrive;
            GravarLogTimerStartGoogle('LogStartGD', 'Google Drive iniciado com sucesso.');

            Closegoogle.Enabled := True;
            GravarLogTimerStartGoogle('LogStartGD', 'Timer CloseGoogle ativado');
          except
            on E: Exception do
              GravarLogTimerStartGoogle('LogStartGD', 'Erro ao iniciar Google Drive: ' + E.Message);
          end;
        end
        else
          GravarLogTimerStartGoogle('LogStartGD', 'Horário fora do intervalo. Nenhuma ação executada');
      end
      else
        GravarLogTimerStartGoogle('LogStartGD', 'Erro ao converter "das" para TDateTime');
    end
    else
      GravarLogTimerStartGoogle('LogStartGD', 'Formato inválido do horário "das": ' + horaDasStr);
  finally
    ini.Free;
  end;
end;



//Encerra google drive
procedure TForm1.ClosegoogleTimer(Sender: TObject);
var
  ini: TIniFile;
  horaDas, horaCom5Minutos, horaCom45Minutos: TTime;
  horaDasStr, horaCom5MinutosStr, horaCom45MinutosStr: string;
  TempDateTime: TDateTime;
  IniFilePath: string;
begin
  // Aguarda 5 minutos após a hora 'das' para começar a registrar log
  IniFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config\Config.ini';

  if not FileExists(IniFilePath) then Exit;

  ini := TIniFile.Create(IniFilePath);
  try
    horaDasStr := Trim(ini.ReadString('ParadaBackup', 'das', ''));
    if (horaDasStr <> '') and (Length(horaDasStr) = 5) and (horaDasStr[3] = ':') then
    begin
      if TryStrToTime(horaDasStr, TempDateTime) then
      begin
        horaDas := TimeOf(TempDateTime);
        horaCom5Minutos := EncodeTime(HourOf(IncMinute(horaDas, 6)), MinuteOf(IncMinute(horaDas, 6)), 0, 0); //39 atraso reg log 5

        if Time < horaCom5Minutos then Exit;
      end;
    end;
  finally
    ini.Free;
  end;

  // A partir daqui permanece seu código original
  GravarLogTimerCloseGoogle('LogCloseGD', 'Processo iniciado');

  IniFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config\Config.ini';

  if not FileExists(IniFilePath) then
  begin
    GravarLogTimerCloseGoogle('LogCloseGD', 'Arquivo "Config.ini" inexistente. Encerrando processo');
    Exit;
  end;

  GravarLogTimerCloseGoogle('LogCloseGD', 'Arquivo "Config.ini" encontrado');

  ini := TIniFile.Create(IniFilePath);
  try
    horaDasStr := Trim(ini.ReadString('ParadaBackup', 'das', ''));
    GravarLogTimerCloseGoogle('LogCloseGD', 'Horário lido da chave "das": ' + horaDasStr);

    if horaDasStr = '' then
    begin
      GravarLogTimerCloseGoogle('LogCloseGD', 'Parada para Backup não definido');
      Exit;
    end;

    if (Length(horaDasStr) = 5) and (horaDasStr[3] = ':') then
    begin
      if TryStrToTime(horaDasStr, TempDateTime) then
      begin
        horaDas := TimeOf(TempDateTime);
        horaCom45Minutos := EncodeTime(HourOf(IncMinute(horaDas, 7)), MinuteOf(IncMinute(horaDas, 7)), 0, 0); // 40mantém como no seu código original
        horaCom45MinutosStr := FormatDateTime('hh:nn', horaCom45Minutos);

        GravarLogTimerCloseGoogle('LogCloseGD', 'Hora alvo para encerramento: ' + horaCom45MinutosStr);

        if FormatDateTime('hh:nn', Now) = horaCom45MinutosStr then
        begin
          GravarLogTimerCloseGoogle('LogCloseGD', 'Condição de horário atingida. Encerrando Google Drive.');

          try
            Closegoogle.Enabled := False;
            GravarLogTimerCloseGoogle('LogCloseGD', 'Timer CloseGoogle desativado');

            EncerraGoogleDrive('GoogleDriveFS.exe');
            GravarLogTimerCloseGoogle('LogCloseGD', 'Google Drive encerrado');

            movelog.Enabled := True;
            GravarLogTimerCloseGoogle('LogCloseGD', 'Timer MoveLog ativado');
          except
            on E: Exception do
              GravarLogTimerCloseGoogle('LogCloseGD', 'Erro ao encerrar Google Drive: ' + E.Message);
          end;
        end
        else
          GravarLogTimerCloseGoogle('LogCloseGD', 'Horário atual fora da faixa de encerramento');
      end
      else
        GravarLogTimerCloseGoogle('LogCloseGD', 'Erro ao converter o horário da chave "das"');
    end
    else
      GravarLogTimerCloseGoogle('LogCloseGD', 'Formato inválido da chave "das": ' + horaDasStr);
  finally
    ini.Free;
  end;
end;


//Exclui log antigo
function CompareDatasDesc(List: TStringList; Index1, Index2: Integer): Integer;
begin
  // Ordem decrescente (mais recente primeiro)
  Result := CompareText(List[Index2], List[Index1]);
end;

procedure ExcluirPastaComConteudo(const Pasta: string);
var
  FO: TSHFileOpStruct;
  PastaComNulo: string;
begin
  FillChar(FO, SizeOf(FO), 0);
  PastaComNulo := IncludeTrailingPathDelimiter(Pasta) + #0#0;
  FO.wFunc := FO_DELETE;
  FO.pFrom := PChar(PastaComNulo);
  FO.fFlags := FOF_NOERRORUI or FOF_SILENT or FOF_NOCONFIRMATION;
  SHFileOperation(FO);
end;

procedure ExcluirPastasAntigasDeLog;
var
  LogPath: string;
  SR: TSearchRec;
  ListaPastas: TStringList;
  i, DummyInt: Integer;
begin
  LogPath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName) + 'log');
  ListaPastas := TStringList.Create;
  try
    // Coleta subpastas com nome no formato YYYYMMDD
    if FindFirst(LogPath + '*', faDirectory, SR) = 0 then
    begin
      repeat
        if ((SR.Attr and faDirectory) = faDirectory) and
           (SR.Name <> '.') and (SR.Name <> '..') and
           (Length(SR.Name) = 8) and TryStrToInt(SR.Name, DummyInt) then
        begin
          ListaPastas.Add(SR.Name);
        end;
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;

    // Ordena do mais recente para o mais antigo
    ListaPastas.CustomSort(CompareDatasDesc);

    // Mantém as 3 mais recentes, exclui o restante
    for i := 3 to ListaPastas.Count - 1 do
      ExcluirPastaComConteudo(LogPath + ListaPastas[i]);

  finally
    ListaPastas.Free;
  end;
end;

//Inicia novamente Servidor
procedure TForm1.StartServidor1Timer(Sender: TObject);
var
  ini: TIniFile;
  horaAte, horaAtual: TDateTime;
  horaAteStr: string;
  MinutosRestantes: Integer;
  IniFilePath: string;
begin
  IniFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config\Config.ini';

  if not FileExists(IniFilePath) then
    Exit;

  ini := TIniFile.Create(IniFilePath);
  try
    horaAteStr := Trim(ini.ReadString('ParadaBackup', 'ate', ''));
    if horaAteStr = '' then
      Exit;

    if (Length(horaAteStr) = 5) and (horaAteStr[3] = ':') and TryStrToTime(horaAteStr, horaAte) then
    begin
      horaAte := Trunc(Now) + horaAte;  // Hora alvo do INI com a data de hoje
      horaAtual := Trunc(Now) + EncodeTime(HourOf(Now), MinuteOf(Now), 0, 0);  // Hora atual ignorando os segundos

      MinutosRestantes := MinutesBetween(horaAte, horaAtual);

      // Só grava o log se estiver nos '1' minutos finais
      if (MinutosRestantes <= 1) and (MinutosRestantes >= 0) then
      begin
        GravarLogTimerStartServer('LogStartServer', 'Processo iniciado');
        GravarLogTimerStartServer('LogStartServer', 'Arquivo "Config.ini" localizado');
        GravarLogTimerStartServer('LogStartServer', 'Horário lido da chave "ate": ' + horaAteStr);
        GravarLogTimerStartServer('LogStartServer', 'Hora configurada para iniciar servidor: ' + FormatDateTime('hh:nn', horaAte));

        if horaAtual = horaAte then
        begin
          GravarLogTimerStartServer('LogStartServer', 'Condição de horário atendida. Iniciando servidor...');

          StartServidor;
          GravarLogTimerStartServer('LogStartServer', 'StartServidor executado');

          MonServer.Enabled := True;
          GravarLogTimerStartServer('LogStartServer', 'Timer MonServer ativado');

          EncServidor.Enabled := True;
          GravarLogTimerStartServer('LogStartServer', 'Timer EncServidor ativado');

          MonMod.Enabled := True;
          GravarLogTimerStartServer('LogStartServer', 'Timer MonMod ativado');

          Restart.Enabled := True;
          GravarLogTimerStartServer('LogStartServer', 'Timer Restart ativado');

          MonDayz.Enabled := True;
          GravarLogTimerStartServer('LogStartServer', 'Timer MonDayz ativado');

          FinderCarServer1.Enabled := True;
          GravarLogTimerStartServer('LogStartServer', 'FinderCarServer1 ativado');

          FinderCarServer2.Enabled := True;
          GravarLogTimerStartServer('LogStartServer', 'FinderCarServer2 ativado');

          FinderCarServer3.Enabled := True;
          GravarLogTimerStartServer('LogStartServer', 'FinderCarServer3 ativado');

          StartServidor1.Enabled := False;
          GravarLogTimerStartServer('LogStartServer', 'Timer StartServidor desativado');

          ExcluirPastasAntigasDeLog;
          GravarLogTimerStartServer('LogStartServer', 'Evento `Excluir log antigo´ executado');

          ExcluirBackupsAntigos;
          GravarLogTimerStartServer('LogStartServer', 'Evento `Excluir backup antigo´ executado');

          AtualizacaoChamadaViaTimer := True;
          EvAppUpdate1.Execute;
          GravarLogTimerStartServer('LogStartServer', 'Evento `Checar atualizacao do sistema´ executado');

          if MonServer.Enabled then
          begin
            PauseMon.Caption := 'Pausar Monitoramento';
            link.Visible := True;
            label3.Visible := False;
            Label1.Visible := False;
            PauseMon.Enabled := True;
          end
          else
          begin
            PauseMon.Caption := 'Retomar Monitoramento';
            link.Visible := False;
            label3.Visible := True;
            Label1.Visible := True;
            PauseMon.Enabled := False;
          end;
        end
        else
          GravarLogTimerStartServer('LogStartServer', Format('Horário atual (%s) fora da janela para iniciar servidor (esperado: %s)', [
            FormatDateTime('hh:nn', horaAtual), FormatDateTime('hh:nn', horaAte)
          ]));
      end;
    end
    else
      GravarLogTimerStartServer('LogStartServer', 'Formato inválido ou erro ao converter horário da chave "ate"');
  finally
    ini.Free;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
if Link.Font.Color = clGreen then
    Link.Font.Color := clBtnface
  else
    Link.Font.Color := clGreen;
end;

procedure TForm1.TimerMonitorTimer(Sender: TObject);
begin
 if EmExecucao then
    Exit;

  EmExecucao := True;

  TTask.Run(
    procedure
    begin
      try
        MonitorarMods;
      finally
        // Marca fim da execução na thread principal (UI)
        TThread.Queue(nil,
          procedure
          begin
            EmExecucao := False;
          end);
      end;
    end);
end;

//Oculta o sistema
procedure TForm1.EvAppUpdate1AppIsUpdated(Sender: TObject);
begin
  if AtualizacaoChamadaViaMenu then
  begin
    ShowMessage('Nenhuma atualização encontrada.');
    PauseMon.Click;
  end;
    AtualizacaoChamadaViaMenu := False;
end;

procedure TForm1.EvAppUpdate1DownloadProgress(Sender: TObject; BytesTotal,
  BytesReceived: Double);
var
  S: string;
begin
  //se utilizar esta funcao, deve ser add o statusbar
  //S := FormatFloat('#0', (BytesReceived/BytesTotal)*100);
  //StbInfo.SimpleText := 'Baixando atualização: ' + S + '% concluído.';
end;

procedure TForm1.EvAppUpdate1Error(Sender: TObject; Error: TEvUpdateError);
begin
if AtualizacaoChamadaViaMenu then
  begin
  case Error of
    ueInvalidURL: ShowMessage('O endereço no Servidor de atualização não é válido.');
    ueControlFile: ShowMessage('Não foi possível baixar o arquivo de controle da atualização.');
    ueApplicationFile: ShowMessage('Não foi possível baixar o arquivo da atualização.');
    ueInvalidControlFile: ShowMessage('O arquivo de controle da atualização não é válido.');
    ueUpdateError: ShowMessage('Um erro impediu a conclusão do processo de atualização.');
    ueAborted: ShowMessage('O processo de atualização foi abortado pelo usuário.');
  end;
      PauseMon.Click;
  end;
AtualizacaoChamadaViaMenu := False;
end;

//cria o arquivo .bat para startar a aplicacao novamente apos atualizacao
procedure CriarERodarBatch;
var
  SL: TStringList;
  BatPath, AppPath, TempDir: string;
begin
  AppPath := Application.ExeName;

  // Caminho da pasta \Temp dentro da pasta de instalação
  TempDir := ExtractFilePath(AppPath) + 'Temp\';

  // Cria a pasta Temp se não existir
  if not DirectoryExists(TempDir) then
    CreateDir(TempDir);

  // Nome do BAT
  BatPath := TempDir + 'RestartApp.bat';

  SL := TStringList.Create;
  try
    SL.Add('@echo off');
    SL.Add('timeout /t 5 /nobreak > nul');
    SL.Add('start "" "' + AppPath + '"');
    SL.Add('del "%~f0"');  // O próprio BAT se deleta depois
    SL.SaveToFile(BatPath);

    // Executa o BAT de forma invisível
    ShellExecute(0, 'open', PChar(BatPath), nil, nil, SW_HIDE);
  finally
    SL.Free;
  end;
end;

//procedure TForm1.EvAppUpdate1RequestLogout(Sender: TObject);
//begin
  //if AtualizacaoChamadaViaMenu then
  //begin
  //ShowMessage('Uma nova versão do sistema está disponível e foi baixada com sucesso!'#13'Encerre a aplicação para concluir o processo de atualização.');
  //end;
  //CriarERodarBatch;
  //Application.Terminate;
  //AtualizacaoChamadaViaMenu := False;
//end;

//verifica e baixa dll WEBVIEW2LOADER
procedure VerificarEBaixarDLLs;
const
  BaseURL = 'https://github.com/hfsoftwaree/hfmanagerupdate/releases/download/installer/';
//  Arquivos: array[0..1] of string = ('midas.dll', 'WebView2Loader.dll');
  Arquivos: array[0..0] of string = ('WebView2Loader.dll');
var
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  NomeArquivo, URL, Destino, LogDir, LogPath: string;
  I: Integer;
  MemStream: TMemoryStream;
begin
  HTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;

    // Define pasta de log: .\Log
    LogDir := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Log');
    if not DirectoryExists(LogDir) then
      ForceDirectories(LogDir);
    LogPath := TPath.Combine(LogDir, 'erros_download_AppUpdate.log');

    for I := Low(Arquivos) to High(Arquivos) do
    begin
      NomeArquivo := Arquivos[I];
      Destino := TPath.Combine(ExtractFilePath(ParamStr(0)), NomeArquivo);

      if not FileExists(Destino) then
      begin
        URL := BaseURL + NomeArquivo;
        try
          MemStream := TMemoryStream.Create;
          try
            HTTP.Get(URL, MemStream);
            MemStream.SaveToFile(Destino);
          finally
            MemStream.Free;
          end;
        except
          on E: Exception do
          begin
            // Salva o erro no log da pasta \Log
            TFile.AppendAllText(LogPath,
              Format('[%s] Falha ao baixar %s: %s' + sLineBreak,
                [DateTimeToStr(Now), NomeArquivo, E.Message]));
          end;
        end;
      end;
    end;
  finally
    HTTP.Free;
    SSL.Free;
  end;
end;

procedure TForm1.EvAppUpdate1RequestLogout(Sender: TObject);
begin
  //VerificarEBaixarDLLs;

  if AtualizacaoChamadaViaMenu then
  begin
    ShowMessage('Uma nova versão do sistema está disponível e foi baixada com sucesso!'#13'Encerre a aplicação para concluir o processo de atualização.');
    CriarERodarBatch;
    Application.Terminate;
  end
  else if AtualizacaoChamadaViaOnActivate then
  begin
    Form1.Height := 360;
    Panel4.Height := 65;
    Label4.Visible := true;
    Label4.Caption := 'Uma nova versão do sistema está disponível! Encerre a aplicação para concluir o processo de atualização.';
  end
  else if AtualizacaoChamadaViaTimer then
  begin
    CriarERodarBatch;
    Application.Terminate;
  end;

  // Limpa os flags para evitar efeitos em futuras chamadas
  AtualizacaoChamadaViaMenu := False;
  AtualizacaoChamadaViaOnActivate := False;
  AtualizacaoChamadaViaTimer := False;
end;

procedure TForm1.EventMinimize(Sender: TObject);
begin
  Hide; // Oculta a janela
  ShowTrayIcon; // Adiciona o ícone na bandeja
  Application.Minimize;
end;

procedure TForm1.EvKeyNavigator1KeyPress(Sender: TObject; Key: Word;
  var Action: TEvNavAction);
begin

end;

//Executa monitoramente para saber se esta ativo
procedure TForm1.MonServerTimer(Sender: TObject);
var
  Reg: TRegistry;
begin
  // Monitora e reinicia o servidor Banov
  CheckAndRestartServerBanov;
   Sleep(3000); // Atraso de 3 segundos

  // Monitora e reinicia o servidor Chernarus
  CheckAndRestartServerCherno;
   Sleep(3000); // Atraso de 3 segundos

  // Monitora e reinicia o servidor Livonia
  CheckAndRestartServerLivonia;

  //checkbox4 monitora att steam
  //Esta verificacao passou direto para o procedimento MonitoraMod e tambem chamado a partir do ttimer proprio
  //Reg := TRegistry.Create;
  //try
    //Reg.RootKey := HKEY_CURRENT_USER;
    //if Reg.OpenKey('\SOFTWARE\HFManager\Config', False) then
    //begin
      //if Reg.ValueExists('Monsteamcmd') then
      //begin
        //CheckBox4.Checked := Reg.ReadBool('Monsteamcmd');

        //if CheckBox4.Checked then
        //begin
          //if not IsUmdBatRunning then
          //MonitorarMods;
        //end;
      //end;
    //end;
  //finally
    //Reg.Free;
  //end;

  VerificarVeiculosDestruidosS1;
  VerificarVeiculosDestruidosS2;
  VerificarVeiculosDestruidosS3;
end;

//Abre formulario sobre 
procedure TForm1.Sobre1Click(Sender: TObject);
begin
if label1.Visible = false then
  begin
    PauseMon.Click;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;

if checkbox3.Checked then
  begin
    checkbox3.Checked := false;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;
end;

procedure TForm1.Sobreaverso1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform2, form2);
    form2.ShowModal;
  finally
    form2.Free;
  end;
end;

//METODO PARA BAIXAR MOD - VERIFICA SE DLL EXISTE
procedure TForm1.IniciarVerificacaoDLL;
var
  DllPath: string;
  Timer: TTimer;
begin
  DllPath := ExtractFilePath(Application.ExeName) + 'WebView2Loader.dll';

  if not FileExists(DllPath) then
  begin
    ShowMessage('Alguns ajustes são necessários. No término do processo o sistema proceguira automaticamente, por favor aguarde!');
    VerificarEBaixarDLLs;

    // Cria o timer que vai aguardar sem travar
    Timer := TTimer.Create(Self);
    Timer.Interval := 3000; // 3 segundos
    Timer.OnTimer := ContinuarAposDownload;
    Timer.Enabled := True;
  end
  else
  begin
    AbrirFormWebSteam;
  end;
end;

procedure TForm1.ContinuarAposDownload(Sender: TObject);
var
  DllPath: string;
begin
  // Desativa e destrói o timer
  TTimer(Sender).Enabled := False;
  TTimer(Sender).Free;

  DllPath := ExtractFilePath(Application.ExeName) + 'WebView2Loader.dll';

  if FileExists(DllPath) then
    AbrirFormWebSteam
  else
    ShowMessage('Falha ao baixar a DLL. Tente novamente ou contate o suporte.');
end;

procedure TForm1.AbrirFormWebSteam;
begin
  try
    Application.CreateForm(Tformwebsteam, formwebsteam);
    formwebsteam.ShowModal;
  finally
    formwebsteam.Free;
  end;
end;

procedure TForm1.Baixarmod1Click(Sender: TObject);
var
  CaminhoSteamCmd: string;
begin
  // Define o caminho completo do steamcmd.exe
  CaminhoSteamCmd := ExtractFilePath(Application.ExeName) + 'Steamcmd\steamcmd.exe';

  // Verifica se o arquivo existe
  if not FileExists(CaminhoSteamCmd) then
  begin
    if MessageDlg('Steamcmd.exe não encontrado. Deseja instalá-lo agora?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Instalarsteamcmd1Click(Self);  // Chama diretamente o método que instala
    end;
    Exit;
  end;

  if label1.Visible = false then
  begin
    PauseMon.Click;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;

  if checkbox3.Checked then
  begin
    checkbox3.Checked := false;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;

  IniciarVerificacaoDLL;
end;

procedure TForm1.BEC1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform1234, form1234);
    form1234.ShowModal;
  finally
    form7.Free;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja parar o servidor ' + BitBtn1.Caption +'?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
  shutdowbanov;
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja parar o servidor ' + BitBtn2.Caption +'?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    shutdowcherno;
  end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja parar o servidor ' + BitBtn3.Caption +'?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    shutdowlivonia;
  end;
end;


//MoveLog
procedure TForm1.MovelogTimer(Sender: TObject);
var
  ini: TIniFile;
  horaDas, horaCom5Minutos, horaCom50Minutos: TTime;
  horaDasStr, horaCom5MinutosStr, horaCom50MinutosStr: string;
  TempDateTime: TDateTime;
  IniFilePath: string;
begin
  // Aguarda 5 minutos após a hora 'das' para começar a registrar log
  IniFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config\Config.ini';

  if not FileExists(IniFilePath) then Exit;

  ini := TIniFile.Create(IniFilePath);
  try
    horaDasStr := Trim(ini.ReadString('ParadaBackup', 'das', ''));
    if (horaDasStr <> '') and (Length(horaDasStr) = 5) and (horaDasStr[3] = ':') then
    begin
      if TryStrToTime(horaDasStr, TempDateTime) then
      begin
        horaDas := TimeOf(TempDateTime);
        horaCom5Minutos := EncodeTime(HourOf(IncMinute(horaDas, 7)), MinuteOf(IncMinute(horaDas, 7)), 0, 0); // 44 Espera 5 minutos após 'das'
        
        if Time < horaCom5Minutos then Exit; // Aguarda até passar 5 minutos após 'das'
      end;
    end;
  finally
    ini.Free;
  end;

  // A partir daqui permanece seu código original para registrar o log
  GravarLogTimerMoveLog('LogMoveLog', 'Processo iniciado');

  IniFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config\Config.ini';

  if not FileExists(IniFilePath) then
  begin
    GravarLogTimerMoveLog('LogMoveLog', 'Arquivo "Config.ini" inexistente. Encerrando processo');
    Exit;
  end;

  GravarLogTimerMoveLog('LogMoveLog', 'Arquivo "Config.ini" encontrado');

  ini := TIniFile.Create(IniFilePath);
  try
    horaDasStr := Trim(ini.ReadString('ParadaBackup', 'das', ''));
    GravarLogTimerMoveLog('LogMoveLog', 'Horário lido da chave "das": ' + horaDasStr);

    if horaDasStr = '' then
    begin
      GravarLogTimerMoveLog('LogMoveLog', 'Parada para Backup não definido');
      Exit;
    end;

    if (Length(horaDasStr) = 5) and (horaDasStr[3] = ':') then
    begin
      if TryStrToTime(horaDasStr, TempDateTime) then
      begin
        horaDas := TimeOf(TempDateTime);
        horaCom50Minutos := EncodeTime(HourOf(IncMinute(horaDas, 8)), MinuteOf(IncMinute(horaDas, 8)), 0, 0); //45 hora com 4 minutos após 'das'
        horaCom50MinutosStr := FormatDateTime('hh:nn', horaCom50Minutos);

        GravarLogTimerMoveLog('LogMoveLog', 'Hora alvo para mover logs: ' + horaCom50MinutosStr);

        if FormatDateTime('hh:nn', Now) = horaCom50MinutosStr then
        begin
          GravarLogTimerMoveLog('LogMoveLog', 'Condição de horário atingida. Movendo logs.');

          try
            Movelog.Enabled := False;
            GravarLogTimerMoveLog('LogMoveLog', 'Timer MoveLog desativado');

            MoveLogFilesBanov;
            GravarLogTimerMoveLog('LogMoveLog', 'Logs Servidor1 movidos');

            MoveLogFilesCherno;
            GravarLogTimerMoveLog('LogMoveLog', 'Logs Servidor2 movidos');

            MoveLogFilesLivonia;
            GravarLogTimerMoveLog('LogMoveLog', 'Logs Servidor3 movidos');

            StartServidor1.Enabled := True;
            GravarLogTimerMoveLog('LogMoveLog', 'Timer StartServidor ativado');
          except
            on E: Exception do
              GravarLogTimerMoveLog('LogMoveLog', 'Erro ao mover logs: ' + E.Message);
          end;
        end
        else
          GravarLogTimerMoveLog('LogMoveLog', 'Horário atual fora da faixa de movimentação de logs');
      end
      else
        GravarLogTimerMoveLog('LogMoveLog', 'Erro ao converter o horário da chave "das"');
    end
    else
      GravarLogTimerMoveLog('LogMoveLog', 'Formato inválido da chave "das": ' + horaDasStr);
  finally
    ini.Free;
  end;
end;

//end


procedure TForm1.Servidor11Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform3, form3);
    form3.ShowModal;
  finally
    form3.Free;
  end;
end;

procedure TForm1.AlterarnomeServidor11Click(Sender: TObject);
begin
  AlterarNomeServidor(Servidor11); // Altera o nome do Servidor 1
end;

procedure TForm1.AlterarnomeServidor21Click(Sender: TObject);
begin
  AlterarNomeServidor(Servidor21); // Altera o nome do Servidor 1
end;

procedure TForm1.AlterarnomeServidor31Click(Sender: TObject);
begin
  AlterarNomeServidor(Servidor31); // Altera o nome do Servidor 1
end;

procedure TForm1.Configuracao1Click(Sender: TObject);
begin
  //Altera nome dos submenu
  AlterarnomeServidor11.Caption := 'Alterar nome [' + Servidor11.Caption +']';
  AlterarnomeServidor21.Caption := 'Alterar nome [' + Servidor21.Caption +']';
  AlterarnomeServidor31.Caption := 'Alterar nome [' + Servidor31.Caption +']';

  Servidor12.Caption := Servidor11.Caption ;
  Servidor22.Caption := Servidor21.Caption ;
  Servidor32.Caption := Servidor31.Caption ;

  if label1.Visible = false then
  begin
    PauseMon.Click;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;

  if checkbox3.Checked then
  begin
    checkbox3.Checked := false;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;

end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
Application.Terminate ;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if checkbox1.Checked = true then
  begin
  Panel2.Enabled := CheckBox1.Checked;
  panel2.Visible := true;
  end
  else
  begin
  panel2.Visible := false;
  end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(REG_KEY, True) then
    begin
      if CheckBox2.Checked then
        Reg.WriteString(APP_NAME, Application.ExeName)  // Adiciona ao Registro
      else
        Reg.DeleteValue(APP_NAME);  // Remove do Registro
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm1.Servidor21Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform4, form4);
    form4.ShowModal;
  finally
    form4.Free;
  end;
end;

procedure TForm1.Servidor31Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform5, form5);
    form5.ShowModal;
  finally
    form5.Free;
  end;
end;

procedure TForm1.PauseMonClick(Sender: TObject);
begin
  if MonServer.Enabled then
  begin
    // Pausa o monitoramento desativando o TTimer
    MonServer.Enabled := False;
    Encservidor.Enabled := False;
    Restart.Enabled := False;
    PauseMon.Caption := 'Retomar Monitoramento';
    link.Visible := false;
    Label1.Visible := true;
  end
  else
  begin
    // Retoma o monitoramento ativando o TTimer
    MonServer.Enabled := True;
    Encservidor.Enabled := True;
    Restart.Enabled := True;
    PauseMon.Caption := 'Pausar Monitoramento';
    link.Visible := true;
    Label1.Visible := false;
  end;
end;

procedure TForm1.Restart1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform6, form6);
    form6.ShowModal;
  finally
    form6.Free;
  end;
end;

procedure TForm1.Restart2Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform123, form123);
    form123.ShowModal;
  finally
    form123.Free;
  end;
end;

procedure TForm1.UpdateMOD1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform7, form7);
    form7.ShowModal;
  finally
    form7.Free;
  end;
end;

procedure TForm1.Verificaratualizao1Click(Sender: TObject);
begin
AtualizacaoChamadaViaMenu := True;
PauseMon.Click;
EvAppUpdate1.Execute;
end;

procedure TForm1.UpdateDayz1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform8, form8);
    form8.ShowModal;
  finally
    form8.Free;
  end;
end;

//CRIA ARQUIVO BASEANO NO MAIS ATUALIZADO NO STEAMWORKSHOP OMEGAMANAGER
function ObterDiretorioOrigem: string;
var
  Ini: TIniFile;
  ConfigPath: string;
begin
  Result := '';
  try
    // Obtém o caminho do arquivo INI dentro do diretório do sistema
    ConfigPath := ExtractFilePath(Application.ExeName) + 'Config\config.ini';

    // Abre o arquivo .ini
    Ini := TIniFile.Create(ConfigPath);
    try
      // Lê o caminho da chave "UpdateMod", linha "origem"
      Result := Ini.ReadString('UpdateMod', 'origem', '');
    finally
      Ini.Free;
    end;
  except
    on E: Exception do
      //ShowMessage('Erro ao ler o arquivo INI: ' + E.Message);
  end;
end;

function ObterDataPastaMaisRecente(const Diretorio: string): string;
var
  SR: TSearchRec;
  DataMaisRecente: TDateTime;
  DataPasta: TDateTime;
begin
  Result := '';
  DataMaisRecente := 0;

  if DirectoryExists(Diretorio) then
  begin
    // Procura por diretórios dentro do diretório especificado
    if FindFirst(Diretorio + '\*', faDirectory, SR) = 0 then
    begin
      repeat
        // Ignora "." e ".." e garante que é um diretório válido
        if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          DataPasta := FileDateToDateTime(SR.Time);
          if DataPasta > DataMaisRecente then
            DataMaisRecente := DataPasta;
        end;
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;
  end;

  // Se encontrou uma data válida, retorna no formato "yyyy-mm-dd_hh-nn-ss.txt"
  if DataMaisRecente > 0 then
    Result := FormatDateTime('yyyy-mm-dd_hh-nn-ss', DataMaisRecente) + '.txt';
end;

//ENVIA MENSAGEM PARA CANAL NO DISCORD INFORMANDO SOBRE ATT DO DAYZ
//UNITNECESSÁRIO: IdHTTP, IdSSLOpenSSL, IdGlobal
//Canal1 - AVISOS
function GetIniValue(const Section, Key, Default: string): string;
var
  Ini: TIniFile;
  IniFilePath: string;
begin
  IniFilePath := ExtractFilePath(ParamStr(0)) + 'Config\config.ini';
  Ini := TIniFile.Create(IniFilePath);
  try
    Result := Ini.ReadString(Section, Key, Default);
  finally
    Ini.Free;
  end;
end;

function GetExecutableVersion(const FileName: string): string;
var
  Size, Handle: DWORD;
  Buffer: Pointer;
  FixedFileInfo: PVSFixedFileInfo;
  Len: UINT;
begin
  Result := '';
  Size := GetFileVersionInfoSize(PChar(FileName), Handle);
  if Size = 0 then Exit;

  GetMem(Buffer, Size);
  try
    if GetFileVersionInfo(PChar(FileName), Handle, Size, Buffer) and
       VerQueryValue(Buffer, '\', Pointer(FixedFileInfo), Len) then
    begin
      Result := Format('%d.%d.%d.%d',
        [HiWord(FixedFileInfo.dwFileVersionMS), LoWord(FixedFileInfo.dwFileVersionMS),
         HiWord(FixedFileInfo.dwFileVersionLS), LoWord(FixedFileInfo.dwFileVersionLS)]);
    end;
  finally
    FreeMem(Buffer);
  end;
end;

//Mensagem de aviso ao detectar att dayz
procedure SendMessageDiscordExeAS1;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Obtendo as URLs dos webhooks a partir do arquivo INI
  Webhook1 := GetIniValue('Servidor 1', 'webhookavisos', '');

  // Criando o JSON para enviar
//  JsonData := '{"content": "ATENÇÃO: Nova versão do DAYZ disponível. Servidor irá desligar em 3(três) minutos!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateDayz', 'mensagemdayz', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializando os componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;

    // Cabeçalhos HTTP
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviando para cada webhook, se estiver definido
    if Webhook1 <> '' then
      IdHTTP.Post(Webhook1, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberando memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;

procedure SendMessageDiscordExeAS2;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Obtendo as URLs dos webhooks a partir do arquivo INI
  Webhook2 := GetIniValue('Servidor 2', 'webhookavisos', '');

  // Criando o JSON para enviar
//  JsonData := '{"content": "ATENÇÃO: Nova versão do DAYZ disponível. Servidor irá desligar em 3(três) minutos!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateDayz', 'mensagemdayz', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializando os componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;

    // Cabeçalhos HTTP
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviando para cada webhook, se estiver definido
    if Webhook2 <> '' then
      IdHTTP.Post(Webhook2, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberando memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;

procedure SendMessageDiscordExeAS3;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Obtendo as URLs dos webhooks a partir do arquivo INI
  Webhook3 := GetIniValue('Servidor 3', 'webhookavisos', '');

  // Criando o JSON para enviar
//  JsonData := '{"content": "ATENÇÃO: Nova versão do DAYZ disponível. Servidor irá desligar em 3(três) minutos!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateDayz', 'mensagemdayz', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializando os componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;

    // Cabeçalhos HTTP
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviando para cada webhook, se estiver definido
    if Webhook3 <> '' then
      IdHTTP.Post(Webhook3, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberando memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;
//end

//Canal2 - UPDATE DAYZ para todos os servidores
procedure SendMessageDiscordExeUS1;
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData, OrigemPath, ExecutablePath, VersionStr: string;
  SR: TSearchRec;
begin
  // Ler o WebhookURL do arquivo INI
  WebhookURL := GetIniValue('UpdateDayz', 'webhookinfodayz', '');
  if WebhookURL = '' then Exit; // Sai se não houver um webhook válido

  // Ler o caminho da origem do arquivo INI
  OrigemPath := GetIniValue('UpdateDayz', 'origem', '');
  if (OrigemPath = '') or (not DirectoryExists(OrigemPath)) then Exit;

  // Procurar pelo arquivo executável no diretório de origem
  if FindFirst(IncludeTrailingPathDelimiter(OrigemPath) + '*.exe', faAnyFile, SR) = 0 then
  begin
    try
      ExecutablePath := IncludeTrailingPathDelimiter(OrigemPath) + SR.Name;
      VersionStr := GetExecutableVersion(ExecutablePath);
    finally
      FindClose(SR);
    end;
  end
  else
    Exit; // Nenhum arquivo encontrado

  // Verificar se a versão foi extraída corretamente
  if VersionStr = '' then Exit;

  // Criar JSON da mensagem
  JsonData := '{"content": "Server '+ Form1.Servidor11.Caption +' updated to v' + VersionStr + '"}';

  PostData := TStringStream.Create(UTF8Encode(JsonData));
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição
    HTTP.Post(WebhookURL, PostData);
  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;

procedure SendMessageDiscordExeUS2;
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData, OrigemPath, ExecutablePath, VersionStr: string;
  SR: TSearchRec;
begin
  // Ler o WebhookURL do arquivo INI
  WebhookURL := GetIniValue('UpdateDayz', 'webhookinfodayz', '');
  if WebhookURL = '' then Exit; // Sai se não houver um webhook válido

  // Ler o caminho da origem do arquivo INI
  OrigemPath := GetIniValue('UpdateDayz', 'origem', '');
  if (OrigemPath = '') or (not DirectoryExists(OrigemPath)) then Exit;

  // Procurar pelo arquivo executável no diretório de origem
  if FindFirst(IncludeTrailingPathDelimiter(OrigemPath) + '*.exe', faAnyFile, SR) = 0 then
  begin
    try
      ExecutablePath := IncludeTrailingPathDelimiter(OrigemPath) + SR.Name;
      VersionStr := GetExecutableVersion(ExecutablePath);
    finally
      FindClose(SR);
    end;
  end
  else
    Exit; // Nenhum arquivo encontrado

  // Verificar se a versão foi extraída corretamente
  if VersionStr = '' then Exit;

  // Criar JSON da mensagem
  JsonData := '{"content": "Server '+Form1.Servidor21.Caption +' updated to v' + VersionStr + '"}';

  PostData := TStringStream.Create(UTF8Encode(JsonData));
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição
    HTTP.Post(WebhookURL, PostData);
  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;

procedure SendMessageDiscordExeUS3;
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData, OrigemPath, ExecutablePath, VersionStr: string;
  SR: TSearchRec;
begin
  // Ler o WebhookURL do arquivo INI
  WebhookURL := GetIniValue('UpdateDayz', 'webhookinfodayz', '');
  if WebhookURL = '' then Exit; // Sai se não houver um webhook válido

  // Ler o caminho da origem do arquivo INI
  OrigemPath := GetIniValue('UpdateDayz', 'origem', '');
  if (OrigemPath = '') or (not DirectoryExists(OrigemPath)) then Exit;

  // Procurar pelo arquivo executável no diretório de origem
  if FindFirst(IncludeTrailingPathDelimiter(OrigemPath) + '*.exe', faAnyFile, SR) = 0 then
  begin
    try
      ExecutablePath := IncludeTrailingPathDelimiter(OrigemPath) + SR.Name;
      VersionStr := GetExecutableVersion(ExecutablePath);
    finally
      FindClose(SR);
    end;
  end
  else
    Exit; // Nenhum arquivo encontrado

  // Verificar se a versão foi extraída corretamente
  if VersionStr = '' then Exit;

  // Criar JSON da mensagem
  JsonData := '{"content": "Server '+Form1.Servidor31.Caption+ ' updated to v' + VersionStr + '"}';

  PostData := TStringStream.Create(UTF8Encode(JsonData));
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição
    HTTP.Post(WebhookURL, PostData);
  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;

//Canal3 - AVISOS
procedure SendMessageDiscordExeACS1;
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook1 := GetIniValue('Servidor 1', 'webhookavisos', '');

  // Criar JSON da mensagem
//  JsonData := '{"content": "Atualização do DAYZ concluída. Servidor será iniciado. Bom Jogo!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateDayz', 'mensagemdayz1', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição para cada webhook, se estiver definido
    if Webhook1 <> '' then
      HTTP.Post(Webhook1, PostData);
  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;

procedure SendMessageDiscordExeACS2;
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook2 := GetIniValue('Servidor 2', 'webhookavisos', '');

  // Criar JSON da mensagem
//  JsonData := '{"content": "Atualização do DAYZ concluída. Servidor será iniciado. Bom Jogo!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateDayz', 'mensagemdayz1', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição para cada webhook, se estiver definido
    if Webhook2 <> '' then
      HTTP.Post(Webhook2, PostData);
  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;

procedure SendMessageDiscordExeACS3;
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook3 := GetIniValue('Servidor 3', 'webhookavisos', '');

  // Criar JSON da mensagem
//  JsonData := '{"content": "Atualização do DAYZ concluída. Servidor será iniciado. Bom Jogo!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateDayz', 'mensagemdayz1', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição para cada webhook, se estiver definido
    if Webhook3 <> '' then
      HTTP.Post(Webhook3, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;
//END MESSAGE DISC DAYZ.exe



//ENVIA MENSAGEM PARA CANAL NO DISCORD INFORMANDO SOBRE ATT DE MOD
//UNITNECESSÁRIO: IdHTTP, IdSSLOpenSSL, IdGlobal
//Canal1 - AVISOS
procedure SendMessageDiscordModAS1;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook1 := GetIniValue('Servidor 1', 'webhookavisos', '');

  // Criar JSON da mensagem
//  JsonData := '{"content": "ATENÇÃO: Atualização de MOD disponível. Servidor irá desligar em 3 minutos!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateMod', 'mensagemmod', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar mensagem para cada webhook configurado
    if Webhook1 <> '' then IdHTTP.Post(Webhook1, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;

procedure SendMessageDiscordModAS2;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook2 := GetIniValue('Servidor 2', 'webhookavisos', '');


  // Criar JSON da mensagem
//  JsonData := '{"content": "ATENÇÃO: Atualização de MOD disponível. Servidor irá desligar em 3 minutos!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateMod', 'mensagemmod', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar mensagem para cada webhook configurado
    if Webhook2 <> '' then IdHTTP.Post(Webhook2, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;

procedure SendMessageDiscordModAS3;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook3 := GetIniValue('Servidor 3', 'webhookavisos', '');

  // Criar JSON da mensagem
//  JsonData := '{"content": "ATENÇÃO: Atualização de MOD disponível. Servidor irá desligar em 3 minutos!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateMod', 'mensagemmod', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar mensagem para cada webhook configurado
    if Webhook3 <> '' then IdHTTP.Post(Webhook3, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;

//Canal2 - UPDATE MOD
procedure SendMessageDiscordModUS1(ModName: string);
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData: string;
begin
  // Lendo o webhook do arquivo INI
  WebhookURL := GetIniValue('UpdateMod', 'webhookinfomod', '');

  // Verifica se o webhook está configurado
  if WebhookURL = '' then Exit;

  // Criar JSON com a mensagem
//  JsonData := '{"content": "**Atualização '+Form1.Servidor11.Caption+'**\nMod atualizado: ' + ModName + '\n=>End"}';
  JsonData := '{"content": "**Atualização '+StringReplace(Form1.Servidor11.Caption, '&', '', [rfReplaceAll])+'**\nMod atualizado: ' + ModName + '\n=>End"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar os componentes
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição
    HTTP.Post(WebhookURL, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;

procedure SendMessageDiscordModUS2(ModName: string);
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData: string;
begin
  // Lendo o webhook do arquivo INI
  WebhookURL := GetIniValue('UpdateMod', 'webhookinfomod', '');

  // Verifica se o webhook está configurado
  if WebhookURL = '' then Exit;

  // Criar JSON com a mensagem
  //JsonData := '{"content": "**Atualização '+Form1.Servidor21.Caption+'**\nMod atualizado: ' + ModName + '\n=>End"}';
  JsonData := '{"content": "**Atualização '+StringReplace(Form1.Servidor21.Caption, '&', '', [rfReplaceAll])+'**\nMod atualizado: ' + ModName + '\n=>End"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar os componentes
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição
    HTTP.Post(WebhookURL, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;

procedure SendMessageDiscordModUS3(ModName: string);
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  WebhookURL, JsonData: string;
begin
  // Lendo o webhook do arquivo INI
  WebhookURL := GetIniValue('UpdateMod', 'webhookinfomod', '');

  // Verifica se o webhook está configurado
  if WebhookURL = '' then Exit;

  // Criar JSON com a mensagem
  //JsonData := '{"content": "**Atualização '+Form1.Servidor31.Caption+'**\nMod atualizado: ' + ModName + '\n=>End"}';
  JsonData := '{"content": "**Atualização '+StringReplace(Form1.Servidor31.Caption, '&', '', [rfReplaceAll])+'**\nMod atualizado: ' + ModName + '\n=>End"}';  
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar os componentes
  HTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Configuração do SSL
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmUnassigned;
    HTTP.IOHandler := SSLHandler;

    // Cabeçalhos HTTP
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.Accept := 'application/json';
    HTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar requisição
    HTTP.Post(WebhookURL, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSLHandler.Free;
  HTTP.Free;
end;

//Canal3
procedure SendMessageDiscordModCS1;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook1 := GetIniValue('Servidor 1', 'webhookavisos', '');

  // Criar JSON da mensagem
//  JsonData := '{"content": "Atualização de MOD concluída. Servidor será iniciado. Bom Jogo!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateMod', 'mensagemmod1', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar mensagem para cada webhook configurado
    if Webhook1 <> '' then IdHTTP.Post(Webhook1, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;

procedure SendMessageDiscordModCS2;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook2 := GetIniValue('Servidor 2', 'webhookavisos', '');


  // Criar JSON da mensagem
//  JsonData := '{"content": "Atualização de MOD concluída. Servidor será iniciado. Bom Jogo!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateMod', 'mensagemmod1', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar mensagem para cada webhook configurado
    if Webhook2 <> '' then IdHTTP.Post(Webhook2, PostData);


  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;

procedure SendMessageDiscordModCS3;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  PostData: TStringStream;
  JsonData, Webhook1, Webhook2, Webhook3: string;
begin
  // Ler os Webhooks do arquivo INI
  Webhook3 := GetIniValue('Servidor 3', 'webhookavisos', '');

  // Criar JSON da mensagem
//  JsonData := '{"content": "Atualização de MOD concluída. Servidor será iniciado. Bom Jogo!"}';
  JsonData := '{"content": "' + StringReplace(GetIniValue('UpdateMod', 'mensagemmod1', ''), '"', '\"', [rfReplaceAll]) + '"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));

  // Inicializar componentes
  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Enviar mensagem para cada webhook configurado
    if Webhook3 <> '' then IdHTTP.Post(Webhook3, PostData);

  except
    on E: Exception do
      // Tratar erro, se necessário
  end;

  // Liberar memória
  PostData.Free;
  SSL.Free;
  IdHTTP.Free;
end;

//COMPARA ARQUIVOS PARA VERIFICAR SE HÁ ATT DE MOD
function ObterCaminhoDeOrigemDoIni: string;
var
  Ini: TIniFile;
  ConfigPath: string;
begin
  Result := '';
  try
    // Caminho do arquivo INI na pasta Config
    ConfigPath := ExtractFilePath(Application.ExeName) + 'Config\config.ini';

    // Verifica se o arquivo INI existe
    if FileExists(ConfigPath) then
    begin
      // Abre o arquivo INI
      Ini := TIniFile.Create(ConfigPath);
      try
        // Lê o valor da chave "origem" na seção "UpdateMod"
        Result := Ini.ReadString('UpdateMod', 'origem', '');
      finally
        Ini.Free;
      end;
    end
    else
    begin
      Result := 'Arquivo INI não encontrado: ' + ConfigPath;
    end;
  except
    on E: Exception do
      Result := 'Erro ao ler o arquivo INI: ' + E.Message;
  end;
end;

function ObterDataMaisRecenteDaPasta(const Diretorio: string): string;
var
  SR: TSearchRec;
  DataMaisRecente: TDateTime;
  DataPasta: TDateTime;
begin
  Result := '';
  DataMaisRecente := 0;

  if DirectoryExists(Diretorio) then
  begin
    if FindFirst(Diretorio + '\*', faDirectory, SR) = 0 then
    begin
      repeat
        if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          DataPasta := FileDateToDateTime(SR.Time);
          if DataPasta > DataMaisRecente then
            DataMaisRecente := DataPasta;
        end;
      until FindNext(SR) <> 0;
      FindClose(SR);
    end
    else
    begin
      Result := 'Erro ao procurar no diretório: ' + Diretorio;
      Exit;
    end;
  end
  else
  begin
    Result := 'Diretório não encontrado: ' + Diretorio;
    Exit;
  end;

  if DataMaisRecente > 0 then
    Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', DataMaisRecente)
  else
    Result := 'Nenhuma pasta encontrada no diretório.';
end;

procedure ExibirDataDaPastaMaisRecente;
var
  Diretorio: string;
  DataPasta: string;
begin
  // Lê o caminho do diretório a partir do arquivo INI
  Diretorio := ObterCaminhoDeOrigemDoIni;

  // Verifica se o caminho foi encontrado ou ocorreu algum erro
  if (Diretorio = '') or (Pos('Erro', Diretorio) > 0) then
  begin
    //ShowMessage('Erro ao obter o caminho do diretório a partir do INI: ' + Diretorio);
    Exit;
  end;

  // Exibe a data da pasta mais recente ou uma mensagem de erro
  DataPasta := ObterDataMaisRecenteDaPasta(Diretorio);
  //ShowMessage(DataPasta);
end;


//AGORA COMPARA
function ObterDataPastaMaisRecenteOrigem(const Diretorio: string): TDateTime;
var
  SR: TSearchRec;
  DataMaisRecente: TDateTime;
  DataPasta: TDateTime;
begin
  Result := 0;
  DataMaisRecente := 0;

  if DirectoryExists(Diretorio) then
  begin
    if FindFirst(Diretorio + '\*', faDirectory, SR) = 0 then
    begin
      repeat
        if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          DataPasta := FileDateToDateTime(SR.Time);
          if DataPasta > DataMaisRecente then
            DataMaisRecente := DataPasta;
        end;
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;
  end;

  Result := DataMaisRecente;
end;

function ExtrairDataDoNomeDoArquivo(const NomeArquivo: string): TDateTime;
var
  DataStr, HoraStr: string;
  Ano, Mes, Dia, Hora, Minuto, Segundo: Word;
begin
  try
    // Supondo que o formato do nome do arquivo seja: 'YYYY-MM-DD_HH-MM-SS.txt'
    DataStr := Copy(NomeArquivo, 1, 10);  // 'YYYY-MM-DD'
    HoraStr := Copy(NomeArquivo, 12, 8);  // 'HH-MM-SS'

    // Extraímos a data
    Ano := StrToInt(Copy(DataStr, 1, 4));  // Ano
    Mes := StrToInt(Copy(DataStr, 6, 2));  // Mês
    Dia := StrToInt(Copy(DataStr, 9, 2));  // Dia

    // Extraímos a hora
    Hora := StrToInt(Copy(HoraStr, 1, 2));  // Hora
    Minuto := StrToInt(Copy(HoraStr, 4, 2));  // Minuto
    Segundo := StrToInt(Copy(HoraStr, 7, 2));  // Segundo

    // Retorna o TDateTime combinando data e hora
    Result := EncodeDate(Ano, Mes, Dia) + EncodeTime(Hora, Minuto, Segundo, 0);
  except
    on E: Exception do
    begin
      // Caso o nome do arquivo não tenha o formato esperado ou erro de conversão
      Result := 0;  // Retorna 0 se houver erro
    end;
  end;
end;

function ObterNomeArquivoMaisRecente(const Diretorio: string): string;
var
  SearchRec: TSearchRec;
  NomeArquivoMaisRecente: string;
  DataMaisRecente, DataArquivoAtual: TDateTime;
begin
  Result := '';
  DataMaisRecente := 0;  // Inicializa com uma data inválida
  if FindFirst(Diretorio + '*.txt', faAnyFile, SearchRec) = 0 then
  begin
    repeat
      if (SearchRec.Attr and faDirectory = 0) then  // Verifica se não é diretório
      begin
        // Extraímos a data do nome do arquivo
        DataArquivoAtual := ExtrairDataDoNomeDoArquivo(SearchRec.Name);

        if DataArquivoAtual > DataMaisRecente then
        begin
          DataMaisRecente := DataArquivoAtual;
          NomeArquivoMaisRecente := SearchRec.Name;
        end;
      end;
    until FindNext(SearchRec) <> 0;
    FindClose(SearchRec);
  end;
  Result := NomeArquivoMaisRecente;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  // Ativa/desativa TTimer MonMod e MonDayz
  if CheckBox3.Checked then
  begin
    MonMod.Enabled := True;
    MonDayz.Enabled := True;
  end
  else
  begin
    MonMod.Enabled := False;
    MonDayz.Enabled := False;
  end;

  //salva escolha no registro
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', True) then
    begin
      Reg.WriteBool('MonAtt', CheckBox3.Checked);
    end;
  finally
    Reg.Free;
  end;

end;

procedure TForm1.CheckBox4Click(Sender: TObject);
var
  Reg: TRegistry;
  PastaBase, PastaMod, CaminhoMeta: string;
  Pastas: TArray<string>;
  i: Integer;
  EncontrouMod: Boolean;
  OnClickBackup: TNotifyEvent;
begin
  // Caminho base dos mods
  PastaBase := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)),
              'Steamcmd\steamapps\workshop\content\221100');

  EncontrouMod := False;

  // Verifica se o diretório existe
  if TDirectory.Exists(PastaBase) then
  begin
    Pastas := TDirectory.GetDirectories(PastaBase);
    for i := 0 to High(Pastas) do
    begin
      PastaMod := Pastas[i];
      CaminhoMeta := TPath.Combine(PastaMod, 'meta.cpp');

      if TFile.Exists(CaminhoMeta) then
      begin
        EncontrouMod := True;
        Break;
      end;
    end;
  end;

  // Se não encontrou nenhum mod com meta.cpp
  if not EncontrouMod then
  begin
    MessageDlg('Nenhum mod encontrado para monitoramento. Verifique!', mtWarning, [mbOK], 0);

    // Evita disparar novamente o evento ao desmarcar
    OnClickBackup := CheckBox4.OnClick;
    CheckBox4.OnClick := nil;
    CheckBox4.Checked := False;
    CheckBox4.OnClick := OnClickBackup;

    Exit;
  end;

  //salva escolha no registro
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\SOFTWARE\HFManager\Config', True) then
    begin
      Reg.WriteBool('Monsteamcmd', CheckBox4.Checked);
    end;
  finally
    Reg.Free;
  end;
end;

//INICIO PROCESSO ATUALIZACAO MOD
//COPIA ARQUIVOS DOS MOD ORIGEM PARA DESTINO ATUALIZANDO ASSIM OS MOD DESTINO
function LerPublishedID(const Pasta: string): string;
var
  ArquivoMeta: TStringList;
  Linha: string;
  Posicao: Integer;
begin
  Result := '';
  ArquivoMeta := TStringList.Create;
  try
    if FileExists(Pasta + '\meta.cpp') then
    begin
      ArquivoMeta.LoadFromFile(Pasta + '\meta.cpp');
      for Posicao := 0 to ArquivoMeta.Count - 1 do
      begin
        Linha := ArquivoMeta[Posicao]; // Pegamos a linha atual do arquivo

        if Pos('publishedid', Linha) > 0 then
        begin
          Result := Trim(StringReplace(Linha, 'publishedid =', '', [rfReplaceAll]));
          Result := StringReplace(Result, '"', '', [rfReplaceAll]); // Remove aspas
          Result := StringReplace(Result, ';', '', [rfReplaceAll]); // Remove ponto e vírgula
          Break;
        end;
      end;
    end;
  finally
    ArquivoMeta.Free;
  end;
end;

procedure ListarPastas(const Diretorio: string; Lista: TStringList);
var
  SR: TSearchRec;
begin
  if FindFirst(Diretorio + '\*', faDirectory, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory <> 0) and (SR.Name <> '.') and (SR.Name <> '..') then
      begin
        Lista.Add(Diretorio + '\' + SR.Name); // Adiciona a pasta completa à lista
        ListarPastas(Diretorio + '\' + SR.Name, Lista); // Chamada recursiva para subpastas
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

function DataArquivoMaisRecente(const Pasta: string): TDateTime;
var
  SR: TSearchRec;
  DataMaisRecente: TDateTime;
begin
  DataMaisRecente := 0;
  if FindFirst(Pasta + '\*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory = 0) then
      begin
        if FileDateToDateTime(SR.Time) > DataMaisRecente then
          DataMaisRecente := FileDateToDateTime(SR.Time);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
  Result := DataMaisRecente;
end;

procedure CopiarArquivosMaisNovos(const Origem, Destino: string);
var
  SR: TSearchRec;
  OrigemArquivo, DestinoArquivo: string;
begin
  if FindFirst(Origem + '\*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory = 0) then
      begin
        OrigemArquivo := Origem + '\' + SR.Name;
        DestinoArquivo := Destino + '\' + SR.Name;

        // Verifica se o arquivo de destino existe
        if FileExists(DestinoArquivo) then
        begin
          // Copia apenas se o arquivo de origem for mais recente
          if FileDateToDateTime(SR.Time) > FileDateToDateTime(FileAge(DestinoArquivo)) then
          begin
            CopyFile(PChar(OrigemArquivo), PChar(DestinoArquivo), False);
          end;
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure DeleteDirectoryContents(const Dir: string);
var
  SR: TSearchRec;
  FilePath: string;
begin
  if FindFirst(Dir + '\*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Name <> '.') and (SR.Name <> '..') then
      begin
        FilePath := Dir + '\' + SR.Name;

        if (SR.Attr and faDirectory) <> 0 then
          DeleteDirectoryContents(FilePath)  // Apaga subpastas primeiro
        else
          DeleteFile(FilePath);  // Apaga arquivos
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure CopiarPastaCompleta(const Origem, Destino: string);
var
  F: TSearchRec;
begin
  if FindFirst(Origem + '\*', faAnyFile, F) = 0 then
  begin
    repeat
      if (F.Name <> '.') and (F.Name <> '..') then
      begin
        if (F.Attr and faDirectory) <> 0 then
        begin
          if not DirectoryExists(Destino + '\' + F.Name) then
            CreateDir(Destino + '\' + F.Name);

          CopiarPastaCompleta(Origem + '\' + F.Name, Destino + '\' + F.Name);
        end
        else
          CopyFile(PChar(Origem + '\' + F.Name), PChar(Destino + '\' + F.Name), False);
      end;
    until FindNext(F) <> 0;
    FindClose(F);
  end;
end;

//TIMER
procedure ListarArquivos(const Diretorio, Mascara: string; Lista: TStrings);
var
  SR: TSearchRec;
begin
  Lista.Clear;
  if FindFirst(IncludeTrailingPathDelimiter(Diretorio) + Mascara, faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) = 0 then
        Lista.Add(IncludeTrailingPathDelimiter(Diretorio) + SR.Name);
    until FindNext(SR) <> 0;
    SysUtils.FindClose(SR);
  end;
end;

//TTIMER MONMOD
//verifica se mod esta no bat
function TForm1.ModUsadoNoBat(ModName: string; ServidorIndex: Integer): Boolean;
var
  Ini: TIniFile;
  BatPath, BatContent: string;
  Stream: TStringList;
begin
  Result := False;
  ModName := LowerCase(ModName);
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\config.ini');
  try
    case ServidorIndex of
      0: BatPath := Ini.ReadString('Servidor 1', 'start', '');
      1: BatPath := Ini.ReadString('Servidor 2', 'start', '');
      2: BatPath := Ini.ReadString('Servidor 3', 'start', '');
    else
      Exit;
    end;

    if not FileExists(BatPath) then Exit;

    Stream := TStringList.Create;
    try
      Stream.LoadFromFile(BatPath);
      BatContent := LowerCase(Stream.Text);
      Result := Pos(ModName, BatContent) > 0;
    finally
      Stream.Free;
    end;
  finally
    Ini.Free;
  end;
end;

//Atualiza mod
procedure TForm1.MonModTimer(Sender: TObject);
var
  DiretorioOrigem: string;
  Destinos: array[0..2] of string;
  ListaPastasOrigem, ListaPastasDestino: TStringList;
  I, J, K: Integer;
  PublishedIDOrigem, PublishedIDDestino: string;
  DataOrigem, DataDestino: TDateTime;
  AtualizacaoRealizada: array[0..2] of Boolean;
  ModsAtualizados: array[0..2] of TStringList;
  AlgumaAtualizacao: Boolean;
  IniPath: string; // Tempo para encerrar servidor
  TempoEspera: Integer; // Tempo para encerrar servidor
  IniPath1: string; // Tempo para atualizar arquivos
  TempoEspera1: Integer; // Tempo para atualizar arquivos
  KeysPathOrigem: string;
  ListaKeys: TStringList;
  SearchRec: TSearchRec;
  KeyFile: string;
begin
  AlgumaAtualizacao := False;

  for K := 0 to 2 do
  begin
    AtualizacaoRealizada[K] := False;
    ModsAtualizados[K] := TStringList.Create;
  end;

  with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\config.ini') do
  try
    DiretorioOrigem := ReadString('UpdateMod', 'origem', '');
    Destinos[0] := ReadString('UpdateMod', 'destinoserver1', '');
    Destinos[1] := ReadString('UpdateMod', 'destinoserver2', '');
    Destinos[2] := ReadString('UpdateMod', 'destinoserver3', '');
  finally
    Free;
  end;

  if (DiretorioOrigem = '') or ((Destinos[0] = '') and (Destinos[1] = '') and (Destinos[2] = '')) then
    Exit;

  if not DirectoryExists(DiretorioOrigem) then
    Exit;

  ListaPastasOrigem := TStringList.Create;
  try
    ListarPastas(DiretorioOrigem, ListaPastasOrigem);

    for K := 0 to 2 do
    begin
      if Destinos[K] = '' then Continue;
      if not DirectoryExists(Destinos[K]) then Continue;

      ListaPastasDestino := TStringList.Create;
      try
        ListarPastas(Destinos[K], ListaPastasDestino);
        for I := ListaPastasDestino.Count - 1 downto 0 do
          if not AnsiStartsStr('@', ExtractFileName(ListaPastasDestino[I])) then
            ListaPastasDestino.Delete(I);

        for I := 0 to ListaPastasOrigem.Count - 1 do
        begin
          PublishedIDOrigem := LerPublishedID(ListaPastasOrigem[I]);
          if PublishedIDOrigem = '' then Continue;

          for J := 0 to ListaPastasDestino.Count - 1 do
          begin
            PublishedIDDestino := LerPublishedID(ListaPastasDestino[J]);
            if (PublishedIDOrigem = PublishedIDDestino) and (PublishedIDDestino <> '') then
            begin
              DataOrigem := DataArquivoMaisRecente(ListaPastasOrigem[I]);
              DataDestino := DataArquivoMaisRecente(ListaPastasDestino[J]);

              if DataOrigem > DataDestino then
              begin
                // Primeiro: Envia a mensagem informando que a atualização está disponível
                if ModUsadoNoBat(ExtractFileName(ListaPastasDestino[J]), K) then
                begin
                  // Primeiro: Envia a mensagem informando que a atualização está disponível
                  if not AtualizacaoRealizada[K] then
                  begin
                    case K of
                      0: SendMessageDiscordModAS1;
                      1: SendMessageDiscordModAS2;
                      2: SendMessageDiscordModAS3;
                    end;

                    // Desativa componentes
                    MonMod.Enabled := False;
                    MonDayz.Enabled := False;
                    Restart.Enabled := False;
                    CheckBox3.Checked := False;
                    MonServer.Enabled := False;
                    EncServidor.Enabled := False;

                    // Corrigido: inicializa os caminhos do ini corretamente
                    IniPath := ExtractFilePath(Application.ExeName) + 'Config\parametros.ini';
                    IniPath1 := IniPath;

                    // Tempo para encerrar servidor
                    TempoEspera := GetPrivateProfileInt('PARTIMEMOD', 'encservidormod', 60000, PChar(IniPath));
                    Sleep(TempoEspera);
                    //EncerraServidor;
                    EncerraServidor1(K); // K é o índice do servidor (0, 1 ou 2)

                    // Tempo para atualizar arquivos
                    TempoEspera1 := GetPrivateProfileInt('PARTIMEMOD', 'attarquivomod', 60000, PChar(IniPath1));
                    Sleep(TempoEspera1);

                    AtualizacaoRealizada[K] := True;
                  end;
                end
                else
                begin
                  // Apenas loga que o mod foi atualizado sem reiniciar servidor
                  //Log('Mod atualizado sem precisar parar servidor: ' + ExtractFileName(ListaPastasDestino[J]));
                  case K of
                    0: SendMessageDiscordModUS1(ExtractFileName(ListaPastasDestino[J]));
                    1: SendMessageDiscordModUS2(ExtractFileName(ListaPastasDestino[J]));
                    2: SendMessageDiscordModUS3(ExtractFileName(ListaPastasDestino[J]));
                  end;
                end;

                // Atualiza o mod
                DeleteDirectoryContents(ListaPastasDestino[J]);
                CopiarPastaCompleta(ListaPastasOrigem[I], ListaPastasDestino[J]);
                ModsAtualizados[K].Add(ExtractFileName(ListaPastasDestino[J]));

                // Agora, copia a chave (.bikey) para o servidor
                KeysPathOrigem := IncludeTrailingPathDelimiter(ListaPastasOrigem[I]) + 'Keys';
                if DirectoryExists(KeysPathOrigem) then
                begin
                  ListaKeys := TStringList.Create;
                  try
                    if FindFirst(KeysPathOrigem + '\*.bikey', faAnyFile, SearchRec) = 0 then
                    begin
                      repeat
                        // Verifica se é um arquivo (não diretório)
                        if (SearchRec.Attr and faDirectory) = 0 then
                        begin
                          KeyFile := IncludeTrailingPathDelimiter(KeysPathOrigem) + SearchRec.Name;
                          // Copia a chave para o destino
                          CopyFile(PChar(KeyFile), PChar(IncludeTrailingPathDelimiter(Destinos[K]) + 'Keys\' + SearchRec.Name), False);
                        end;
                      until FindNext(SearchRec) <> 0;
                      FindClose(SearchRec);
                    end;
                  finally
                    ListaKeys.Free;
                  end;
                end;

              end;
              Break;
            end;
          end;
        end;
      finally
        ListaPastasDestino.Free;
      end;
    end;

    // Segundo: Após a atualização do mod, envia mensagens sobre o que foi atualizado
    for K := 0 to 2 do
    begin
      if AtualizacaoRealizada[K] then
      begin
        for I := 0 to ModsAtualizados[K].Count - 1 do
        begin
          case K of
            0: SendMessageDiscordModUS1(ModsAtualizados[K][I]);
            1: SendMessageDiscordModUS2(ModsAtualizados[K][I]);
            2: SendMessageDiscordModUS3(ModsAtualizados[K][I]);
          end;
        end;

        // Terceiro: Envia mensagem de confirmação da atualização
        case K of
          0: SendMessageDiscordModCS1;
          1: SendMessageDiscordModCS2;
          2: SendMessageDiscordModCS3;
        end;
      end;
    end;

    // **Reativação dos timers e recursos após a atualização**
    for K := 0 to 2 do
    begin
      if AtualizacaoRealizada[K] then
      begin
        MonMod.Enabled := True;
        MonDayz.Enabled := True;
        Restart.Enabled := True;
        CheckBox3.Checked := True;
        MonServer.Enabled := True;
        EncServidor.Enabled := True;

        if MonServer.Enabled then
        begin
          PauseMon.Caption := 'Pausar Monitoramento';
          link.Visible := True;
          Label1.Visible := False;
        end
        else
        begin
          PauseMon.Caption := 'Retomar Monitoramento';
          link.Visible := False;
          Label1.Visible := True;
        end;
      end;
    end;

  finally
    ListaPastasOrigem.Free;
    for K := 0 to 2 do
      ModsAtualizados[K].Free;
  end;
end;
//END PROCESSO DE MONITORAMENTO DE ATT DE MOD


//RESTART DO SERVIDOR NO HORÁRIO PROGRAMADO
procedure TForm1.RestartTimer(Sender: TObject);
var
  IniFile: TIniFile;
  ConfigPath, Section, RestTime, CurrentTime, ShutdownPath: string;
  i, j: Integer;
begin
  EnviarAvisoRestartDiscord;

  //KOTH
  ProcurarTodasKingOfTheHillS1;
  ProcurarTodasKingOfTheHillS2;
  ProcurarTodasKingOfTheHillS3;

  ConfigPath := ExtractFilePath(Application.ExeName) + 'Config\config.ini';
  if not FileExists(ConfigPath) then Exit;

  IniFile := TIniFile.Create(ConfigPath);
  try
    CurrentTime := FormatDateTime('hh:nn', Now);

    for i := 1 to 3 do
    begin
      Section := 'Servidor ' + IntToStr(i);

      for j := 1 to 4 do
      begin
        RestTime := Trim(IniFile.ReadString(Section, 'rest' + IntToStr(j), ''));
        
        if (RestTime <> '') and (RestTime = CurrentTime) then
        begin
          // Obtendo o caminho do comando de desligamento direto do INI
          ShutdownPath := Trim(IniFile.ReadString(Section, 'Shutdown', ''));

          if (ShutdownPath <> '') and (ShellExecute(0, 'open', PChar(ShutdownPath), nil, nil, SW_SHOWNORMAL) <= 32) then
            //ShowMessage(Format('Falha ao encerrar o servidor %d', [i]));

          Break; // Interrompe o loop interno para evitar múltiplas execuções
        end;
      end;
    end;
  finally
    IniFile.Free;
  end;
end;

//ATUALIZAR EXECUTAVEL
//VERIFICA ARQUIVOS DO MPMISSION QUANDO HOUVER ATT DO DAYZ
procedure EnviarArquivosAtualizados(const Webhook, Titulo, PastaBase: string; const DataReferencia: TDateTime; IdHTTP: TIdHTTP);
var
  PostData: TStringStream;
  JsonData, FilePath, NomeLocal: string;
  SR: TSearchRec;
  SubPastas: array[0..2] of string;
  NomesLocais: array[0..2] of string;
  i: Integer;
  DataArquivo: TDateTime;
  ArquivosEncontrados: Boolean;
  VersaoDayZ: string;
begin
  ArquivosEncontrados := False;

  NomesLocais[0] := '[raiz]';
  NomesLocais[1] := '[db]';
  NomesLocais[2] := '[env]';

  // Envia o cabeçalho
  JsonData := '{"content": "' + Titulo + ' - Arquivos com atualização:"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));
  try
    IdHTTP.Post(Webhook, PostData);
  finally
    PostData.Free;
  end;
  Sleep(500);

  // Lista de pastas a verificar: raiz, db e env
  SubPastas[0] := PastaBase;
  SubPastas[1] := IncludeTrailingPathDelimiter(PastaBase) + 'db';
  SubPastas[2] := IncludeTrailingPathDelimiter(PastaBase) + 'env';

  for i := 0 to 2 do
  begin
    if FindFirst(IncludeTrailingPathDelimiter(SubPastas[i]) + '*.*', faAnyFile, SR) = 0 then
    begin
      repeat
        if (SR.Attr and faDirectory) = 0 then
        begin
          FilePath := IncludeTrailingPathDelimiter(SubPastas[i]) + SR.Name;
          DataArquivo := FileDateToDateTime(FileAge(FilePath));

          if SameDate(DataArquivo, DataReferencia) then
          begin
            ArquivosEncontrados := True;
            NomeLocal := NomesLocais[i] + ' ' + SR.Name;

            JsonData := '{"content": "' + StringReplace(NomeLocal, '"', '\"', [rfReplaceAll]) + '"}';
            PostData := TStringStream.Create(UTF8Encode(JsonData));
            try
              IdHTTP.Post(Webhook, PostData);
            finally
              PostData.Free;
            end;
            Sleep(500);
          end;
        end;
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;
  end;

  // Se não encontrou arquivos, envia a mensagem informativa
  if not ArquivosEncontrados then
  begin
    VersaoDayZ := GetIniValue('UpdateDayz', 'versaodayz', 'Versão Desconhecida');
    JsonData := '{"content": "Arquivos da pasta mpmissions não receberam atualizações nesta versão do Dayz"}';
    PostData := TStringStream.Create(UTF8Encode(JsonData));
    try
      IdHTTP.Post(Webhook, PostData);
    finally
      PostData.Free;
    end;
    Sleep(500);
  end;

  // Rodapé
  JsonData := '{"content": "=> End"}';
  PostData := TStringStream.Create(UTF8Encode(JsonData));
  try
    IdHTTP.Post(Webhook, PostData);
  finally
    PostData.Free;
  end;
  Sleep(500);
end;

procedure VerificarAtualizacoesMapasDayZS1;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Webhook1, OrigemExe, PastaCh, PastaLiv, PastaSak: string;
  DataExecutavel: TDateTime;
begin
  // Lê valores do INI
  Webhook1 := GetIniValue('UpdateDayz', 'mensagemdayzadm1', '');
  OrigemExe := IncludeTrailingPathDelimiter(GetIniValue('UpdateDayz', 'origem', '')) + 'DayZServer_x64.exe';
  PastaCh := GetIniValue('UpdateDayz', 'mpmissioncherno', '');
//  PastaLiv := GetIniValue('UpdateDayz', 'mpmissionlivonia', '');
//  PastaSak := GetIniValue('UpdateDayz', 'mpmissionsakhal', '');

  if not FileExists(OrigemExe) then
  begin
    //ShowMessage('Erro: Executável não encontrado em: ' + OrigemExe);
    Exit;
  end;

  DataExecutavel := FileDateToDateTime(FileAge(OrigemExe));

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Verifica cada diretório
    EnviarArquivosAtualizados(Webhook1, 'Chernarus', PastaCh, DataExecutavel, IdHTTP);
//    EnviarArquivosAtualizados(Webhook1, 'Livonia', PastaLiv, DataExecutavel, IdHTTP);
//    EnviarArquivosAtualizados(Webhook1, 'Sakhal', PastaSak, DataExecutavel, IdHTTP);

  finally
    SSL.Free;
    IdHTTP.Free;
  end;
end;

procedure VerificarAtualizacoesMapasDayZS2;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Webhook1, OrigemExe, PastaCh, PastaLiv, PastaSak: string;
  DataExecutavel: TDateTime;
begin
  // Lê valores do INI
  Webhook1 := GetIniValue('UpdateDayz', 'mensagemdayzadm1', '');
  OrigemExe := IncludeTrailingPathDelimiter(GetIniValue('UpdateDayz', 'origem', '')) + 'DayZServer_x64.exe';
//  PastaCh := GetIniValue('UpdateDayz', 'mpmissioncherno', '');
  PastaLiv := GetIniValue('UpdateDayz', 'mpmissionlivonia', '');
//  PastaSak := GetIniValue('UpdateDayz', 'mpmissionsakhal', '');

  if not FileExists(OrigemExe) then
  begin
    //ShowMessage('Erro: Executável não encontrado em: ' + OrigemExe);
    Exit;
  end;

  DataExecutavel := FileDateToDateTime(FileAge(OrigemExe));

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Verifica cada diretório
//    EnviarArquivosAtualizados(Webhook1, 'Chernarus', PastaCh, DataExecutavel, IdHTTP);
    EnviarArquivosAtualizados(Webhook1, 'Livonia', PastaLiv, DataExecutavel, IdHTTP);
//    EnviarArquivosAtualizados(Webhook1, 'Sakhal', PastaSak, DataExecutavel, IdHTTP);

  finally
    SSL.Free;
    IdHTTP.Free;
  end;
end;

procedure VerificarAtualizacoesMapasDayZS3;
var
  IdHTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Webhook1, OrigemExe, PastaCh, PastaLiv, PastaSak: string;
  DataExecutavel: TDateTime;
begin
  // Lê valores do INI
  Webhook1 := GetIniValue('UpdateDayz', 'mensagemdayzadm1', '');
  OrigemExe := IncludeTrailingPathDelimiter(GetIniValue('UpdateDayz', 'origem', '')) + 'DayZServer_x64.exe';
//  PastaCh := GetIniValue('UpdateDayz', 'mpmissioncherno', '');
//  PastaLiv := GetIniValue('UpdateDayz', 'mpmissionlivonia', '');
  PastaSak := GetIniValue('UpdateDayz', 'mpmissionsakhal', '');

  if not FileExists(OrigemExe) then
  begin
    //ShowMessage('Erro: Executável não encontrado em: ' + OrigemExe);
    Exit;
  end;

  DataExecutavel := FileDateToDateTime(FileAge(OrigemExe));

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmUnassigned;
    IdHTTP.IOHandler := SSL;
    IdHTTP.Request.ContentType := 'application/json';
    IdHTTP.Request.Accept := 'application/json';
    IdHTTP.Request.UserAgent := 'Mozilla/5.0';

    // Verifica cada diretório
//    EnviarArquivosAtualizados(Webhook1, 'Chernarus', PastaCh, DataExecutavel, IdHTTP);
//    EnviarArquivosAtualizados(Webhook1, 'Livonia', PastaLiv, DataExecutavel, IdHTTP);
    EnviarArquivosAtualizados(Webhook1, 'Sakhal', PastaSak, DataExecutavel, IdHTTP);

  finally
    SSL.Free;
    IdHTTP.Free;
  end;
end;

//ATT DAYZ PARTE DO EXECUTAVEL
// Atualiza todos os arquivos de uma pasta para outra
procedure AtualizarPasta(Origem, Destino: string);
var
  SR: TSearchRec;
begin
  if not DirectoryExists(Destino) then Exit;

  if FindFirst(Origem + '\*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Name <> '.') and (SR.Name <> '..') then
      begin
        if FileExists(Destino + '\' + SR.Name) then
        begin
          if FileAge(Origem + '\' + SR.Name) > FileAge(Destino + '\' + SR.Name) then
          begin
            CopyFile(PChar(Origem + '\' + SR.Name), PChar(Destino + '\' + SR.Name), False);
          end;
        end
        else
          CopyFile(PChar(Origem + '\' + SR.Name), PChar(Destino + '\' + SR.Name), False);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

// Atualiza todos os arquivos .DLL no mesmo diretório do executável
procedure AtualizarArquivosDLL(Origem, Destino: string);
var
  SR: TSearchRec;
begin
  if FindFirst(Origem + '\*.dll', faAnyFile, SR) = 0 then
  begin
    repeat
      if FileExists(Destino + '\' + SR.Name) then
      begin
        if FileAge(Origem + '\' + SR.Name) > FileAge(Destino + '\' + SR.Name) then
        begin
          CopyFile(PChar(Origem + '\' + SR.Name), PChar(Destino + '\' + SR.Name), False);
        end;
      end
      else
        CopyFile(PChar(Origem + '\' + SR.Name), PChar(Destino + '\' + SR.Name), False);
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure FazerBackupArquivo(const NomeArquivo, DestinoDir, BackupBaseDir: string);
var
  BackupDir, ArquivoDestino, BackupDestino: string;
  DataHoraStr: string;
begin
  DataHoraStr := FormatDateTime('yyyymmdd_hhnnss', Now);
  BackupDir := IncludeTrailingPathDelimiter(BackupBaseDir) + DataHoraStr + '\';
  ForceDirectories(BackupDir);

  ArquivoDestino := IncludeTrailingPathDelimiter(DestinoDir) + NomeArquivo;
  BackupDestino := IncludeTrailingPathDelimiter(BackupDir) + NomeArquivo;

  if FileExists(ArquivoDestino) then
    CopyFile(PChar(ArquivoDestino), PChar(BackupDestino), False);
end;

procedure FazerBackupArquivosAtualizados(const OrigemDir, DestinoDir, BackupBaseDir: string);
var
  SR: TSearchRec;
  ArquivoOrigem, ArquivoDestino: string;
begin
  // Backup do EXE
  ArquivoOrigem := IncludeTrailingPathDelimiter(OrigemDir) + 'DayzServer_x64.exe';
  ArquivoDestino := IncludeTrailingPathDelimiter(DestinoDir) + 'DayzServer_x64.exe';
  if (FileAge(ArquivoOrigem) <> -1) and (FileAge(ArquivoDestino) <> -1) and
     (FileAge(ArquivoOrigem) > FileAge(ArquivoDestino)) then
  begin
    FazerBackupArquivo('DayzServer_x64.exe', DestinoDir, BackupBaseDir);
  end;

  // Backup DLLs atualizados
  if FindFirst(IncludeTrailingPathDelimiter(OrigemDir) + '*.dll', faAnyFile, SR) = 0 then
  begin
    repeat
      ArquivoOrigem := IncludeTrailingPathDelimiter(OrigemDir) + SR.Name;
      ArquivoDestino := IncludeTrailingPathDelimiter(DestinoDir) + SR.Name;
      if (FileExists(ArquivoOrigem)) and (FileExists(ArquivoDestino)) and
         (FileAge(ArquivoOrigem) <> -1) and (FileAge(ArquivoDestino) <> -1) and
         (FileAge(ArquivoOrigem) > FileAge(ArquivoDestino)) then
      begin
        FazerBackupArquivo(SR.Name, DestinoDir, BackupBaseDir);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;

  // Backup .gproj atualizados
  if FindFirst(IncludeTrailingPathDelimiter(OrigemDir) + '*.gproj', faAnyFile, SR) = 0 then
  begin
    repeat
      ArquivoOrigem := IncludeTrailingPathDelimiter(OrigemDir) + SR.Name;
      ArquivoDestino := IncludeTrailingPathDelimiter(DestinoDir) + SR.Name;
      if (FileExists(ArquivoOrigem)) and (FileExists(ArquivoDestino)) and
         (FileAge(ArquivoOrigem) <> -1) and (FileAge(ArquivoDestino) <> -1) and
         (FileAge(ArquivoOrigem) > FileAge(ArquivoDestino)) then
      begin
        FazerBackupArquivo(SR.Name, DestinoDir, BackupBaseDir);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure CopiarArquivosRaizAtualizadosComgproj(const OrigemDir, DestinoDir: string);
var
  SR: TSearchRec;
  OrigemArquivo, DestinoArquivo, Ext: string;
  OrigemHandle: Integer;
  OrigemDateTime: Integer;
begin
  if FindFirst(IncludeTrailingPathDelimiter(OrigemDir) + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr and faDirectory) = 0 then
      begin
        Ext := LowerCase(ExtractFileExt(SR.Name));
        if (Ext = '.exe') or (Ext = '.dll') or (Ext = '.gproj') then
        begin
          OrigemArquivo := IncludeTrailingPathDelimiter(OrigemDir) + SR.Name;
          DestinoArquivo := IncludeTrailingPathDelimiter(DestinoDir) + SR.Name;

          OrigemDateTime := FileAge(OrigemArquivo);

          if (not FileExists(DestinoArquivo)) or
             (FileAge(OrigemArquivo) <> FileAge(DestinoArquivo)) then
          begin
            if CopyFile(PChar(OrigemArquivo), PChar(DestinoArquivo), False) then
            begin
              OrigemHandle := FileOpen(DestinoArquivo, fmOpenWrite or fmShareDenyNone);
              if OrigemHandle > 0 then
              begin
                FileSetDate(OrigemHandle, OrigemDateTime);
                FileClose(OrigemHandle);
              end;
            end;
          end;
        end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

function PrecisaAtualizarServidor(const OrigemDir, DestinoExe: string): Boolean;
var
  SR: TSearchRec;
  DestinoDir, OrigemArquivo, DestinoArquivo: string;
begin
  Result := False;
  DestinoDir := ExtractFilePath(DestinoExe);

  // Verifica .exe
  OrigemArquivo := IncludeTrailingPathDelimiter(OrigemDir) + 'DayzServer_X64.exe';
  if FileExists(OrigemArquivo) and FileExists(DestinoExe) then
  begin
    if FileAge(OrigemArquivo) > FileAge(DestinoExe) then
    begin
      Result := True;
      Exit;
    end;
  end;

  // Verifica .dll
  if FindFirst(IncludeTrailingPathDelimiter(OrigemDir) + '*.dll', faAnyFile, SR) = 0 then
  begin
    repeat
      OrigemArquivo := IncludeTrailingPathDelimiter(OrigemDir) + SR.Name;
      DestinoArquivo := IncludeTrailingPathDelimiter(DestinoDir) + SR.Name;
      if FileExists(OrigemArquivo) and FileExists(DestinoArquivo) then
      begin
        if FileAge(OrigemArquivo) > FileAge(DestinoArquivo) then
        begin
          Result := True;
          FindClose(SR);
          Exit;
        end;
      end
      else
      begin
        // Arquivo não existe no destino, então precisa atualizar
        Result := True;
        FindClose(SR);
        Exit;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;

  // Verifica .gproj
  if FindFirst(IncludeTrailingPathDelimiter(OrigemDir) + '*.gproj', faAnyFile, SR) = 0 then
  begin
    repeat
      OrigemArquivo := IncludeTrailingPathDelimiter(OrigemDir) + SR.Name;
      DestinoArquivo := IncludeTrailingPathDelimiter(DestinoDir) + SR.Name;
      if FileExists(OrigemArquivo) and FileExists(DestinoArquivo) then
      begin
        if FileAge(OrigemArquivo) > FileAge(DestinoArquivo) then
        begin
          Result := True;
          FindClose(SR);
          Exit;
        end;
      end
      else
      begin
        // Arquivo não existe no destino, então precisa atualizar
        Result := True;
        FindClose(SR);
        Exit;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure TForm1.MonDayzTimer(Sender: TObject);
var
  Ini: TIniFile;
  OrigemDir, DestinoExe, DestinoDir: string;
  ServidorDirs: array[1..3] of string;
  ServidorAtualizar: array[1..3] of Boolean;
  i: Integer;
  PrecisaAtualizar: Boolean;
  IniPath, IniPath1: string;
  TempoEspera, TempoEspera1: Integer;
  BackupBaseDir: string;
begin
  Ini := TIniFile.Create('Config\config.ini');
  IniPath := ExtractFilePath(Application.ExeName) + 'Config\parametros.ini';
  IniPath1 := IniPath;

  try
    OrigemDir := IncludeTrailingPathDelimiter(Ini.ReadString('UpdateDayz', 'origem', ''));
    if not DirectoryExists(OrigemDir) then Exit;

    ServidorDirs[1] := Ini.ReadString('Servidor 1', 'exe', '');
    ServidorDirs[2] := Ini.ReadString('Servidor 2', 'exe', '');
    ServidorDirs[3] := Ini.ReadString('Servidor 3', 'exe', '');

    PrecisaAtualizar := False;
    FillChar(ServidorAtualizar, SizeOf(ServidorAtualizar), False);

    // Detectar se precisa atualizar qualquer servidor, checando EXE, DLLs e GPROJ
    for i := 1 to 3 do
    begin
      DestinoExe := ServidorDirs[i];
      if FileExists(DestinoExe) then
      begin
        DestinoDir := ExtractFilePath(DestinoExe);
        // Função para verificar se existe atualização por data (FileAge)
        if (FileAge(OrigemDir + 'DayzServer_x64.exe') <> -1) and
           (FileAge(DestinoExe) <> -1) and
           (FileAge(OrigemDir + 'DayzServer_x64.exe') > FileAge(DestinoExe)) then
        begin
          ServidorAtualizar[i] := True;
          PrecisaAtualizar := True;
          Continue;
        end;

        // Verifica DLLs
        var SR: TSearchRec;
        if FindFirst(OrigemDir + '*.dll', faAnyFile, SR) = 0 then
        begin
          repeat
            if (FileAge(OrigemDir + SR.Name) <> -1) and (FileAge(DestinoDir + SR.Name) <> -1) and
               (FileAge(OrigemDir + SR.Name) > FileAge(DestinoDir + SR.Name)) then
            begin
              ServidorAtualizar[i] := True;
              PrecisaAtualizar := True;
              Break;
            end;
          until FindNext(SR) <> 0;
          FindClose(SR);
        end;

        // Verifica GPROJ
        if not ServidorAtualizar[i] then
        begin
          if FindFirst(OrigemDir + '*.gproj', faAnyFile, SR) = 0 then
          begin
            repeat
              if (FileAge(OrigemDir + SR.Name) <> -1) and (FileAge(DestinoDir + SR.Name) <> -1) and
                 (FileAge(OrigemDir + SR.Name) > FileAge(DestinoDir + SR.Name)) then
              begin
                ServidorAtualizar[i] := True;
                PrecisaAtualizar := True;
                Break;
              end;
            until FindNext(SR) <> 0;
            FindClose(SR);
          end;
        end;
      end;
    end;

    if not PrecisaAtualizar then Exit;

    // Enviar mensagens no Discord - início da atualização
    if ServidorAtualizar[1] then SendMessageDiscordExeAS1;
    if ServidorAtualizar[2] then SendMessageDiscordExeAS2;
    if ServidorAtualizar[3] then SendMessageDiscordExeAS3;

    MonDayz.Enabled := False;
    MonMod.Enabled := False;
    Restart.Enabled := False;
    MonServer.Enabled := False;
    EncServidor.Enabled := False;
    CheckBox3.Enabled := False;

    TempoEspera := GetPrivateProfileInt('PARTIMEDAYZ', 'encservidor', 60000, PChar(IniPath));
    Sleep(TempoEspera);
    Application.ProcessMessages;

    if ServidorAtualizar[1] then shutdowbanov;
    if ServidorAtualizar[2] then shutdowcherno;
    if ServidorAtualizar[3] then shutdowlivonia;

    TempoEspera1 := GetPrivateProfileInt('PARTIMEDAYZ', 'attarquivo', 60000, PChar(IniPath1));
    Sleep(TempoEspera1);
    Application.ProcessMessages;

    // Atualização e backup
    for i := 1 to 3 do
    begin
      if ServidorAtualizar[i] then
      begin
        DestinoExe := ServidorDirs[i];
        DestinoDir := ExtractFilePath(DestinoExe);
        BackupBaseDir := IncludeTrailingPathDelimiter(DestinoDir) + 'zBackupAtt\';

        // Criar backup dos arquivos que serão atualizados
        FazerBackupArquivosAtualizados(OrigemDir, DestinoDir, BackupBaseDir);

        // Atualiza o executável
        if (FileAge(OrigemDir + 'DayzServer_x64.exe') <> -1) and
           (FileAge(DestinoExe) <> -1) and
           (FileAge(OrigemDir + 'DayzServer_x64.exe') > FileAge(DestinoExe)) then
        begin
          CopyFile(PChar(OrigemDir + 'DayzServer_x64.exe'), PChar(DestinoExe), False);
        end;

        // Copia arquivos da raiz: exe, dll, gproj, etc.
        CopiarArquivosRaizAtualizadosComgproj(OrigemDir, DestinoDir);

        // Atualiza pastas principais
        AtualizarPasta(OrigemDir + 'dta', DestinoDir + 'dta');
        AtualizarPasta(OrigemDir + 'addons', DestinoDir + 'addons');
        AtualizarPasta(OrigemDir + 'sakhal\addons', DestinoDir + 'sakhal\addons');

        // Atualiza DLLs
        AtualizarArquivosDLL(OrigemDir, DestinoDir);

        // Envia mensagem no Discord com a nova versão
        case i of
          1: SendMessageDiscordExeUS1;
          2: SendMessageDiscordExeUS2;
          3: SendMessageDiscordExeUS3;
        end;
      end;
    end;

    // Mensagem fim atualização
    if ServidorAtualizar[1] then SendMessageDiscordExeACS1;
    if ServidorAtualizar[2] then SendMessageDiscordExeACS2;
    if ServidorAtualizar[3] then SendMessageDiscordExeACS3;

    MonDayz.Enabled := True;
    MonMod.Enabled := True;
    Restart.Enabled := True;
    MonServer.Enabled := True;
    EncServidor.Enabled := True;
    CheckBox3.Enabled := True;

    if MonServer.Enabled then
    begin
      PauseMon.Caption := 'Pausar Monitoramento';
      link.Visible := True;
      Label1.Visible := False;
    end
    else
    begin
      PauseMon.Caption := 'Retomar Monitoramento';
      link.Visible := False;
      Label1.Visible := True;
    end;

    VerificarAtualizacoesMapasDayZS1;
    VerificarAtualizacoesMapasDayZS2;
    VerificarAtualizacoesMapasDayZS3;

  finally
    Ini.Free;
  end;
end;



procedure TForm1.Update1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform9, form9);
    form9.ShowModal;
  finally
    form9.Free;
  end;
end;

procedure TForm1.CarDestroyedMCK1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tfrmcardestroyed, frmcardestroyed);
    frmcardestroyed.ShowModal;
  finally
    frmcardestroyed.Free;
  end;
end;

procedure TForm1.CarFinder1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform10, form10);
    form10.ShowModal;
  finally
    form10.Free;
  end;
end;

procedure TForm1.KOTH1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform11, form11);
    form11.ShowModal;
  finally
    form11.Free;
  end;
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
//  try
  //  Application.CreateForm(Tform15, form15);
    //form15.ShowModal;
  //finally
    //form15.Free;
  //end;
end;

procedure TForm1.Loginsteam1Click(Sender: TObject);
begin
 try
    Application.CreateForm(Tfrmsteamlogin, frmsteamlogin);
    frmsteamlogin.ShowModal;
  finally
    frmsteamlogin.Free;
  end;
end;

procedure TForm1.ltimasatualizaes1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform15, form15);
    form15.ShowModal;
  finally
    form15.Free;
  end;
end;

procedure TForm1.Servidor12Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform12, form12);
    form12.ShowModal;
  finally
    form12.Free;
  end;
end;

procedure TForm1.Servidor13Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform19, form19);
    form19.ShowModal;
  finally
    form19.Free;
  end;
end;

procedure TForm1.Servidor22Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform13, form13);
    form13.ShowModal;
  finally
    form13.Free;
  end;
end;

procedure TForm1.Servidor23Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform20, form20);
    form20.ShowModal;
  finally
    form20.Free;
  end;
end;

procedure TForm1.Servidor32Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform14, form14);
    form14.ShowModal;
  finally
    form14.Free;
  end;
end;

procedure TForm1.Servidor33Click(Sender: TObject);
begin
 try
    Application.CreateForm(Tform21, form21);
    form21.ShowModal;
  finally
    form21.Free;
  end;
end;

//PROCEDIMENTOS PARA REALIZACAO DO BACKUP LOCAL
//Servidor1
//procedure TForm1.Button2Click(Sender: TObject);
procedure TForm1.BackupLocalS1(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI, PastaDestino, PastaDataHora, PastaPrincipal, CaminhoWinRAR, Origem, NomeArquivo, NomePasta, Parametros: string;
  i: Integer;
  ListaOrigens: TStringList;
  Retorno: HINST;
  MenuItem: TMenuItem;
begin
  CaminhoINI := ExtractFilePath(Application.ExeName) + 'Config\config.ini';

  Ini := TIniFile.Create(CaminhoINI);
  ListaOrigens := TStringList.Create;
  try
    // Obtém o caminho do WinRAR a partir do INI
    CaminhoWinRAR := Ini.ReadString('ParadaBackup', 'S1winrar', '');
    if (CaminhoWinRAR = '') or (not FileExists(CaminhoWinRAR)) then
    begin
      //ShowMessage('Erro: Caminho do WinRAR inválido. Verifique o arquivo config.ini.');
      Exit;
    end;

    // Obtém a pasta principal do backup a partir do submenu Configuracao1 -> Backup1 -> Servidor12
    if (Configuracao1 = nil) or (Diretrios1 = nil) or (Servidor11 = nil) then
    begin
      //ShowMessage('Erro: Menu não encontrado.');
      Exit;
    end;

    PastaPrincipal := Trim(Servidor11.Caption);
    // Remove o caractere "&" do nome da pasta
    PastaPrincipal := StringReplace(PastaPrincipal, '&', '', [rfReplaceAll]);

    if PastaPrincipal = '' then
    begin
      //ShowMessage('Erro: Nome da pasta principal não definido.');
      Exit;
    end;

    // Obtém a pasta de destino
    PastaDestino := Ini.ReadString('ParadaBackup', 'S1Ldestino', '');
    if PastaDestino = '' then
    begin
      //ShowMessage('Erro: Pasta de destino não definida no INI.');
      Exit;
    end;

    // Define a pasta completa com o nome do servidor
    PastaDestino := IncludeTrailingPathDelimiter(PastaDestino) + PastaPrincipal;
    if not ForceDirectories(PastaDestino) then
    begin
      //ShowMessage('Erro ao criar a pasta principal do backup.');
      Exit;
    end;

    // Criar a pasta de backup com DATA_HORA dentro da pasta principal
    PastaDataHora := IncludeTrailingPathDelimiter(PastaDestino) + FormatDateTime('yyyy-mm-dd_hh-nn-ss', Now);
    if not ForceDirectories(PastaDataHora) then
    begin
      //ShowMessage('Erro ao criar a pasta de backup.');
      Exit;
    end;

    // Obtém todas as pastas de origem
    i := 1;
    while True do
    begin
      Origem := Ini.ReadString('ParadaBackup', 'S1Lorigem' + IntToStr(i), '');
      if Origem = '' then Break;
      ListaOrigens.Add(Origem);
      Inc(i);
    end;

    if ListaOrigens.Count = 0 then
    begin
      //ShowMessage('Erro: Nenhuma pasta de origem definida no INI.');
      Exit;
    end;

    // Compactar cada pasta de origem dentro da pasta DATA_HORA mantendo apenas a pasta principal
    for i := 0 to ListaOrigens.Count - 1 do
    begin
      NomePasta := ExtractFileName(ExcludeTrailingPathDelimiter(ListaOrigens[i]));
      NomeArquivo := Format('%s\%s.rar', [PastaDataHora, NomePasta]);

      // Usa `-ep1` para remover diretórios superiores e manter apenas a pasta de origem
      Parametros := Format('a -r -ep2 "%s" "%s"', [NomeArquivo, ListaOrigens[i]]);
      Retorno := ShellExecute(0, 'open', PChar(CaminhoWinRAR), PChar(Parametros), nil, SW_SHOWNORMAL);

      if Retorno <= 32 then
      begin
        //ShowMessage('Erro ao compactar: ' + ListaOrigens[i]);
        Exit;
      end;

      // Aguarda 2 segundos para garantir que o arquivo foi criado antes de continuar
      Sleep(1000);
    end;

    //ShowMessage('Backup concluído com sucesso!');
  finally
    Ini.Free;
    ListaOrigens.Free;
  end;

end;

//Servidor 2
//procedure TForm1.Button3Click(Sender: TObject);
procedure TForm1.BackupLocalS2(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI, PastaDestino, PastaDataHora, PastaPrincipal, CaminhoWinRAR, Origem, NomeArquivo, NomePasta, Parametros: string;
  i: Integer;
  ListaOrigens: TStringList;
  Retorno: HINST;
  MenuItem: TMenuItem;
begin
  CaminhoINI := ExtractFilePath(Application.ExeName) + 'Config\config.ini';

  Ini := TIniFile.Create(CaminhoINI);
  ListaOrigens := TStringList.Create;
  try
    // Obtém o caminho do WinRAR a partir do INI
    CaminhoWinRAR := Ini.ReadString('ParadaBackup', 'S2winrar', '');
    if (CaminhoWinRAR = '') or (not FileExists(CaminhoWinRAR)) then
    begin
      //ShowMessage('Erro: Caminho do WinRAR inválido. Verifique o arquivo config.ini.');
      Exit;
    end;

    // Obtém a pasta principal do backup a partir do submenu Configuracao1 -> Backup1 -> Servidor12
    if (Configuracao1 = nil) or (Diretrios1 = nil) or (Servidor21 = nil) then
    begin
      //ShowMessage('Erro: Menu não encontrado.');
      Exit;
    end;

    PastaPrincipal := Trim(Servidor21.Caption);
    // Remove o caractere "&" do nome da pasta
    PastaPrincipal := StringReplace(PastaPrincipal, '&', '', [rfReplaceAll]);

    if PastaPrincipal = '' then
    begin
      //ShowMessage('Erro: Nome da pasta principal não definido.');
      Exit;
    end;

    // Obtém a pasta de destino
    PastaDestino := Ini.ReadString('ParadaBackup', 'S2Ldestino', '');
    if PastaDestino = '' then
    begin
      //ShowMessage('Erro: Pasta de destino não definida no INI.');
      Exit;
    end;

    // Define a pasta completa com o nome do servidor
    PastaDestino := IncludeTrailingPathDelimiter(PastaDestino) + PastaPrincipal;
    if not ForceDirectories(PastaDestino) then
    begin
      //ShowMessage('Erro ao criar a pasta principal do backup.');
      Exit;
    end;

    // Criar a pasta de backup com DATA_HORA dentro da pasta principal
    PastaDataHora := IncludeTrailingPathDelimiter(PastaDestino) + FormatDateTime('yyyy-mm-dd_hh-nn-ss', Now);
    if not ForceDirectories(PastaDataHora) then
    begin
      //ShowMessage('Erro ao criar a pasta de backup.');
      Exit;
    end;

    // Obtém todas as pastas de origem
    i := 1;
    while True do
    begin
      Origem := Ini.ReadString('ParadaBackup', 'S2Lorigem' + IntToStr(i), '');
      if Origem = '' then Break;
      ListaOrigens.Add(Origem);
      Inc(i);
    end;

    if ListaOrigens.Count = 0 then
    begin
      //ShowMessage('Erro: Nenhuma pasta de origem definida no INI.');
      Exit;
    end;

    // Compactar cada pasta de origem dentro da pasta DATA_HORA mantendo apenas a pasta principal
    for i := 0 to ListaOrigens.Count - 1 do
    begin
      NomePasta := ExtractFileName(ExcludeTrailingPathDelimiter(ListaOrigens[i]));
      NomeArquivo := Format('%s\%s.rar', [PastaDataHora, NomePasta]);

      // Usa `-ep1` para remover diretórios superiores e manter apenas a pasta de origem
      Parametros := Format('a -r -ep2 "%s" "%s"', [NomeArquivo, ListaOrigens[i]]);
      Retorno := ShellExecute(0, 'open', PChar(CaminhoWinRAR), PChar(Parametros), nil, SW_SHOWNORMAL);

      if Retorno <= 32 then
      begin
        //ShowMessage('Erro ao compactar: ' + ListaOrigens[i]);
        Exit;
      end;

      // Aguarda 2 segundos para garantir que o arquivo foi criado antes de continuar
      Sleep(1000);
    end;

    //ShowMessage('Backup concluído com sucesso!');
  finally
    Ini.Free;
    ListaOrigens.Free;
  end;

end;

//Servidor 3
//procedure TForm1.Button4Click(Sender: TObject);
procedure TForm1.BackupLocalS3(Sender: TObject);
var
  Ini: TIniFile;
  CaminhoINI, PastaDestino, PastaDataHora, PastaPrincipal, CaminhoWinRAR, Origem, NomeArquivo, NomePasta, Parametros: string;
  i: Integer;
  ListaOrigens: TStringList;
  Retorno: HINST;
  MenuItem: TMenuItem;
begin
  CaminhoINI := ExtractFilePath(Application.ExeName) + 'Config\config.ini';

  Ini := TIniFile.Create(CaminhoINI);
  ListaOrigens := TStringList.Create;
  try
    // Obtém o caminho do WinRAR a partir do INI
    CaminhoWinRAR := Ini.ReadString('ParadaBackup', 'S3winrar', '');
    if (CaminhoWinRAR = '') or (not FileExists(CaminhoWinRAR)) then
    begin
      //ShowMessage('Erro: Caminho do WinRAR inválido. Verifique o arquivo config.ini.');
      Exit;
    end;

    // Obtém a pasta principal do backup a partir do submenu Configuracao1 -> Backup1 -> Servidor12
    if (Configuracao1 = nil) or (Diretrios1 = nil) or (Servidor31 = nil) then
    begin
      //ShowMessage('Erro: Menu não encontrado.');
      Exit;
    end;

    PastaPrincipal := Trim(Servidor31.Caption);
    // Remove o caractere "&" do nome da pasta
    PastaPrincipal := StringReplace(PastaPrincipal, '&', '', [rfReplaceAll]);

    if PastaPrincipal = '' then
    begin
      //ShowMessage('Erro: Nome da pasta principal não definido.');
      Exit;
    end;

    // Obtém a pasta de destino
    PastaDestino := Ini.ReadString('ParadaBackup', 'S3Ldestino', '');
    if PastaDestino = '' then
    begin
      //ShowMessage('Erro: Pasta de destino não definida no INI.');
      Exit;
    end;

    // Define a pasta completa com o nome do servidor
    PastaDestino := IncludeTrailingPathDelimiter(PastaDestino) + PastaPrincipal;
    if not ForceDirectories(PastaDestino) then
    begin
      //ShowMessage('Erro ao criar a pasta principal do backup.');
      Exit;
    end;

    // Criar a pasta de backup com DATA_HORA dentro da pasta principal
    PastaDataHora := IncludeTrailingPathDelimiter(PastaDestino) + FormatDateTime('yyyy-mm-dd_hh-nn-ss', Now);
    if not ForceDirectories(PastaDataHora) then
    begin
      //ShowMessage('Erro ao criar a pasta de backup.');
      Exit;
    end;

    // Obtém todas as pastas de origem
    i := 1;
    while True do
    begin
      Origem := Ini.ReadString('ParadaBackup', 'S3Lorigem' + IntToStr(i), '');
      if Origem = '' then Break;
      ListaOrigens.Add(Origem);
      Inc(i);
    end;

    if ListaOrigens.Count = 0 then
    begin
      //ShowMessage('Erro: Nenhuma pasta de origem definida no INI.');
      Exit;
    end;

    // Compactar cada pasta de origem dentro da pasta DATA_HORA mantendo apenas a pasta principal
    for i := 0 to ListaOrigens.Count - 1 do
    begin
      NomePasta := ExtractFileName(ExcludeTrailingPathDelimiter(ListaOrigens[i]));
      NomeArquivo := Format('%s\%s.rar', [PastaDataHora, NomePasta]);

      // Usa -ep1 para remover diretórios superiores e manter apenas a pasta de origem
      Parametros := Format('a -r -ep2 "%s" "%s"', [NomeArquivo, ListaOrigens[i]]);
      Retorno := ShellExecute(0, 'open', PChar(CaminhoWinRAR), PChar(Parametros), nil, SW_SHOWNORMAL);


      if Retorno <= 32 then
      begin
        //ShowMessage('Erro ao compactar: ' + ListaOrigens[i]);
        Exit;
      end;

      // Aguarda 2 segundos para garantir que o arquivo foi criado antes de continuar
      Sleep(1000);
    end;

    //ShowMessage('Backup concluído com sucesso!');
  finally
    Ini.Free;
    ListaOrigens.Free;
  end;

end;

//Timer para chamar os backup
procedure TForm1.backuplocalTimer(Sender: TObject);
var
  ini: TIniFile;
  horaDas, horaCom45Minutos: TTime;
  horaDasStr, horaCom45MinutosStr: string;
  TempDateTime: TDateTime;
  IniFilePath: string;
  CaminhoExe: string;
  PodeLogar: Boolean;
begin
  IniFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Config\Config.ini';
  if not FileExists(IniFilePath) then
    Exit;

  ini := TIniFile.Create(IniFilePath);
  try
    horaDasStr := Trim(ini.ReadString('ParadaBackup', 'das', ''));
    if (horaDasStr = '') or (Length(horaDasStr) <> 5) or (horaDasStr[3] <> ':') or
       (not TryStrToTime(horaDasStr, TempDateTime)) then
      Exit;

    horaDas := TimeOf(TempDateTime);

    // Só permite log após 1 minuto do horário 'das'
    PodeLogar := Time >= IncMinute(horaDas, 2); //Inicio reg do log '2'minutos apos hporario chave 'das'
  finally
    ini.Free;
  end;

  if PodeLogar then
    GravarLogTimerBackup('LogBackup', 'Processo iniciado');

  CaminhoExe := LocalizarGoogleDriveExe('C:\Program Files\Google\Drive File Stream');
  if CaminhoExe <> '' then
  begin
    try
      ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config\config.ini');
      try
        ini.WriteString('ParadaBackup', 'GDcaminho', CaminhoExe);
        if PodeLogar then
          GravarLogTimerBackup('LogBackup', 'Caminho do Google Drive localizado e salvo: ' + CaminhoExe);
      finally
        ini.Free;
      end;
    except
      on E: Exception do
        if PodeLogar then
          GravarLogTimerBackup('LogBackup', 'Erro ao salvar caminho do Google Drive: ' + E.Message);
    end;
  end
  else
    if PodeLogar then
      GravarLogTimerBackup('LogBackup', 'Falha ao localizar caminho do Google Drive');

  if not FileExists(IniFilePath) then
  begin
    if PodeLogar then
      GravarLogTimerBackup('LogBackup', 'Arquivo "Config.ini" não encontrado: ' + IniFilePath);
    Exit;
  end;

  ini := TIniFile.Create(IniFilePath);
  try
    horaDasStr := Trim(ini.ReadString('ParadaBackup', 'das', ''));
    if horaDasStr = '' then
    begin
      if PodeLogar then
        GravarLogTimerBackup('LogBackup', 'Parada para Backup não definido');
      Exit;
    end;

    if (Length(horaDasStr) = 5) and (horaDasStr[3] = ':') then
    begin
      if TryStrToTime(horaDasStr, TempDateTime) then
      begin
        horaDas := TimeOf(TempDateTime);
        horaCom45Minutos := EncodeTime(HourOf(IncMinute(horaDas, 3)), MinuteOf(IncMinute(horaDas, 3)), 0, 0);//5 adiciona 3 minutos a hora inicial para iniciar backup
        horaCom45MinutosStr := FormatDateTime('hh:nn', horaCom45Minutos);

        if PodeLogar then
          GravarLogTimerBackup('LogBackup',
            'Parada para backup: ' + FormatDateTime('hh:nn:ss', horaDas) +
            ' | Backup programado para: ' + FormatDateTime('hh:nn:ss', horaCom45Minutos));

        if FormatDateTime('hh:nn', Now) = horaCom45MinutosStr then
        begin
          if PodeLogar then
            GravarLogTimerBackup('LogBackup', 'Condição de horário atingida. Iniciando backups');
          try
            if Trim(ini.ReadString('PARADABACKUP', 'S1Ldestino', '')) <> '' then
            begin
              BackupLocalS1(Self);
              if PodeLogar then
                GravarLogTimerBackup('LogBackup', 'Backup Servidor1 concluído');
            end
            else
              if PodeLogar then
                GravarLogTimerBackup('LogBackup', 'Backup Servidor1 não configurado');

            if Trim(ini.ReadString('PARADABACKUP', 'S2Ldestino', '')) <> '' then
            begin
              BackupLocalS2(Self);
              if PodeLogar then
                GravarLogTimerBackup('LogBackup', 'Backup Servidor2 concluído');
            end
            else
              if PodeLogar then
                GravarLogTimerBackup('LogBackup', 'Backup Servidor2 não configurado');

            if Trim(ini.ReadString('PARADABACKUP', 'S3Ldestino', '')) <> '' then
            begin
              BackupLocalS3(Self);
              if PodeLogar then
                GravarLogTimerBackup('LogBackup', 'Backup Servidor3 concluído');
            end
            else
              if PodeLogar then
                GravarLogTimerBackup('LogBackup', 'Backup Servidor3 não configurado');

            backuplocal.Enabled := False;
            if PodeLogar then
              GravarLogTimerBackup('LogBackup', 'Timer backuplocal desativado');

            startgoogle.Enabled := True;
            if PodeLogar then
              GravarLogTimerBackup('LogBackup', 'Timer startgoogle ativado');
          except
            on E: Exception do
              if PodeLogar then
                GravarLogTimerBackup('LogBackup', 'Erro durante backup: ' + E.Message);
          end;
        end
        else
          if PodeLogar then
            GravarLogTimerBackup('LogBackup', 'Horário atual não corresponde à janela de execução');
      end
      else
        if PodeLogar then
          GravarLogTimerBackup('LogBackup', 'Falha ao converter horário "das": ' + horaDasStr);
    end
    else
      if PodeLogar then
        GravarLogTimerBackup('LogBackup', 'Formato de hora inválido: ' + horaDasStr);
  finally
    ini.Free;
  end;
end;



//=>END


procedure TForm1.Paineldecontrole1Click(Sender: TObject);
begin
  try
    EvSkinPlus1.Active := False;
    Application.CreateForm(Tform16, form16);
    form16.ShowModal;
  finally
    form16.Free;
  end;
end;

procedure TForm1.Parametros1Click(Sender: TObject);
begin
  Servidor13.Caption := Servidor11.Caption ;
  Servidor23.Caption := Servidor21.Caption ;
  Servidor33.Caption := Servidor31.Caption ;

  if label1.Visible = false then
  begin
    PauseMon.Click;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;

  if checkbox3.Checked then
  begin
    checkbox3.Checked := false;
    end
    else
    begin
    //se ja tiver desativado, nao faz nada
  end;
end;

procedure TForm1.CrashLog1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform17, form17);
    form17.ShowModal;
  finally
    form17.Free;
  end;
end;


procedure TForm1.Donate1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tfrmdonate, frmdonate);
    frmdonate.ShowModal;
  finally
    frmdonate.Free;
  end;
end;

procedure TForm1.Serverconsolelog1Click(Sender: TObject);
begin
  try
    Application.CreateForm(Tform18, form18);
    form18.ShowModal;
  finally
    form18.Free;
  end;
end;




end.
