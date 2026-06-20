unit uCalculadora;

interface

type
  ICalculadora = interface
    ['{B38D66DE-7DDB-4443-9F60-1F7BB917C742}']
    function Multiplicacao(A, B: Double): Double;
  end;

  TCalculadora = class(TInterfacedObject, ICalculadora)
    function Multiplicacao(A, B: Double): Double;
  end;

implementation

{ TCalculadora }

function TCalculadora.Multiplicacao(A, B: Double): Double;
begin
  Result := A * B;
end;

end.
