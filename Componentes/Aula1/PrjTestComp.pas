unit PrjTestComp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, uFrame.PopUp, Comp.Panel.Validador,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls,
  FireDAC.Stan.StorageBin, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    EdtSearch: TEdit;
    BtnSearch: TSpeedButton;
    LImgSearch: TImageList;
    Timer1: TTimer;
    FrPromo1: TFrPromo;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    PanelValidador1: TPanelValidador;
    FDMemTable1ID: TIntegerField;
    FDMemTable1Nome: TStringField;
    FDMemTable1Cpf: TStringField;
    FDMemTable1Idade: TIntegerField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure Timer1Timer(Sender: TObject);
    procedure PanelValidador1MeuEvento(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.PanelValidador1MeuEvento(Sender: TObject);
begin
  ShowMessage('Opa');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  FrPromo1.Visible := True;
end;

end.
