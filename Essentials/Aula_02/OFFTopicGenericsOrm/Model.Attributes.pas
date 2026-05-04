unit Model.Attributes;

interface

type
  TTabela = class(TCustomAttribute)
  private
    FName: string;
  public
    property Name: string read FName write FName;

    constructor Create(const AName: string);
  end;

  TField = class(TCustomAttribute)
  private
    FName: string;
  public
    property Name: string read FName write FName;

    constructor Create(const AName: string);
  end;

  TPK = class(TCustomAttribute)
  end;

  TAutoInc = class(TCustomAttribute)
  end;

  TNotNull = class(TCustomAttribute)
  end;

  TIgnore = class(TCustomAttribute)
  end;

implementation

{ TTabela }

constructor TTabela.Create(const AName: string);
begin
  FName := AName;
end;

{ TField }

constructor TField.Create(const AName: string);
begin
  FName := AName;
end;

end.
