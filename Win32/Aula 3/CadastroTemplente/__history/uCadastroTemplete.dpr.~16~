program uCadastroTemplete;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain.View in 'View\uMain.View.pas' {FrMain},
  uDM.Connection in 'ConexaoDB\uDM.Connection.pas' {DMConnection: TDataModule},
  uLogin.View in 'View\uLogin.View.pas' {FrLogin},
  uDBMapping.Attributes in 'ConexaoDB\RTTI\uDBMapping.Attributes.pas',
  uLogin.Model in 'Model\uLogin.Model.pas',
  uMapping.RTTI in 'ConexaoDB\RTTI\uMapping.RTTI.pas',
  uConexao.Controller in 'Controller\uConexao.Controller.pas',
  uDialog in 'Dialog\uDialog.pas' {FrDialog},
  uHelper.Dialog in 'Helpers\uHelper.Dialog.pas',
  uLogin.Controller in 'Controller\uLogin.Controller.pas',
  uBase.Cadastro.View in 'FormBase\uBase.Cadastro.View.pas' {FrCadBase},
  uCliente.Model in 'Model\uCliente.Model.pas',
  uClientes.View in 'View\uClientes.View.pas' {FrCadClientes},
  uClientes.Controller in 'Controller\uClientes.Controller.pas',
  uBase.Controller in 'Controller\uBase.Controller.pas',
  uHelper.Grid in 'Helpers\uHelper.Grid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrMain, FrMain);
  Application.CreateForm(TDMConnection, DMConnection);
  Application.CreateForm(TFrCadBase, FrCadBase);
  Application.Run;
end.
