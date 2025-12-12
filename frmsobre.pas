unit frmsobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    RichEdit1: TRichEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form2: TForm2;

implementation

uses Unit1;



{$R *.dfm}

procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=(VK_Escape) then
close;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
Form1.Evfocus.ChangeColor := False;
Form1.Evfocus.ChangeFont  := False;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Evfocus.ChangeColor := True;
Form1.Evfocus.ChangeFont  := True;
end;

end.
