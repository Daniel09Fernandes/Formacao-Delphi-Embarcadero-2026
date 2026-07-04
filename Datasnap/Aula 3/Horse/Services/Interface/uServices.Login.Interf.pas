unit uServices.Login.Interf;

interface

type
 IServicesLogin = Interface
   ['{34D84736-B009-446B-92B1-874FF211E2FE}']

   function Login(AUsername, APassword: string): Boolean;
 End;

implementation

end.
