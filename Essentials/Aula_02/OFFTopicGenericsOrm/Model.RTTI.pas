unit Model.RTTI;

interface

uses
  System.Rtti, Generics.Collections, FireDAC.Comp.Client, FireDAC.DApt;

{$M+}
type
  RTabela = record
    Nome: string;
  end;

  RCampo = record
    Nome: string;
    Pk,
    AutoInc,
    Ignore: Boolean;
    TypeKind: TTypeKind;

    procedure LimparValores;
  end;

  ListaCampos = TList<RCampo>;

  TRtti<T: class> = class
  private
    FTabela: RTabela;
    FCampos: ListaCampos;
    FSql   : string;

    function GetClassProperties: TArray<TRttiProperty>;
    function GetClassType: TRttiType;
    function RetornaTipoCampo(ATypeKind: TTypeKind): string;
    function RetornaPropriedadeCampo(ACampo: RCampo): string;
  public
    constructor Create;
    destructor Destroy; override;

    procedure BuscarDadosClasse;
    procedure CreateTable;
    procedure Executar(AConnection: TFDConnection);
  end;

implementation

uses
  Model.Attributes, StrUtils, SysUtils;

{ TRtti<T> }

constructor TRtti<T>.Create;
begin
  FCampos := ListaCampos.Create
end;

destructor TRtti<T>.Destroy;
begin
  FreeAndNil(FCampos);
  inherited;
end;

procedure TRtti<T>.CreateTable;
const
   CREATETABLE = ' CREATE TABLE %s ( %s )';
   SEPARADOR   = '<,>';
var
   SQLCampos: string;
begin
  SQLCampos := '';
  for var Campo in FCampos do
  begin
    if Campo.TypeKind <> tkUnknown then
    begin
      SQLCampos := SQLCampos.Replace(SEPARADOR, ', ');
      SQLCampos := SQLCampos + Campo.Nome + ' ' + RetornaTipoCampo(Campo.TypeKind);
      var PropriedadeCampo := RetornaPropriedadeCampo(Campo);
      SQLCampos := Concat(SQLCampos, PropriedadeCampo);

      SQLCampos := Concat(SQLCampos, SEPARADOR);
    end;
  end;

  SQLCampos := SQLCampos.Replace(SEPARADOR, '');

  FSql := Format(CREATETABLE, [FTabela.Nome, SQLCampos]);
end;

procedure TRtti<T>.Executar(AConnection: TFDConnection);
begin
  AConnection.ExecSQL(FSql);
end;

function TRtti<T>.GetClassProperties: TArray<TRttiProperty>;
begin
  var Context: TRttiContext;
  var ClassType := Context.GetType(T);

  Result := ClassType.GetProperties;
end;

function TRtti<T>.GetClassType: TRttiType;
begin
  var Context: TRttiContext;
  Result := Context.GetType(T);
end;

function TRtti<T>.RetornaPropriedadeCampo(ACampo: RCampo): string;
const
  PK      = ' PRIMARY KEY ';
  AUTOINC = ' AUTOINCREMENT ';
begin
  Result := '';

  if ACampo.PK then
    Result := PK;

  if ACampo.AutoInc then
    Result := Result + AUTOINC;
end;

function TRtti<T>.RetornaTipoCampo(ATypeKind: TTypeKind): string;
begin
  Result := '';

  case ATypeKind of
    tkInteger,
    tkEnumeration, tkInt64: Result := ' INTEGER ';
    tkFloat               : Result := ' REAL ';
    tkString, tkLString,
    tkWString, tkUString,
    tkChar, tkWChar       : Result := ' TEXT ';
  end;
end;

procedure TRtti<T>.BuscarDadosClasse;
var AtributoProp: TCustomAttribute;
    Campo : RCampo;
begin
  var Tipo := GetClassType;

  for var Atributo in Tipo.GetAttributes do
  begin
    if Atributo is TTabela then
      FTabela.Nome := TTabela(Atributo).Name;
  end;


  for var Propriedade in Tipo.GetProperties do
  begin
    if not Assigned(Propriedade) then
      Continue;

    var Atributos := Propriedade.GetAttributes;

    if Length(Atributos) > 0 then
    begin
      for AtributoProp in Atributos do
      begin
        if AtributoProp is TIgnore then
          Continue;

        if AtributoProp is TField then
          Campo.Nome := TField(AtributoProp).Name;

        if AtributoProp is TPK then
          Campo.Pk      := True;

        if AtributoProp is TAutoInc then
          Campo.AutoInc      := True;

        Campo.TypeKind:= Propriedade.PropertyType.TypeKind;
      end;
    end;

    FCampos.Add(Campo);
    Campo.LimparValores;
  end;
end;

{ RCampos }

procedure RCampo.LimparValores;
begin
  Nome   := '';
  Pk     := False;
  AutoInc:= False;
  Ignore := False;
  TypeKind := tkUnknown;
end;

end.
