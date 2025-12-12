unit frmdonate1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, ComCtrls, Vcl.Imaging.pngimage, ShellAPI;

type
  Tfrmdonate = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image2: TImage;
    Image3: TImage;
    Label5: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmdonate: Tfrmdonate;

implementation

uses Unit1;



{$R *.dfm}

procedure Tfrmdonate.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=(VK_Escape) then
close;
end;

procedure Tfrmdonate.Label5Click(Sender: TObject);
begin
ShellExecute(0, 'open', PChar(Label5.Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure Tfrmdonate.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure Tfrmdonate.FormCreate(Sender: TObject);
begin
Form1.Evfocus.ChangeColor := False;
Form1.Evfocus.ChangeFont  := False;
end;

procedure Tfrmdonate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Evfocus.ChangeColor := True;
Form1.Evfocus.ChangeFont  := True;
end;

end.
