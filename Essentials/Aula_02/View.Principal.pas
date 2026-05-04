unit View.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Effects, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.MultiView, System.Skia, FMX.Skia, FMX.TabControl, FMX.Edit, Frame.Edit,
  Frame.Btn, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView;

type
  TFrPrincipal = class(TForm)
    recBgPrincipal: TRectangle;
    shBgPrincipal: TShadowEffect;
    layTopBar: TLayout;
    crcClose: TCircle;
    shClose: TShadowEffect;
    layPrincipalArea: TLayout;
    layMenubar: TLayout;
    recBgMenubar: TRectangle;
    recBtnQrCode: TRectangle;
    SKQrCode: TSkAnimatedImage;
    layTelas: TLayout;
    tbcTelas: TTabControl;
    tbiQrCode: TTabItem;
    recBtnConsultarQrCode: TRectangle;
    shBtnQrCode: TShadowEffect;
    sklblBtnQrCode: TSkLabel;
    layImgQrCode: TLayout;
    imgQrCode: TImage;
    recEditQrCode: TRectangle;
    edtQrCode: TEdit;
    recBtnPokemon: TRectangle;
    SKPokemon: TSkAnimatedImage;
    tbiPokemon: TTabItem;
    layFrEdit: TLayout;
    FrEditPokemon: TFrEdit;
    layBtnConsultar: TLayout;
    FrBtn: TFrBtn;
    layTop: TLayout;
    layFoto: TLayout;
    layInfos: TLayout;
    imgFoto: TImage;
    layAbilities: TLayout;
    layMoves: TLayout;
    lvMoves: TListView;
    procedure crcCloseClick(Sender: TObject);
    procedure recBtnQrCodeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure recBtnQrCodeMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure recBtnConsultarQrCodeClick(Sender: TObject);
    procedure recBtnPokemonMouseLeave(Sender: TObject);
    procedure recBtnPokemonMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure recBtnQrCodeClick(Sender: TObject);
    procedure recBtnPokemonClick(Sender: TObject);
    procedure FrBtnrecBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure RenderizarQrCode(ABytes: TBytes);
    procedure CriarLabels(const AText: string; AIndex: Integer; AOwner: TFmxObject);
    procedure RenderizarFoto(const AUrl: string);
  public
    { Public declarations }
  end;

  THelperBytesToImagem = record helper for TBytes
    procedure Renderizar(AImage: TImage);
  end;

var
  FrPrincipal: TFrPrincipal;

implementation

uses
  Model.ConsultaQrCode,
  Model.Pokedex,
  IniTemaPadrao,
  DmConn,
  Model.DTO_Clientes,
  Model.RTTI;

{$R *.fmx}

procedure TFrPrincipal.crcCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrPrincipal.CriarLabels(const AText: string; AIndex: Integer;
  AOwner: TFmxObject);
begin
  var llabel    := TSkLabel.Create(AOwner);
  llabel.Parent := AOwner;
  llabel.TextSettings.FontColor := $FF484848;
  llabel.TextSettings.Font.Size := 18;
  llabel.Text := AText;
  llabel.Cursor := crHandPoint;

  llabel.Name := 'lbl' + AText.Replace('-', '_');

  llabel.Align := TAlignLayout.Top;
  if AIndex = 0 then
    llabel.Align := TAlignLayout.MostTop;
end;

procedure TFrPrincipal.FormShow(Sender: TObject);
begin
  tbcTelas.ActiveTab := tbiQrCode;

  TIniTemaPadrao.New.Tema := 'Obsidian';
  {
    Somente VCL: Project>Options>Application>Appereance
    TStyleManager.TrySetStyle(TIniTemaPadrao.New.Tema)
  }
end;

procedure TFrPrincipal.FrBtnrecBtnClick(Sender: TObject);

  procedure LimparComponentes;
  begin
    for var I := 0 to Pred(layAbilities.ChildrenCount) do
    begin
      if layAbilities.Children[0] is TSkLabel then
        TSkLabel(layAbilities.Children[0]).Free;
    end;
  end;

begin
  var DAORTTI := TRtti<TClientes_DTO>.Create;
  try
    var Tabela: RTabela;
    var Campos: ListaCampos;

    DAORTTI.BuscarDadosClasse;
    DAORTTI.CreateTable;
    DAORTTI.Executar(DataModule1.FDConnection1);
  finally
    DAORTTI.Free;
  end;

  {var lPokemon := TPokedex.New.ConsultarPokemon(FrEditPokemon.Text);

  LimparComponentes;
  lvMoves.Items.Clear;

  for var I := 0 to Pred(lPokemon.Abilities.Count) do
  begin
    var lHabilidade := lPokemon.Abilities[I].Ability;

    CriarLabels(lHabilidade.Name, I, layAbilities);
  end;

  for var I := 0 to Pred(lPokemon.Moves.Count) do
  begin
    var lMove := lPokemon.Moves[I].Move;

    lvMoves.BeginUpdate;
    try
      var Item := lvMoves.Items.Add;
      var Obj  := TListItemText(Item.Objects.FindDrawable('liMove'));
      Obj.Text := lMove.Name;
    finally
      lvMoves.EndUpdate;
    end;
  end;

  RenderizarFoto(lPokemon.Sprites.FrontDefault); }
end;

procedure TFrPrincipal.recBtnConsultarQrCodeClick(Sender: TObject);
begin
  var lConsultarQrCode := TConsultaQrCode.Create;
  try
    var lRetorno := lConsultarQrCode.ConsularQrCode(edtQrCode.Text);
    //RenderizarQrCode(lRetorno);
    lRetorno.Renderizar(imgQrCode);
  finally
    lConsultarQrCode.Free;
  end;
end;

procedure TFrPrincipal.recBtnPokemonClick(Sender: TObject);
begin
  tbcTelas.ActiveTab := tbiPokemon;
end;

procedure TFrPrincipal.recBtnPokemonMouseLeave(Sender: TObject);
begin
  SKPokemon.Animation.Enabled := False;
end;

procedure TFrPrincipal.recBtnPokemonMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  SKPokemon.Animation.Enabled := True;
end;

procedure TFrPrincipal.recBtnQrCodeClick(Sender: TObject);
begin
  tbcTelas.ActiveTab := tbiQrCode;
end;

procedure TFrPrincipal.recBtnQrCodeMouseLeave(Sender: TObject);
begin
  SKQrCode.Animation.Enabled := False;
end;

procedure TFrPrincipal.recBtnQrCodeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  SKQrCode.Animation.Enabled := True;
end;

procedure TFrPrincipal.RenderizarFoto(const AUrl: string);
begin
  var lImg := TMemoryStream.Create;
  try
    TPokedex.New.BuscarFoto(lImg, AUrl);
    imgFoto.Bitmap.LoadFromStream(lImg);
  finally
    lImg.Free;
  end;
end;

procedure TFrPrincipal.RenderizarQrCode(ABytes: TBytes);
begin
  var lMemoryStream := TMemoryStream.Create;
  try
    lMemoryStream.WriteBuffer(ABytes[0], Length(ABytes));
    imgQrCode.Bitmap.LoadFromStream(lMemoryStream);
  finally
    lMemoryStream.Free;
  end;
end;

{ THelperBytesToImagem }

procedure THelperBytesToImagem.Renderizar(AImage: TImage);
begin
  var lMemoryStream := TMemoryStream.Create;
  try
    lMemoryStream.WriteBuffer(Self[0], Length(Self));
    AImage.Bitmap.LoadFromStream(lMemoryStream);
  finally
    lMemoryStream.Free;
  end;
end;

end.
