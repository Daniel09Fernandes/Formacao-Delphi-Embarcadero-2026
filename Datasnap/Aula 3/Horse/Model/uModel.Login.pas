unit uModel.Login;

interface

uses
  GBSwagger.Model.Attributes;

type
 TModelRequestLogin = class
 private
    FUsername: string;
    FPassword: string;
 public
   [SwagProp('Username')]
   property Username: string read FUsername write FUsername;
   [SwagProp('Password')]
   property Password: string read FPassword write FPassword;
 end;

 TModelResponseLogin = class
 private
    FLoginSuccess: Boolean;
 public
   [SwagProp('LoginSuccess')]
   property LoginSuccess: Boolean read FLoginSuccess write FLoginSuccess;
 end;

implementation

end.
