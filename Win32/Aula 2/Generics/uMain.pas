unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.NumberBox, Vcl.StdCtrls,
  uCalculo;

type
  TGenericCalc = class(TForm)
    MResult: TMemo;
    EdtNum1: TNumberBox;
    EdtNum2: TNumberBox;
    Button1: TButton;
    RbSoma: TRadioButton;
    RBSub: TRadioButton;
    RbDiv: TRadioButton;
    RbMult: TRadioButton;
    procedure Button1Click(Sender: TObject);
  private
    function GetOperacao: TOperacao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GenericCalc: TGenericCalc;

implementation

{$R *.dfm}
uses
  uCalculadoraGenerica;

procedure TGenericCalc.Button1Click(Sender: TObject);
begin
  var lCalc := TGCalcular<double, double>.Create;
  try
    lCalc.TipoOperacao := GetOperacao;

    MResult.Lines.Add(
      lCalc.Calcular(EdtNum1.Value, EdtNum2.value).ToString
    );
  finally
    lCalc.Free;
  end;
end;

function TGenericCalc.GetOperacao: TOperacao;
begin
  for var I := 0 to ComponentCount -1 do
  begin
    if (Components[i] is TRadioButton) and
       (TRadioButton(Components[i]).Checked) then
    begin
      Result := TOperacao(TRadioButton(Components[i]).Tag);
      break;
    end;
  end;
end;

end.
