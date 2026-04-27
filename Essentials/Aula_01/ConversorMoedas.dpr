program ConversorMoedas;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Model.Procedural in 'Model.Procedural.pas',
  Model.Conversor in 'Model.Conversor.pas';

{const
    SQL_TAL = '''
                SELECT ID, NOME FROM TABELA
                WHERE ID = %s
              ''';}
  const
    COTACAO_DOLAR = 4.98;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }

    while True do
    begin
      Writeln('Informe o valor para conversão: ');
      var lValorConverter: string;
      Readln(lValorConverter);

      var Output : Double;

      //var lValorConvertido := lValorConverter.ToDouble * COTACAO_DOLAR;

      //Antes
      {if TryStrToFloat(lValorConverter, Output) then
        lValorConvertido := Output
      else
        lValorConvertido := -1;}

      var lValorConvertido := if TryStrToFloat(lValorConverter, Output) then Output else -1;

      if lValorConvertido > 0 then
      begin
        lValorConvertido := ConverterRealParaDolar(lValorConvertido);
        Writeln('Valor em dolar é de: ' + lValorConvertido.ToString)
      end
      else
        Writeln('Valor informado é inválido');
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
