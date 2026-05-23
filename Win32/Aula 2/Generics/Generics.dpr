program Generics;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {GenericCalc},
  uCalculo in 'uCalculo.pas',
  uCalculadoraGenerica in 'uCalculadoraGenerica.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGenericCalc, GenericCalc);
  Application.Run;
end.
