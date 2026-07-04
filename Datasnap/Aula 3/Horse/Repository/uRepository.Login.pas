unit uRepository.Login;

interface

uses
  uRepository.Base,
  uRepository.Login.Interf;

type
  TRepositoryLogin = class(TRepositoryBase, IRepositoryLogin)
  private

  public
    function Login(AUsername, APassword: string): Boolean;

    class function New: IRepositoryLogin;
  end;

implementation

{ TRepositoryLogin }

uses
  Classes, Sysutils;

function TRepositoryLogin.Login(AUsername, APassword: string): Boolean;
const
  SQL_LOGIN = 'SELECT Id FROM tab_login WHERE username = %s and senha = %s';
begin
  var Sql := Format(SQL_LOGIN, [AUsername.QuotedString, APassword.QuotedString]);
  Result := GetQuery(Sql).RecordCount > 0;
end;

class function TRepositoryLogin.New: IRepositoryLogin;
begin
   Result := TRepositoryLogin.Create;
end;

end.
