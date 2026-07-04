unit uRepository.Login.Interf;

interface

type
  IRepositoryLogin = interface
    ['{B3C55B77-493C-450B-B66E-BAC64F62145F}']

    function Login(AUsername, APassword: string): Boolean;
  end;


implementation

end.
