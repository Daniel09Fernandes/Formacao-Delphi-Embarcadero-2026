unit Model.Procedural;

interface

const
  COTACAO_DOLAR = 4.98;

  function ConverterRealParaDolar(const AValor: Double): Double;

implementation

function ConverterRealParaDolar(const AValor: Double): Double;
begin
  Result := AValor * COTACAO_DOLAR;
end;

end.
