program ConversorMoedasClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Client.ConversorMoedas in 'View.Client.ConversorMoedas.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
