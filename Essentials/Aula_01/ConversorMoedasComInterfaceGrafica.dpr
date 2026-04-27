program ConversorMoedasComInterfaceGrafica;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.InterfaceGrafica.ConversorMoedas in 'View.InterfaceGrafica.ConversorMoedas.pas' {Form1},
  Model.Conversor in 'Model.Conversor.pas',
  Model.ConversorGenerico in 'Model.ConversorGenerico.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
