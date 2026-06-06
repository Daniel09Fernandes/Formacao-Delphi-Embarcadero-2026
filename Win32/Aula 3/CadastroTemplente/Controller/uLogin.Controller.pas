unit uLogin.Controller;

interface

uses
  uLogin.View,
  Classes,
  FMX.Types,
  FMX.Forms,
  SysUtils,
  UITypes,
  uBase.Controller;

type
  TLoginController = class(TControllerBase)
    class function AbrirTelaLogin(AOwer, AParent: TComponent): Boolean;
  end;

implementation

{ TLoginController }

class function TLoginController.AbrirTelaLogin(AOwer,
  AParent: TComponent): Boolean;
begin
  var lView := TFrLogin.Create(AOwer);
  Result := AbrirTela(AParent, TForm(lView));
end;

end.
