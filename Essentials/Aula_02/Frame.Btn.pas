unit Frame.Btn;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Skia, FMX.Effects, FMX.Objects;

type
  TFrBtn = class(TFrame)
    recBtn: TRectangle;
    shBtn: TShadowEffect;
    sklblBtn: TSkLabel;
  private
    function GetTitulo: string;
    procedure SetTitulo(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property Titulo: string read GetTitulo write SetTitulo;
  end;

implementation

{$R *.fmx}

{ TFrame1 }

function TFrBtn.GetTitulo: string;
begin
  Result := sklblBtn.Text;
end;

procedure TFrBtn.SetTitulo(const Value: string);
begin
  sklblBtn.Text := Value;
end;

end.
