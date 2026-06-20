unit uBase.Cadastro.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  System.ImageList, FMX.ImgList, System.Rtti, FMX.Grid.Style, Data.DB,
  Datasnap.DBClient, FMX.ScrollBox, FMX.Grid, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView,
  uHelper.ClientDataset,
  uHelper.Form;

type
  TFrCadBase = class(TForm)
    RContext: TRectangle;
    TabControl1: TTabControl;
    TabConsulta: TTabItem;
    TabCadastro: TTabItem;
    RConsulta: TRectangle;
    RCadastro: TRectangle;
    RConsultar: TRectangle;
    RDados: TRectangle;
    RNavegacao: TRectangle;
    RWindowsBar: TRectangle;
    ImgClose: TImage;
    ImgMax: TImage;
    ImgMin: TImage;
    RCrud: TRectangle;
    REditor: TRectangle;
    ImageList1: TImageList;
    Label1: TLabel;
    EdtPesquisa: TEdit;
    BtnPesquisa: TButton;
    Registros: TLabel;
    GrdDados: TGrid;
    DsDados: TDataSource;
    BtnFirst: TButton;
    BtnPrior: TButton;
    BtnNext: TButton;
    BtnLast: TButton;
    BtnNovo: TButton;
    BtnAlterar: TButton;
    BtnSalvar: TButton;
    BtnDel: TButton;
    BtnCancel: TButton;
    LblTitulo: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BtnPesquisaClick(Sender: TObject);
    procedure EdtPesquisaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure BtnFirstClick(Sender: TObject);
    procedure BtnPriorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure BtnLastClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure ImgMinClick(Sender: TObject);
    procedure ImgCloseClick(Sender: TObject);
    procedure ImgMaxClick(Sender: TObject);
    procedure GrdDadosCellDblClick(const Column: TColumn; const Row: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  protected
    procedure ControleTela(IsEnabled: Boolean);
    procedure SetTitulo(ATitulo: string);
  public
  end;

implementation

{$R *.fmx}

Uses
  uConst.Sys;

procedure TFrCadBase.BtnAlterarClick(Sender: TObject);
begin
  DsDados.DataSet.Edit;
  ControleTela(True);
end;

procedure TFrCadBase.BtnCancelClick(Sender: TObject);
begin
  DsDados.DataSet.Cancel;
  ControleTela(False);
end;

procedure TFrCadBase.BtnDelClick(Sender: TObject);
begin
  //DsDados.DataSet.Delete;
  ControleTela(True);
end;

procedure TFrCadBase.BtnFirstClick(Sender: TObject);
begin
  DsDados.DataSet.First;
end;

procedure TFrCadBase.BtnLastClick(Sender: TObject);
begin
  DsDados.DataSet.Last;
end;

procedure TFrCadBase.BtnNextClick(Sender: TObject);
begin
  DsDados.DataSet.Next;
end;

procedure TFrCadBase.BtnNovoClick(Sender: TObject);
begin
  ControleTela(True);
  DsDados.DataSet.Append;
end;

procedure TFrCadBase.BtnPesquisaClick(Sender: TObject);
begin
  DsDados.DataSet.Filtered := False;
  DsDados.DataSet.Filter := '1 = 1';

  for var I := 0 to DsDados.DataSet.FieldCount-1 do
  begin
    if DsDados.DataSet.Fields[i].DataType = ftString then
    begin
      DsDados.DataSet.Filter := DsDados.DataSet.Filter + ' or ( '+
        DsDados.DataSet.Fields[i].FieldName + ' LIKE '+
        QuotedStr(EdtPesquisa.Text + '%') +' )';
    end;
  end;
  DsDados.DataSet.Filtered := True;
end;

procedure TFrCadBase.BtnPriorClick(Sender: TObject);
begin
  DsDados.DataSet.Prior;
end;

procedure TFrCadBase.BtnSalvarClick(Sender: TObject);
begin
  //DsDados.DataSet.Post;
  ControleTela(False);
end;

procedure TFrCadBase.EdtPesquisaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
  if KEY = vkReturn then
    BtnPesquisaClick(Sender);
end;

procedure TFrCadBase.FormCreate(Sender: TObject);
begin
  RConsulta.Fill.Color := DEFAULT_COLLOR;
  RCadastro.Fill.Color := DEFAULT_COLLOR;
  RWindowsBar.fILL.Color := WIN_BAR_COLOR;

  TabControl1.ActiveTab := TabConsulta;
end;

procedure TFrCadBase.FormDestroy(Sender: TObject);
begin
  self.CleanAllBinds;
end;

procedure TFrCadBase.FormShow(Sender: TObject);
begin
  ControleTela(False);
end;

procedure TFrCadBase.ControleTela(IsEnabled: Boolean);
const
  COMP_DEFAULT = 0;
  COMP_IS_PK = 9;
begin
  for var i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TEdit then
    begin
      var EdtTemp := TEdit(Components[i]);
      if (EdtTemp.Tag = COMP_IS_PK) then
      begin
        EdtTemp.Enabled := False;
       continue;
      end;

      if (EdtTemp.Tag = COMP_DEFAULT) then
        EdtTemp.Enabled := IsEnabled;
    end;

    if Components[i] is TButton then
    begin
      var BtnTemp := TButton(Components[i]);

      if BtnTemp.Tag = 0 then
        BtnTemp.Enabled := not BtnTemp.Enabled;
    end;
  end;
end;

procedure TFrCadBase.GrdDadosCellDblClick(const Column: TColumn;
  const Row: Integer);
begin
  TabControl1.ActiveTab := TabCadastro;
  DsDados.DataSet.Edit;
end;

procedure TFrCadBase.ImgCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrCadBase.ImgMaxClick(Sender: TObject);
begin
  if  WindowState = TWindowState.wsMaximized then
    WindowState := TWindowState.wsNormal
  else
    WindowState := TWindowState.wsMaximized;
end;

procedure TFrCadBase.ImgMinClick(Sender: TObject);
begin
  WindowState := TWindowState.wsMinimized;
end;

procedure TFrCadBase.SetTitulo(ATitulo: string);
begin
  LblTitulo.Text := ATitulo;
end;

end.
