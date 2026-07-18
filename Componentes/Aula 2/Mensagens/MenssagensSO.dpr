program MenssagensSO;

uses
  Vcl.Forms,
  uView.Main in 'uView.Main.pas' {Form1},
  uView.Parent in 'uView.Parent.pas' {FrParent};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrParent, FrParent);
  Application.Run;
end.
