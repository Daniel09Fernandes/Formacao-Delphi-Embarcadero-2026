program PrjTeste;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  uCardViewer.Main in '..\CardViewer\Src\uCardViewer.Main.pas',
  uCardViewer.Consts in '..\CardViewer\Src\uCardViewer.Consts.pas',
  uCardViewer.Normalize.Image in '..\CardViewer\Src\uCardViewer.Normalize.Image.pas',
  uCardViewer.Focused.image in '..\CardViewer\Src\uCardViewer.Focused.image.pas' {FrShowImg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
