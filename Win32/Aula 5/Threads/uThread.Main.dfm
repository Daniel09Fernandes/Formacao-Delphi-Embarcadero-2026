object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    624
    441)
  TextHeight = 15
  object Gauge1: TGauge
    Left = 8
    Top = 63
    Width = 281
    Height = 50
    Anchors = [akLeft, akTop, akRight]
    Progress = 0
  end
  object Gauge2: TGauge
    Left = 8
    Top = 119
    Width = 281
    Height = 50
    Anchors = [akLeft, akTop, akRight]
    Progress = 0
  end
  object Gauge3: TGauge
    Left = 8
    Top = 175
    Width = 281
    Height = 50
    Anchors = [akLeft, akTop, akRight]
    Progress = 0
  end
  object Gauge4: TGauge
    Left = 8
    Top = 231
    Width = 281
    Height = 50
    Anchors = [akLeft, akTop, akRight]
    Progress = 0
  end
  object Panel1: TPanel
    Left = 8
    Top = 16
    Width = 608
    Height = 41
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Button1: TButton
      Left = 512
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Calc'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 0
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Execute'
      TabOrder = 1
      OnClick = Button2Click
    end
    object NumberBox1: TNumberBox
      Left = 384
      Top = 6
      Width = 49
      Height = 23
      TabOrder = 2
    end
    object NumberBox2: TNumberBox
      Left = 448
      Top = 6
      Width = 49
      Height = 23
      TabOrder = 3
    end
  end
  object Memo1: TMemo
    Left = 295
    Top = 63
    Width = 321
    Height = 370
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
end
