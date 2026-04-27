unit DmConnection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Phys.SQLiteWrapper.Stat, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    FdConn: TFDConnection;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDQueryInsert: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    const
      CAMINHODB = '\DB\';
      NOMEDB    = 'Database.db';

      SQL_CREATE_CEP = '''
                        CREATE TABLE IF NOT EXISTS CEP (
                         CEP TEXT,
                         RUA TEXT,
                         CIDADE TEXT,
                         BAIRRO TEXT,
                         ESTADO TEXT
                        )
                       ''';
  public
    { Public declarations }

    procedure InserirDados(const ACep, ARua, ACidade, ABairro, AEstado: string);
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  var CaminhoExe := ExtractFilePath(ParamStr(0));

  if not DirectoryExists(CaminhoExe + CAMINHODB) then
    ForceDirectories(CaminhoExe + CAMINHODB);

  FdConn.DriverName                := 'SQLite';
  FdConn.Params.Values['Database'] := CaminhoExe + CAMINHODB + 'Database.db';
  FdConn.Params.Values['OpenMode'] := 'CreateUTF8';
  FdConn.LoginPrompt               := False;

  FdConn.Connected                 := True;

  FdConn.ExecSQL(SQL_CREATE_CEP);
end;

procedure TDataModule1.InserirDados(const ACep, ARua, ACidade, ABairro,
  AEstado: string);
begin
  FDQueryInsert.ParamByName('CEP').AsString    := ACep;
  FDQueryInsert.ParamByName('RUA').AsString    := ARua;
  FDQueryInsert.ParamByName('CIDADE').AsString := ACidade;
  FDQueryInsert.ParamByName('BAIRRO').AsString := ABairro;
  FDQueryInsert.ParamByName('ESTADO').AsString := AEstado;

  FDQueryInsert.ExecSQL;
end;

end.
