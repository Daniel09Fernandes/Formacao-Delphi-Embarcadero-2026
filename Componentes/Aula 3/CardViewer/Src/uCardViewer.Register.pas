unit uCardViewer.Register;

interface

uses
  Classes, SysUtils, uCardViewer.Main;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Meu Componente', [TCardViewer])
end;

end.
