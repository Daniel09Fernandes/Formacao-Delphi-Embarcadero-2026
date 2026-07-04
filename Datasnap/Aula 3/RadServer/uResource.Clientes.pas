unit uResource.Clientes;

// EMS Resource Module

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI, EMS.ResourceTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, EMS.DataSetResource, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  DataSet.Serialize,
  uModel.Clientes,
  Rest.Json;

type
  [ResourceName('Clientes')]
  TClientesResource1 = class(TDataModule)
    FDConnection1: TFDConnection;
    qryClientes: TFDQuery;
    [ResourceSuffix('Cliente')]
    dsClientes: TEMSDataSetResource;

  published

    [EndPointRequestSummary('Cliente', 'ListItems', 'Retrieves list of items', 'application/json', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Cliente', 'GetItem', 'Retrieves item with specified ID', 'application/json', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('{id}')]
    procedure GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Cliente', 'PostItem', 'Creates new item', '', 'application/json')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Body, 'body', 'A new item content', true, TAPIDoc.TPrimitiveType.spObject,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spObject, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(409, 'Item Exist', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure Post(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Cliente', 'PutItem', 'Updates item with specified ID', '', 'application/json')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Body, 'body', 'A item changes', true, TAPIDoc.TPrimitiveType.spObject,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spObject, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('{id}')]
    procedure PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [EndPointRequestSummary('Cliente', 'DeleteItem', 'Deletes item with specified ID', '', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'item', 'A item ID', true, TAPIDoc.TPrimitiveType.spString,
      TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spString, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [EndPointResponseDetails(404, 'Not Found', TAPIDoc.TPrimitiveType.spNull, TAPIDoc.TPrimitiveFormat.None, '', '')]
    [ResourceSuffix('{id}')]
    procedure DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TClientesResource1.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  qryClientes.Open;
  AResponse.Body.SetValue(qryClientes.ToJSONArray, True);
end;

procedure TClientesResource1.GetItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LItem: string;
begin
  LItem := ARequest.Params.Values['id'];

  if LItem.Trim.IsEmpty then
  begin
    AResponse.Body.SetValue(
      TJSONString.Create('{"error": "parametro não encontrado"}'), true);

    Exit;
  end;

  qryClientes.Open();
  qryClientes.Filtered := False;
  try
   // 1 or ( 1=1)
   //Usando o parambyname('id').AsString := 1 or ( 1=1)
   //  ID = "1 or ( 1=1)"
    qryClientes.Filter := ' id = '+LItem;
    qryClientes.Filtered := True;
    AResponse.Body.SetValue(qryClientes.ToJSONObject, True);
  finally
    qryClientes.Filtered := False;
  end;
end;

procedure TClientesResource1.Post(const AContext: TEndpointContext;
    const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  qryClientes.Open();
  var lBody: TBytes;

  if ARequest.Body.TryGetBytes(lBody) then
  begin
    var lBodyUTF8 := TEncoding.UTF8.GetString(lBody);

    var lModel := TJson.JsonToObject<TClientesModel>(lBodyUTF8);
    try
      qryClientes.AppendRecord(
         [lModel.Id, lModel.nome, lModel.idade, lModel.cpfCnpj,
            lModel.fisjur, lModel.endereco, lModel.bairro, lModel.cidade]);
    finally
      lModel.Free;
    end;

    AResponse.Body.SetValue(qryClientes.ToJSONArray(), True);
  end;
end;

procedure TClientesResource1.PutItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  lId: string;
begin
  lId := ARequest.Params.Values['id'];

  qryClientes.Open();

//  if not qryClientes.State in dsEditModes
  if qryClientes.Locate('Id', lId) then
  begin
    var lBody: TBytes;

    if ARequest.Body.TryGetBytes(lBody) then
    begin
      var lBodyUTF8 := TEncoding.UTF8.GetString(lBody);
      qryClientes.MergeFromJSONObject(lBodyUTF8);
    end;
    AResponse.Body.SetValue(qryClientes.ToJSONObject(), True);
  end
  else
    AResponse.Body.SetValue(TJSONString
      .Create('{"error": "registro não encontrado para atualização"}'), True);
end;

procedure TClientesResource1.DeleteItem(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  lId: string;
begin
  lId := ARequest.Params.Values['id'];
  qryClientes.Open();

  if qryClientes.Locate('Id', lId) then
  begin
    qryClientes.Delete;
  end;
   AResponse.Body.SetValue(qryClientes.ToJSONArray(), True);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TClientesResource1));
end;

initialization
  Register;
end.


