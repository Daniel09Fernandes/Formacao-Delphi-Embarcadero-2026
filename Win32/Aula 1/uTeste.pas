unit uTeste;

interface
uses
  uZipHelper;

type
  TTesteHelper = class
  private
  public
    procedure Teste;
  end;


implementation

{ TTesteHelper }

procedure TTesteHelper.Teste;
var
  Str: TMinhaString;
begin
   Str.GetMyName;
end;

end.
