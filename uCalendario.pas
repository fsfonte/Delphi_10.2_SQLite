unit uCalendario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfrmCalendario = class(TForm)
    btFechar: TButton;
    MonthCalendar1: TMonthCalendar;
    procedure btFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCalendario: TfrmCalendario;

implementation

{$R *.dfm}
procedure TfrmCalendario.btFecharClick(Sender: TObject);
begin
  frmCalendario.Close;
end;

procedure TfrmCalendario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmCalendario := Nil;
  Action        := caFree;
end;

procedure TfrmCalendario.FormCreate(Sender: TObject);
begin
  Self.MonthCalendar1.Date := Now;
end;

end.
