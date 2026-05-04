unit IniTemaPadrao;

interface

uses
  IniFiles, SysUtils;

type
  IIniTemaPadrao = interface
    ['{BE104F68-D2BD-4F94-99AE-172B1056C9BD}']
    function GetTema: string;
    procedure SetTema(const Value: string);

    property Tema: string read GetTema write SetTema;
  end;

  TIniTemaPadrao = class(TInterfacedObject, IIniTemaPadrao)
  Private
    FIni: TIniFile;
    function GetTema: string;
    procedure SetTema(const Value: string);

    const
      NOME    = 'TemaPadrao.ini';
      SECTION = 'TEMA';
      IDENT   = 'padrao';
  Public
    class function New: IIniTemaPadrao;

    constructor Create;
    destructor Destroy;

    property Tema: string read GetTema write SetTema;
  end;

implementation

{ TIniTemaPadrao }


class function TIniTemaPadrao.New: IIniTemaPadrao;
begin
  Result := Self.Create;
end;

constructor TIniTemaPadrao.Create;
begin
  var lPath := ExtractFilePath(ParamStr(0)) + NOME;

  FIni := TIniFile.Create(lPath);
end;

destructor TIniTemaPadrao.Destroy;
begin
  {Apenas de exemplo}
  if Assigned(FIni) then
    FreeAndNil(FIni);
end;

function TIniTemaPadrao.GetTema: string;
begin
  Result := FIni.ReadString(SECTION, IDENT, EmptyStr);
end;

procedure TIniTemaPadrao.SetTema(const Value: string);
begin
  FIni.WriteString(SECTION, IDENT, Value);
end;

end.
