unit uService.Api.Bitcoin;

interface

uses
  Classes, SysUtils,
  uBitcoin.Api.Model,
  Rest.Client,
  Rest.Types,
  Rest.Json;

Type
  TServicesBitcoinAPI = class(TRESTClient)
  private
  const
    URL_API = 'https://api.blockcypher.com/v1/btc/main/txs/f854aebae95150b379cc1187d848d58225f3c4157fe992bcd166f58bd5063449';
  var
    FRestRequest: TRESTRequest;
  public
    function GetRecordsBitcoins: TBitcoinModel;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TServicesBitcoinAPI }

constructor TServicesBitcoinAPI.Create;
begin
  inherited Create(URL_API);
  Accept := '*/*';
  AcceptCharset := 'utf-8';
  AllowCookies := True;
  FRestRequest := TRESTRequest.Create(Self);
  FRestRequest.Client := Self;
end;

destructor TServicesBitcoinAPI.Destroy;
begin
  FreeAndNil(FRestRequest);
  inherited;
end;

function TServicesBitcoinAPI.GetRecordsBitcoins: TBitcoinModel;
begin
  Result := nil;

  FRestRequest.Execute;
  var lResponse := FRestRequest.Response.JSONText;

  if not lResponse.Trim.IsEmpty then
    Result := TJson.JsonToObject<TBitcoinModel>(lResponse);
end;

end.
