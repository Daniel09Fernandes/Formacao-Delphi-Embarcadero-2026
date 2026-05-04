unit Frame.Edit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects;

type
  TFrEdit = class(TFrame)
    recEditQrCode: TRectangle;
    edt: TEdit;
  private
    function GetText: string;
    procedure SetText(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property Text: string read GetText write SetText;
    //property TextPrompt: string read GetTextPrompt write SetTextPrompt;
  end;

implementation

{$R *.fmx}

{ TFrEdit }

function TFrEdit.GetText: string;
begin
  Result := edt.Text;
end;

procedure TFrEdit.SetText(const Value: string);
begin
  edt.Text := Value;
end;

end.
