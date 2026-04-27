program BuscaPais;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.BuscaPais in 'View.BuscaPais.pas' {frHome},
  DmConnection in 'DmConnection.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrHome, frHome);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
