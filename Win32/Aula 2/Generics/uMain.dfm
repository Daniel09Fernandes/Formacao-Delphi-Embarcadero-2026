object GenericCalc: TGenericCalc
  Left = 0
  Top = 0
  Caption = 'Calculadora Generica'
  ClientHeight = 214
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object MResult: TMemo
    Left = 8
    Top = 96
    Width = 265
    Height = 70
    TabOrder = 0
  end
  object EdtNum1: TNumberBox
    Left = 8
    Top = 8
    Width = 121
    Height = 23
    Mode = nbmFloat
    TabOrder = 1
  end
  object EdtNum2: TNumberBox
    Left = 152
    Top = 8
    Width = 121
    Height = 23
    Mode = nbmFloat
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 181
    Width = 75
    Height = 25
    Caption = 'Calcular'
    TabOrder = 3
    OnClick = Button1Click
  end
  object RbSoma: TRadioButton
    Left = 8
    Top = 39
    Width = 65
    Height = 17
    Caption = 'Adi'#231#227'o'
    Checked = True
    TabOrder = 4
    TabStop = True
  end
  object RBSub: TRadioButton
    Tag = 1
    Left = 79
    Top = 39
    Width = 88
    Height = 17
    Caption = 'Subtra'#231#227'o'
    TabOrder = 5
  end
  object RbDiv: TRadioButton
    Tag = 2
    Left = 8
    Top = 62
    Width = 65
    Height = 17
    Caption = 'Divis'#227'o'
    TabOrder = 6
  end
  object RbMult: TRadioButton
    Tag = 3
    Left = 79
    Top = 62
    Width = 106
    Height = 17
    Caption = 'Multiplica'#231#227'o'
    TabOrder = 7
  end
end
