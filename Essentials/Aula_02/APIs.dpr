program APIs;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'View.Principal.pas' {FrPrincipal},
  Model.ConsultaQrCode in 'Model.ConsultaQrCode.pas',
  Frame.Edit in 'Frame.Edit.pas' {FrEdit: TFrame},
  Frame.Btn in 'Frame.Btn.pas' {FrBtn: TFrame},
  Model.Pokedex in 'Model.Pokedex.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrPrincipal, FrPrincipal);
  Application.Run;
end.
