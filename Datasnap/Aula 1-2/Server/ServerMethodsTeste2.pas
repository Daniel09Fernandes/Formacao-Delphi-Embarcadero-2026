unit ServerMethodsTeste2;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter;

type
  TServerMethodsTeste = class(TDSServerModule)
  private
    { Private declarations }
  public
    function Teste: string;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDSServerModule1 }

function TServerMethodsTeste.Teste: string;
begin
  Result := 'Testado';
end;

end.

