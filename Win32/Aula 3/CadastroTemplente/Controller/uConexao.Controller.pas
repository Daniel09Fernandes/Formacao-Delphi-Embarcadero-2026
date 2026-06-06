unit uConexao.Controller;

interface
uses
  uMapping.RTTI, System.Generics.Collections, Datasnap.DBClient;

type
  TWhereDB = TWhere;
  TParamsWhereDB = TParamWhere;

  TConexaoController<T: class, constructor> = class
    class function GetListObject(AWhere: TWhere = nil): TObjectList<T>;
    class function ObjectListToCds(AList: TObjectList<T>): TClientDataSet;
  end;

implementation

{ TConexaoController<T> }

class function TConexaoController<T>.GetListObject(AWhere: TWhere): TObjectList<T>;
begin
  var lRttiMap := TMappingRTTI<T>.Create;
  try
    Result := lRttiMap.GetListObject(AWhere);
  finally
    lRttiMap.Free;
  end;
end;

class function TConexaoController<T>.ObjectListToCds(
  AList: TObjectList<T>): TClientDataSet;
begin
   var lRttiMap := TMappingRTTI<T>.Create;
  try
    Result := lRttiMap.ObjectListToCds(AList);
  finally
    lRttiMap.Free;
  end;
end;

end.
