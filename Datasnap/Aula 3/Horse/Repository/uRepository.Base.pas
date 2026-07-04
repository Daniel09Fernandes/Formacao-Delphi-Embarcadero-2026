unit uRepository.Base;

interface

uses
  Data.DB,
  ADRConn.Model.Interfaces;

type
  TRepositoryBase = class(TInterfacedObject)
   private
     FQuery: IADRQuery;
     FConnection: IADRConnection;

     function GetConection: IADRConnection;
   protected
     function GetQuery(ASQL: string; AIsDML: Boolean): IADRQuery; overload;
     function GetQuery(ASQL: string): TDataSet; overload;
  end;

implementation

{ TRepositoryBase }

function TRepositoryBase.GetConection: IADRConnection;
begin
  if Assigned(FConnection) then
    Exit(FConnection);

  FConnection := CreateConnection;
  FConnection.Params
    .Driver(adrSQLite)
    .Database('CadTemplete.db');
//    .Server('127.0.0.1')
//    .Port(5432)
//    .UserName('postgres')
//    .Password('postgres');

  Result := FConnection.Connect;
end;

function TRepositoryBase.GetQuery(ASQL: string): TDataSet;
begin
  FQuery := CreateQuery(GetConection);
  FQuery.SQL(ASQL);

  Result := FQuery.DataSet;
  FQuery.Open;
end;

function TRepositoryBase.GetQuery(ASQL: string; AIsDML: Boolean): IADRQuery;
begin
  FQuery := CreateQuery(GetConection);
  Result := FQuery;

  Result.SQL(ASQL);

  if AIsDML then
    Result.ExecSQL
  else
    Result.Open
end;

end.
