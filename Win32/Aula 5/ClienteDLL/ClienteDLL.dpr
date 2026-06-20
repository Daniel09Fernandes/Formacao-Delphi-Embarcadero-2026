program ClienteDLL;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Winapi.Windows;


type
 ICalculadora = interface
    ['{B38D66DE-7DDB-4443-9F60-1F7BB917C742}']
    function Multiplicacao(A, B: Double): Double;
  end;

var
  Soma: function(A, B: Double): Double; stdcall;
  Calculadora: function(): ICalculadora; stdCall;

  hdll: THandle;
begin
  try
    hdll :=
    LoadLibrary('CalculoDLL.dll');

    @Soma := GetProcAddress(hdll, 'Soma');
    @Calculadora := GetProcAddress(hdll, 'Calculadora');


    var lNum1, lNum2: Double;
    Readln(lNum1);
    Readln(lNum2);
    Writeln('');

    Write('O Resultado da soma: '+ Soma(LNum1, lNum2).ToString);
    Write('O Resultado da Multiplicação: '+
      Calculadora.Multiplicacao(LNum1, lNum2).ToString);

    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
