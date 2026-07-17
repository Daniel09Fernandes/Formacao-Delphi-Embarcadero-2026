unit Comp.Panel.Validador;

interface

uses
  Classes, SysUtils, VCl.DBCtrls, VCL.Controls, vcl.Graphics,
  Vcl.ExtCtrls, System.Generics.Collections, Data.DB;

type
  TMeuEvento = procedure(Sender: TObject) of object;

  TEditConfig = class(TComponent)
  strict private
    FBevelInner: TBevelCut;
    FBevelOuter: TBevelCut;
    FBevelKind: TBevelKind;
    FBevelWidth: TBevelWidth;
    FColor: TColor;
    FFontColor: TColor;
  protected
    procedure PreencheProps(AOwner: TDbEdit);
  public
    constructor create(AOwner: TDbEdit); reintroduce; overload;
  published
    property BevelInner: TBevelCut   read FBevelInner write FBevelInner;
    property BevelOuter: TBevelCut   read FBevelOuter write FBevelOuter;
    property BevelKind:  TBevelKind  read FBevelKind  write FBevelKind;
    property BevelWidth: TBevelWidth read FBevelWidth write FBevelWidth;
    property Color: TColor read FColor write FColor;
    property FontColor: TColor read FFontColor write FFontColor;
  end;

  TCustomPanelValidador = class(TCustomPanel)
  const
    MSG_CAMPO_OBRIGATORIO = 'O campo %s é de preenchimento obrigatorio e está em branco.'+
       sLineBreak + 'Revise antes de continuar!';
  strict private
    FMeuEvento: TMeuEvento;
    FListaComponentes: TDictionary<TControl, TEditConfig>;
    FOnBeforePost: TDataSetNotifyEvent;
  private
    function IsCPFValido(ACPF: string): Boolean;
  protected
    FActive: Boolean;
    FDataSource: TDataSource;
    FEditConfig: TEditConfig;

    procedure SetDataSource(const ADatasource: TDataSource);
    procedure OnBeforePostCDS(ADataSet: TDataSet);
    procedure CreateParams(var PArams: TCreateParams); override;

    property OnMeuEvento: TMeuEvento read FMeuEvento write FMeuEvento;
  public
    function ValidarCamposObrigatorios: string;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TPanelValidador = class(TCustomPanelValidador)
  published
    property Caption;
    property Align;
    property Active: Boolean read FActive write FActive default False;
    property EditConfig: TEditConfig read FEditConfig write FEditConfig;
    property DataSource: TDataSource read FDataSource write FDataSource;
    property OnMeuEvento; 
  end;

implementation

{ TEditConfig }

constructor TEditConfig.create(AOwner: TDbEdit);
begin
  inherited Create(AOwner);
  PreencheProps(AOwner);
end;

procedure TEditConfig.PreencheProps(AOwner: TDbEdit);
begin
  FBevelInner := AOwner.BevelInner;
  FBevelOuter := AOwner.BevelOuter;
  FBevelKind  := AOwner.BevelKind;
  FBevelWidth := AOwner.BevelWidth;
  FColor := AOwner.Color;
  FFontColor := AOwner.Font.Color;
end;

{ TCustomPanelValidador }

constructor TCustomPanelValidador.Create(AOwner: TComponent);
begin
  inherited;

  FListaComponentes := TDictionary<TControl, TEditConfig>.Create;
  FActive := True;

  FEditConfig := TEditConfig.create(Self);
  FEditConfig.BevelInner := bvSpace;
  FEditConfig.BevelOuter := bvRaised;
  FEditConfig.BevelKind  := bkTile;
  FEditConfig.BevelWidth := 2;
  FEditConfig.Color := clRed;
  FEditConfig.FontColor := clWhite;
end;

//Parecido com o OnShow, coisas visuais devem ser iniciadas aqui:
procedure TCustomPanelValidador.CreateParams(var PArams: TCreateParams);
begin
  inherited;

  ShowCaption := False;
  Caption := '';
  BevelOuter := bvNone;
  AlignWithMargins := true;
  SetDataSource(FDataSource);
  Color := clWhite;

  if Assigned(FMeuEvento) then
    FMeuEvento(Self);
end;

destructor TCustomPanelValidador.Destroy;
begin
  FreeAndNil(FListaComponentes);
  inherited;
end;

procedure TCustomPanelValidador.OnBeforePostCDS(ADataSet: TDataSet);
begin
  if not FActive then
  begin
    if Assigned(FOnBeforePost) then
      FOnBeforePost(ADataSet);
  end
  else
  begin
     var MsgAlerta := ValidarCamposObrigatorios;
     if not MsgAlerta.Trim.IsEmpty then
       raise Exception.Create('Validador informa: '+ sLineBreak+ MsgAlerta);
  end;
end;

procedure TCustomPanelValidador.SetDataSource(const ADatasource: TDataSource);
begin
  if not Assigned(FDataSource) then
    raise Exception.Create('FDataSource nao criado');

  FDataSource := ADatasource;

  if not Assigned(FOnBeforePost) then
    FOnBeforePost := OnBeforePostCDS;

  FDataSource.DataSet.BeforePost := FOnBeforePost;
end;

function TCustomPanelValidador.IsCPFValido(ACPF: string): Boolean;
var
  I, Soma, Resto, D1, D2: Integer;
  CPF_Limpo: string;
begin
  Result := False;
  CPF_Limpo := '';

  // 1. Remove caracteres não numéricos
  for I := 1 to Length(ACPF) do
  begin
    if ACPF[I] in ['0'..'9'] then
      CPF_Limpo := CPF_Limpo + ACPF[I];
  end;

  // Um CPF precisa ter exatamente 11 dígitos
  if Length(CPF_Limpo) <> 11 then
    Exit(False);

  // 2. Rejeita CPFs com todos os números iguais (ex: 11111111111)
  if (CPF_Limpo = '00000000000') or (CPF_Limpo = '11111111111') or
     (CPF_Limpo = '22222222222') or (CPF_Limpo = '33333333333') or
     (CPF_Limpo = '44444444444') or (CPF_Limpo = '55555555555') or
     (CPF_Limpo = '66666666666') or (CPF_Limpo = '77777777777') or
     (CPF_Limpo = '88888888888') or (CPF_Limpo = '99999999999') then
    Exit(False);

  // 3. Cálculo do Primeiro Dígito (D1)
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + (StrToInt(CPF_Limpo[I]) * (11 - I));
    
  Resto := (Soma * 10) mod 11;
  if Resto = 10 then 
    Resto := 0;
  D1 := Resto;

  // 4. Cálculo do Segundo Dígito (D2)
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + (StrToInt(CPF_Limpo[I]) * (12 - I));
    
  Resto := (Soma * 10) mod 11;
  if Resto = 10 then 
    Resto := 0;
  D2 := Resto;

  // 5. Verifica se os dígitos calculados batem com os informados
  Result := (D1 = StrToInt(CPF_Limpo[10])) and (D2 = StrToInt(CPF_Limpo[11]));
end;

function TCustomPanelValidador.ValidarCamposObrigatorios: string;
begin
  Result := '';

  if not Assigned(FDataSource) then
    Exit('DataSource não informado.');

  if not Assigned(FDataSource.DataSet) then
    Exit('DataSet não informado.');

  if FDataSource.DataSet.FieldCount <=0 then
    Exit('O DataSeet informado não possui fields.');

  if FDataSource.DataSet.ControlsDisabled then
    Exit('Os controles visuais(DisabledControls) estão desativados.');

  for var I := 0 to Self.ControlCount -1 do
  begin
    if (not Assigned(Controls[i])) or
       (not (Controls[i] is TDBEdit)) or
       (not Assigned(TDBEdit(Controls[I]).Field)) then
    begin
      Continue;
    end;

    var DbEdit := TDBEdit(Controls[I]);
//    var DbEdit := (Controls[I] as TDBEdit);

    var IsCpfInvalido := False;

    if DbEdit.Field.FieldName.ToUpper.Contains('CPF') then
      IsCpfInvalido := not IsCPFValido(DbEdit.Text);

    if (DbEdit.Field.Required and
      (string(DbEdit.Text).Trim.IsEmpty )) or (IsCpfInvalido) then
    begin
      if not FListaComponentes.ContainsKey(DbEdit) then
        FListaComponentes.AddOrSetValue(DbEdit, TEditConfig.Create(DbEdit));
      
       DbEdit.BevelInner := FEditConfig.BevelInner;
       DbEdit.BevelOuter := FEditConfig.BevelOuter;
       DbEdit.BevelKind := FEditConfig.BevelKind;
       DbEdit.BevelWidth := FEditConfig.BevelWidth;
       DbEdit.Color := FEditConfig.Color;
       DbEdit.Font.Color := FEditConfig.FontColor;

       Result := Result + sLineBreak + Format(MSG_CAMPO_OBRIGATORIO,
         [DbEdit.Field.DisplayName]);
    end
    else
    begin
      if not FListaComponentes.ContainsKey(DbEdit) then
        Continue;

      DbEdit.BevelInner := FListaComponentes[DbEdit].BevelInner;
      DbEdit.BevelOuter := FListaComponentes[DbEdit].BevelOuter;
      DbEdit.BevelKind := FListaComponentes[DbEdit].BevelKind;
      DbEdit.BevelWidth := FListaComponentes[DbEdit].BevelWidth;
      DbEdit.Color := FListaComponentes[DbEdit].Color;
      DbEdit.Font.Color := FListaComponentes[DbEdit].FontColor;
    end;
  end;
end;

{ TPanelValidador }

end.
