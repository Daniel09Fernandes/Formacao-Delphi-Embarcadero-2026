unit uCalculadoraGenerica;

interface

uses
  SysUtils, Rtti,
  uCalculo;

type
  TGCalcular<P,R> = class
  private
    FTipoOperacao: TOperacao;
    function GetType(AValue: P): TTypeKind;
    function ParserPtoStr(AValue: P): string;
    function ParserPtoFloat(AValue: P): Double;
  public
    function Calcular(AValue1, AValue2: P): R;
    property TipoOperacao: TOperacao read FTipoOperacao write FTipoOperacao;
  end;

implementation

{ TGCalcular<P, R> }

function TGCalcular<P, R>.Calcular(AValue1, AValue2: P): R;
begin
  if (GetType(AValue1) = TTypeKind.tkUString) or
     (GetType(AValue1) = TTypeKind.tkString)
  then
  begin
    Exit(
      TValue.From<Double>(
        TCalcular.Calcular(ParserPtoStr(AValue1),
         ParserPtoStr(AValue2), TipoOperacao)
        ).AsType<R>
      );
  end;

   if (GetType(AValue1) = TTypeKind.tkFloat) then
   begin
     Exit(
       TValue.From<Double>(
          TCalcular.Calcular(ParserPtoFloat(AValue1),
           ParserPtoFloat(AValue2), TipoOperacao)
          ).AsType<R>
       );
   end;
end;

function TGCalcular<P, R>.GetType(AValue: P): TTypeKind;
begin
  Result := GetTypeKind(AValue);
end;

function TGCalcular<P, R>.ParserPtoFloat(AValue: P): Double;
begin
  Result := TValue.From<P>(AValue).AsType<Double>;
end;

function TGCalcular<P, R>.ParserPtoStr(AValue: P): string;
begin
  Result := TValue.From<P>(AValue).AsType<string>;
end;

end.
