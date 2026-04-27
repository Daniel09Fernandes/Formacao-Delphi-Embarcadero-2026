unit View.InterfaceGrafica.ConversorMoedas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.Effects, System.Skia, FMX.Skia, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  Model.ConversorGenerico;

type
  TForm1 = class(TForm)
    edtValorConverter: TEdit;
    edtResultadoReal: TEdit;
    btnCotar: TButton;
    recBackground: TRectangle;
    layTopbar: TLayout;
    crcClose: TCircle;
    shBg: TShadowEffect;
    edtResultadoDolar: TEdit;
    mmoResult: TMemo;
    procedure FormShow(Sender: TObject);
    procedure crcCloseClick(Sender: TObject);
    procedure btnCotarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FConversor:  TConversorGenerico<string>;
    procedure ConverteValores;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Model.Conversor;

{$R *.fmx}

procedure TForm1.btnCotarClick(Sender: TObject);
begin
  ConverteValores;
end;

procedure TForm1.ConverteValores;
begin
  {CTRL + SHIFT + A - Uses "Automatica" }
  //var lConversor := TConversor.Create;
  if not Assigned(FConversor) then
    FConversor  := TConversorGenerico<String>.Create;
  try
//    var ResultadoDolar := lConversor.ConverterRealParaDolar(edtValorConverter.Text);
//    var ResultadoReal  := lConversor.ConverterDolarParaReal(edtValorConverter.Text);

    var ResultadoDolar := FConversor.ConverterRealParaDolar(edtValorConverter.Text).ToDouble;
    var ResultadoReal  := FConversor.ConverterDolarParaReal(edtValorConverter.Text).ToDouble;

    if (ResultadoDolar < 0) or (ResultadoReal < 0) then
      ShowMessage('Valor(es) inválido(s)');

    edtResultadoReal.Text := ResultadoDolar.ToString;
    edtResultadoDolar.Text:= ResultadoReal.ToString;

    {//OFF Topic
    var lStringBuilder:= TStringBuilder.Create;
    try
      lStringBuilder.AppendLine('Formacao Delphi 2026');
      lStringBuilder.AppendLine('Forma os caras do delphi');
      lStringBuilder.AppendLine('Teste string');

      mmoResult.Lines.Clear;
      mmoResult.Lines.Add(lStringBuilder.ToString)
    finally
      lStringBuilder.Free;
    end;}

    {OFF Topic
    FConversor.PopulaDicionario('Dolar', ResultadoDolar.ToString);
    FConversor.PopulaDicionario('Real' , ResultadoReal.ToString);

    for var Key in FConversor.Historico.Keys do
    begin
      var Pair: string;

      if FConversor.Historico.TryGetValue(Key, Pair) then
        mmoResult.Lines.Add(Pair);
    end;}
  finally
    {Se fosse local precisaria, elevei o escopo então passei para o formdestroy}
    //lConversor.Free;
  end;
end;

procedure TForm1.crcCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FConversor);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  edtValorConverter.SetFocus;
end;

end.
