unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    function ConverterRealParaDolar(const AValor: Double): Double;
    function ConverterDolarParaReal(const AValor: string): string;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils, Model.ConversorGenerico;

function TServerMethods1.ConverterDolarParaReal(const AValor: string): string;
begin
  var lConversor:= TConversorGenerico<string>.Create;
  try
    Result := lConversor.ConverterDolarParaReal(AValor);
  finally
    lConversor.Free;
  end;
end;

function TServerMethods1.ConverterRealParaDolar(const AValor: Double): Double;
begin
  var lConversor:= TConversorGenerico<Double>.Create;
  try
    Result := lConversor.ConverterRealParaDolar(AValor);
  finally
    lConversor.Free;
  end;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

