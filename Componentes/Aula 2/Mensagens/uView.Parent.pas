unit uView.Parent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TFrParent = class(TForm)
    PnlMove: TPanel;
    PnlSize: TPanel;
    procedure PnlMoveMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PnlSizeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    CONST
      WM_DRAGMOVE = $F012;
      WM_RESIZE = $F001;
  public
    { Public declarations }
  end;

var
  FrParent: TFrParent;

implementation

{$R *.dfm}

procedure TFrParent.PnlMoveMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  PostMessage(PnlMove.Handle, WM_SYSCOMMAND, WM_DRAGMOVE, 0);
end;

procedure TFrParent.PnlSizeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
  PostMessage(PnlSize.Handle, WM_SYSCOMMAND, WM_RESIZE, 0);
end;

end.
