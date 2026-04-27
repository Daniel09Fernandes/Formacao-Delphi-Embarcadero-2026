unit View.BuscaPais;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation, FMX.Edit,
  System.Skia, FMX.Skia, Rest.Client, JSON; {System.JSON}

type
  TDadoCep = record
    Cep: string;
    Rua: string;
    Cidade: string;
    Bairro: string;
    Estado: string;
  end;

  TfrHome = class(TForm)
    recBackground: TRectangle;
    shBg: TShadowEffect;
    layTopBar: TLayout;
    crcClose: TCircle;
    crcMinimize: TCircle;
    ListView1: TListView;
    recEditCep: TRectangle;
    edtPesquisaCep: TEdit;
    SKPesquisar: TSkAnimatedImage;
    recEditPesquisar: TRectangle;
    procedure crcCloseClick(Sender: TObject);
    procedure crcMinimizeClick(Sender: TObject);
    procedure recEditPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    const
      URL = 'https://brasilapi.com.br/api/cep/v1/%s';

    function ConsultaApi(const ACep: string): string;
    function PopularRecord(const ADadosCep: string): TDadoCep;
    procedure PopularListView(const ADadosCep: TDadoCep);
  public
    { Public declarations }
  end;

var
  frHome: TfrHome;

implementation

uses
  DmConnection;

{$R *.fmx}

function TfrHome.ConsultaApi(const ACep: string): string;
begin
  var lRestClient := TRestClient.Create(Format(URL, [ACep]));
  var lRestRequest:= TRESTRequest.Create(lRestClient);

  lRestRequest.Client := lRestClient;
  try
    lRestRequest.Execute;

    if lRestRequest.Response.StatusCode <> 200 then
      raise Exception.Create('Deu ruim!');

    Result := lRestRequest.Response.JSONValue.ToString;
  finally
    lRestClient.Free;
  end;
end;

procedure TfrHome.PopularListView(const ADadosCep: TDadoCep);
var Item: TListViewItem;
    Obj : TListItemText;
begin
  ListView1.BeginUpdate;
  try
    Item := ListView1.Items.Add;

    Obj     := TListItemText(Item.Objects.FindDrawable('liCep'));
    Obj.Text:= ADadosCep.Cep;

    Obj     := TListItemText(Item.Objects.FindDrawable('liRua'));
    Obj.Text:= ADadosCep.Rua;

    Obj     := TListItemText(Item.Objects.FindDrawable('liBairro'));
    Obj.Text:= ADadosCep.Bairro;

    Obj     := TListItemText(Item.Objects.FindDrawable('liEstado'));
    Obj.Text:= ADadosCep.Estado;
  finally
    ListView1.EndUpdate;
  end;
end;

function TfrHome.PopularRecord(const ADadosCep: string): TDadoCep;
begin
  var lJsonObject : TJSONObject;

  lJsonObject := TJSONObject.ParseJSONValue(ADadosCep) as TJSONObject;

  Result.Cep    := lJsonObject.GetValue('cep').ToString;
  Result.Rua    := lJsonObject.GetValue('street').ToString;
  Result.Cidade := lJsonObject.GetValue('city').ToString;
  Result.Bairro := lJsonObject.GetValue('neighborhood').ToString;
  Result.Estado := lJsonObject.GetValue('state').ToString;
end;

procedure TfrHome.recEditPesquisarClick(Sender: TObject);
begin
  var DadosCep: TDadoCep := PopularRecord(ConsultaApi(edtPesquisaCep.Text));
  PopularListView(DadosCep);
  DataModule1.InserirDados(DadosCep.Cep, DadosCep.Rua, DadosCep.Cidade, DadosCep.Bairro, DadosCep.Estado);
end;

procedure TfrHome.crcCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrHome.crcMinimizeClick(Sender: TObject);
begin
  Self.WindowState := TWindowState.wsMinimized;
end;

end.
