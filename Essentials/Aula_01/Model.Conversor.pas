unit Model.Conversor;

interface

uses
  SysUtils;

type
  TConversor = class
  Private
    const
      COTACAO_DOLAR = 4.98;

    function ValorValido(const AValor: string): Double;
  Public
    function ConverterRealParaDolar(const AValor: Double): Double; overload;
    function ConverterRealParaDolar(const AValor: string): Double; overload;

    function ConverterDolarParaReal(const AValor: Double): Double; overload;
    function ConverterDolarParaReal(const AValor: string): Double; overload;
  end;

implementation

uses
  Math;

{ TConversor }

function TConversor.ConverterRealParaDolar(const AValor: Double): Double;
begin
  Result := RoundTo(AValor * COTACAO_DOLAR, -2);
end;

function TConversor.ConverterRealParaDolar(const AValor: string): Double;
begin
  var Valor := ValorValido(AValor);

  if Valor < 0 then
    Exit(Valor);

  Result := ConverterRealParaDolar(Valor);
end;

function TConversor.ConverterDolarParaReal(const AValor: string): Double;
begin
  var Valor := ValorValido(AValor);

  if Valor < 0 then
    Exit(Valor);

  Result := ConverterDolarParaReal(Valor);
end;

function TConversor.ConverterDolarParaReal(const AValor: Double): Double;
begin
  Result := RoundTo(AValor / COTACAO_DOLAR, -2);
end;

function TConversor.ValorValido(const AValor: string): Double;
begin
  var Output: Double;

  Result := if TryStrToFloat(AValor, Output) then Output else -1;
end;

end.
