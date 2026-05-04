unit Model.ConsultaQrCode;

interface

uses
  SysUtils;

type
  TConsultaQrCode = class
  Private
  Public
    function ConsularQrCode(const AValue: string): TBytes;
  end;

  const URL = 'https://qrcode.tec-it.com/API/QRCode?data=[value]&backcolor=%23ffffff&size=small&quietzone=1&errorcorrection=H';

implementation

uses
  REST.Client;

{ TConsultaQrCode }

function TConsultaQrCode.ConsularQrCode(const AValue: string): TBytes;
begin
  var lRestClient  := TRESTClient.Create(EmptyStr);
  var lRestRequest := TRESTRequest.Create(lRestClient);
  try
    lRestClient.BaseURL := URL.Replace('[value]', AValue);
    lRestRequest.Client := lRestClient;
    lRestRequest.Execute;

    var lRetorno := lRestRequest.Response.RawBytes;

    Result := lRetorno;
  finally
    lRestClient.Free;
  end;
end;

end.
