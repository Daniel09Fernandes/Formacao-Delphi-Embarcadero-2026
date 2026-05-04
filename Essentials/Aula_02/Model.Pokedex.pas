unit Model.Pokedex;

interface

uses SysUtils, StrUtils, Classes, Model.Pokemon;

type
  IPokedex = interface
    ['{243CA956-2F86-4347-BC41-58E05838209B}']

    function ConsultarPokemon(const APokemon: string): TPokemon;
    procedure BuscarFoto(AImg: TStream; const AUrl: string);
  end;

  TPokedex = class(TInterfacedObject, IPokedex)
  Private
    const
      URL = 'https://pokeapi.co/api/v2/';
      URI = 'pokemon/%s';
  Public
    class function New: IPokedex;

    function ConsultarPokemon(const APokemon: string): TPokemon;
    procedure BuscarFoto(AImg: TStream; const AUrl: string);
  end;

implementation

uses
  Rest.Client, REST.Types, REST.Json;

{ TPokedex }

class function TPokedex.New: IPokedex;
begin
  Result := Self.Create;
end;

function TPokedex.ConsultarPokemon(const APokemon: string): TPokemon;
begin
  var lRestClient := TRestClient.Create(Format(URL + URI, [APokemon]));
  var lRestRequest:= TRESTRequest.Create(lRestClient);
  try
    lRestRequest.Client     := lRestClient;
    lRestClient.Accept      := '*/*';
    lRestClient.ContentType := 'application/json';

    lRestRequest.Method     := rmGET;
    lRestRequest.Execute;

    Result := TJson.JsonToObject<TPokemon>(lRestRequest.Response.JSONValue.ToString);
  finally
    lRestClient.Free;
  end;
end;

procedure TPokedex.BuscarFoto(AImg: TStream; const AUrl: string);
begin
  var lRestClient := TRestClient.Create(AUrl);
  var lRestRequest:= TRESTRequest.Create(lRestClient);
  try
    lRestRequest.Client     := lRestClient;
    lRestClient.Accept      := '*/*';
    lRestClient.ContentType := 'application/json';

    lRestRequest.Method     := rmGET;
    lRestRequest.Execute;

    AImg.WriteBuffer(lRestRequest.Response.RawBytes[0], Length(lRestRequest.Response.RawBytes));
  finally
    lRestClient.Free;
  end;
end;

end.
