unit View.Client.ConversorMoedas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, REST.Client;

type
  TForm3 = class(TForm)
    Button2: TButton;
    edtValorConverter: TEdit;
    edtValorReal: TEdit;
    edtValorDolar: TEdit;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    const
      URL                 = 'http://localhost:8080/datasnap/rest/TServerMethods1';
      URI_DOLAR_PARA_REAL = '/ConverterDolarParaReal/%s';
      URI_REAL_PARA_DOLAR = '/ConverterRealParaDolar/%s';
  public
    { Public declarations }

    function ConsultarAPI(const AURI: string; const AValue: string): string;
  end;

var
  Form3: TForm3;

implementation

uses
  JSON; {System.Json}

{$R *.fmx}

{ TForm3 }

procedure TForm3.Button2Click(Sender: TObject);
begin
  edtValorDolar.Text := ConsultarAPI(URI_REAL_PARA_DOLAR, edtValorConverter.Text);
  edtValorReal.Text  := ConsultarAPI(URI_DOLAR_PARA_REAL, edtValorConverter.Text);
end;

function TForm3.ConsultarAPI(const AURI, AValue: string): string;
begin
  var lRestClient := TRESTClient.Create(URL + Format(AURI, [AValue]));
  var lRequest    := TRESTRequest.Create(lRestClient);

  lRequest.Client := lRestClient;
  try
     lRequest.Execute;

     Result := lRequest.Response.JSONValue.GetValue<T>('result').Get(0).ToString.Replace('"', EmptyStr);
  finally
    lRestClient.Free;
  end;
end;

end.
