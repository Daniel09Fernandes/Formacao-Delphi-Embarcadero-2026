unit Model.ConversorMoedaTestes;

interface

uses
  DUnitX.TestFramework, Model.Conversor;

type
  [TestFixture]
  TMyTestObject = class
  private
    FConversor: TConversor;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure ConverteReal;
    [Test]
    procedure ConverteDolar;

    [Test]
    [TestCase('ConverteNegativosReal', '-10, -49.8')]
    procedure ConversaoParametrizada(const AValueConverter: Double; AValueEsperado: Double);
  end;

implementation

uses
  System.SysUtils;

{ TMyTestObject }

procedure TMyTestObject.Setup;
begin
  FConversor := TConversor.Create;
end;

procedure TMyTestObject.TearDown;
begin
  FreeAndNil(FConversor);
end;

procedure TMyTestObject.ConverteReal;
begin
  var Resultado := FConversor.ConverterRealParaDolar(10.0);
  Assert.AreEqual(49.8, Resultado, 0.001);
end;

procedure TMyTestObject.ConverteDolar;
begin
  var Resultado := FConversor.ConverterRealParaDolar(10.0);
  Assert.AreEqual(2.00, Resultado, 0.001);
end;

procedure TMyTestObject.ConversaoParametrizada(const AValueConverter: Double;
  AValueEsperado: Double);
begin
  if AValueConverter < 0 then
    Assert.WillRaise(procedure
                     begin
                      // Chame aqui a função que deve dar erro
                       FConversor.ConverterRealParaDolar(-10);
                     end,
                     nil, //Poderá ser passada uma classe TExcpetion
                     'Valor a converter não poderá ser negativo');
  Assert.AreEqual(AValueEsperado, FConversor.ConverterRealParaDolar(AValueConverter));
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
