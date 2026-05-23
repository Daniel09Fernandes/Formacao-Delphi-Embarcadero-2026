unit uLogs;

interface

uses
  uZipHelper, SysUtils, Classes, StrUtils,
  TimeSpan, IniFiles;

type
  TMynhaClass = class
  private
    FTeste: string;
  published
      property Teste: string read FTeste write FTeste;
  end;

  TInfoTelas = record
    Nome: TMinhaString;
    TempoAberto: TTimeSpan;
    UltimaAbertura: TDateTime;
    FMeuNovoParam: String;
    FMinhaClasseTeste: TMynhaClass;

    constructor Create(ATeste: string);
  end;

  TLog = class(TIniFile)
  private
  const
      SECTION_TELA = 'TELA_';
      IDENT_QTD = 'QUANTIDADE';
      IDENT_ULT_ABERTA = 'ULTIMA_VEZ_ABERTA';
      IDENT_TEMPO_ABERTO = 'TEMPO_ABERTO';

    function GetSection(AInfoTela: TInfoTelas): string;
    procedure WriteTime(const Section, Name: string; Value: TTimeSpan); overload;
  public
    procedure AddInfoTelaAbrir(AInfoTela: TInfoTelas);
    procedure AddInfoTelaFechar(AInfoTela: TInfoTelas);

    constructor Create(AFile: string); overload;
    destructor Destroy; override;
  end;

implementation
{ TLog }

procedure TLog.AddInfoTelaAbrir(AInfoTela: TInfoTelas);
begin
  var qtd := ReadInteger(GetSection(AInfoTela), IDENT_QTD, 0);

  WriteInteger(GetSection(AInfoTela), IDENT_QTD, qtd +1);
  WriteDateTime(GetSection(AInfoTela), IDENT_ULT_ABERTA, AInfoTela.UltimaAbertura);

  if not AInfoTela.FMeuNovoParam.Trim.IsEmpty then
  begin
                        //Teste
  end;
end;

procedure TLog.AddInfoTelaFechar(AInfoTela: TInfoTelas);
begin
   WriteTime(GetSection(AInfoTela), IDENT_TEMPO_ABERTO, AInfoTela.TempoAberto);
end;

constructor TLog.Create(AFile: string);
begin
  inherited Create(AFile);
end;

destructor TLog.Destroy;
begin
  inherited;
end;

function TLog.GetSection(AInfoTela: TInfoTelas): string;
begin
  Result := SECTION_TELA + AInfoTela.Nome;
end;

procedure TLog.WriteTime(const Section, Name: string; Value: TTimeSpan);
begin
  if Section.Trim.IsEmpty then
    raise Exception.Create('Obrigatorio informar a section');

  if Name.Trim.IsEmpty then
    raise Exception.Create('Obrigatorio Name a section');

  if Value.TotalMilliseconds <= 0 then
    raise Exception.Create('O Tempo informado é invalido');

  WriteString(Section, Name, Value.ToString);
end;

{ TInfoTelas }

{ TInfoTelas }

constructor TInfoTelas.Create(ATeste: string);
begin
    Nome := '';
    UltimaAbertura := 0;
    FMeuNovoParam := ATeste;

    FMinhaClasseTeste := TMynhaClass.Create;
end;

end.
