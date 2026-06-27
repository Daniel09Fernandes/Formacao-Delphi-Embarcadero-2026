unit ServerMethodsFiles;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter;

type
  TServerMethodsArquivos = class(TDSServerModule)
  private
    { Private declarations }
  public
    function Teste: string;

    function GetFile(ANameFile: string; out Size: Cardinal ): TStream;
    function SetFile(ANameFile: string; AArquivo: TStream): Boolean;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TServerMethodsArquivos.GetFile(ANameFile: string;
  out Size: Cardinal): TStream;
begin
  Result := nil;

  if ANameFile.ToUpper = 'LOGO' then
  begin
    Result := TStringStream.Create;
    TStringStream(Result).LoadFromFile('logo.png');
    Result.Position := 0;
  end else
    raise Exception.Create('Arquivo não encontrado.');
end;

function TServerMethodsArquivos.SetFile(ANameFile: string;
  AArquivo: TStream): Boolean;
begin
  Result := False;
  try
    var lStream := TStringStream.Create;
    try
      lStream.LoadFromStream(AArquivo);
      Result := lStream.Size > 0;

      if Result then
        lStream.SaveToFile(ANameFile+ TThread.GetTickCount.ToString+'.png');
    finally
      lStream.Free;
    end;
  except
    Result := False;
  end;
end;

{ TDSServerModule1 }

function TServerMethodsArquivos.Teste: string;
begin
  Result := 'Testado';
end;

end.

