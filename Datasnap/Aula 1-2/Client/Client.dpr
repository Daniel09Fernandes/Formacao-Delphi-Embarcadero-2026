program Client;

uses
  Vcl.Forms,
  uMain.View in 'uMain.View.pas' {FrmMain},
  uPessoa.Model in '..\shared\uPessoa.Model.pas',
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  uBitcoin.Api.Model in '..\shared\uBitcoin.Api.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
