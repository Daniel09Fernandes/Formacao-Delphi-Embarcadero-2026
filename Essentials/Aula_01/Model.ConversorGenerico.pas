unit Model.ConversorGenerico;

interface

uses
  SysUtils, Generics.Collections, Rtti,
  {System.SysUtils, System.Generics.Collections, System.Rtti}
  Model.Conversor;

type
  TConversorGenerico<T> = class
  Private
    FHistorico: TDictionary<string, string>;

    function GetType(const AValor: T): TTypeKind;
    function ParseToString(const AValor: T): string;
    function ParseToDouble(const AValor: T): Double;
  Public
    constructor Create;
    destructor Destroy; override;

    function ConverterRealParaDolar(const AValor: T): T;
    function ConverterDolarParaReal(const AValor: T): T;

    procedure PopulaDicionario(const AKey: string; const AValue: string);

    property Historico: TDictionary<string, string> read FHistorico write FHistorico;
  end;

implementation

{ TConversorGenerico<T> }

constructor TConversorGenerico<T>.Create;
begin
  FHistorico := TDictionary<string, string>.Create;
end;

destructor TConversorGenerico<T>.Destroy;
begin
  if Assigned(FHistorico) then
    FreeAndNil(FHistorico);
  inherited;
end;

function TConversorGenerico<T>.ConverterDolarParaReal(const AValor: T): T;
begin
  var lConversor:= TConversor.Create;
  try
    var Tipo: TTypeKind := GetType(AValor);

    if Tipo not in [tkUString, tkFloat] then
      raise Exception.Create('Tipo inválido');

    if Tipo = tkUString then
      Result := TValue.From<string>(lConversor.ConverterDolarParaReal(ParseToString(AValor)).ToString).AsType<T>
    else
      Result := TValue.From<Double>(lConversor.ConverterDolarParaReal(ParseToDouble(AValor))).AsType<T>;
  finally
    lConversor.Free;
  end;
end;

function TConversorGenerico<T>.ConverterRealParaDolar(const AValor: T): T;
begin
  var lConversor:= TConversor.Create;
  try
    var Tipo: TTypeKind := GetType(AValor);

    if Tipo not in [tkUString, tkFloat] then
      raise Exception.Create('Tipo inválido');

    if Tipo = tkUString then
      Result := TValue.From<string>(lConversor.ConverterRealParaDolar(ParseToString(AValor)).ToString).AsType<T>
    else
      Result := TValue.From<Double>(lConversor.ConverterRealParaDolar(ParseToDouble(AValor))).AsType<T>;
  finally
    lConversor.Free;
  end;
end;

function TConversorGenerico<T>.GetType(const AValor: T): TTypeKind;
begin
  Result := GetTypeKind(AValor);
end;

function TConversorGenerico<T>.ParseToDouble(const AValor: T): Double;
begin
  Result := TValue.From<T>(AValor).AsType<Double>;
end;

function TConversorGenerico<T>.ParseToString(const AValor: T): string;
begin
  Result := TValue.From<T>(AValor).AsType<string>;
end;

procedure TConversorGenerico<T>.PopulaDicionario(const AKey: string;
  const AValue: string);
begin
  FHistorico.AddOrSetValue(AKey, AValue);

  {for var Key in FHistorico.Keys do
  begin

  end;}

  FHistorico.TrimExcess;
end;

end.
