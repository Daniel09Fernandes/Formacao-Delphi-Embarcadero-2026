unit uRegister.Panel.Validador;

interface

  procedure Register;

implementation

uses
  Classes, Comp.Panel.Validador;

procedure Register;
begin
  RegisterComponents('Meu Componente', [TPanelValidador]);
end;

end.
