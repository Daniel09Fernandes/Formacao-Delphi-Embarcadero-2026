program DatePickerTeste;

uses
  Vcl.Forms,
  uMain.Testes in 'uMain.Testes.pas' {Form1},
  uPackage.DB.DataPicker in '..\Source\uPackage.DB.DataPicker.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
