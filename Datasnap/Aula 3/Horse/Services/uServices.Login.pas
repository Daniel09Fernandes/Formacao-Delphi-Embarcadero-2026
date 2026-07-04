unit uServices.Login;

interface

uses
  uServices.Login.Interf,
  uRepository.Login.Interf,
  uRepository.Login;

type
  TServicesLogin = class(TInterfacedObject, IServicesLogin)
  private

  public
    function Login(AUsername, APassword: string): Boolean;

    class function New: IServicesLogin;
  end;

implementation

{ TServicesLogin }

function TServicesLogin.Login(AUsername, APassword: string): Boolean;
begin
  Result := TRepositoryLogin
    .New
    .Login(AUsername, APassword);
end;

class function TServicesLogin.New: IServicesLogin;
begin
  Result := TServicesLogin.Create;
end;

end.
