object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 599
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 624
    Height = 599
    ActivePage = Datasnap
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 506
    object TabSheet1: TTabSheet
      Caption = 'Json'
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 610
        Height = 41
        Align = alTop
        ShowCaption = False
        TabOrder = 0
        object BtnDeserealizar: TButton
          AlignWithMargins = True
          Left = 85
          Top = 4
          Width = 75
          Height = 33
          Align = alLeft
          Caption = 'Deserealizar'
          TabOrder = 0
          OnClick = BtnDeserealizarClick
        end
        object BtnmSerealizar: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 75
          Height = 33
          Align = alLeft
          Caption = 'Serealizar'
          TabOrder = 1
          OnClick = BtnmSerealizarClick
        end
      end
      object MJson: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 50
        Width = 610
        Height = 516
        Align = alClient
        TabOrder = 1
        ExplicitHeight = 423
      end
    end
    object Datasnap: TTabSheet
      Caption = 'Datasnap'
      ImageIndex = 1
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 610
        Height = 238
        Align = alTop
        Alignment = taLeftJustify
        Caption = 'Datasnap Nativo'
        Color = 12303104
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 30
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        VerticalAlignment = taAlignTop
        object Panel4: TPanel
          Left = 8
          Top = 32
          Width = 306
          Height = 201
          Caption = 'Panel4'
          ShowCaption = False
          TabOrder = 0
          object mEnvPessoa: TMemo
            Left = 8
            Top = 56
            Width = 289
            Height = 137
            Color = clBtnFace
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 15
            Font.Name = 'Segoe UI'
            Font.Style = []
            Lines.Strings = (
              '{'
              '            "ativo": false,'
              '            "dataNascimento": "1998-06-20",'
              '            "iD": 3,'
              '            "nome": "Client Pessoa",'
              '            "renda": 822.34'
              ' }')
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
          end
          object BtnEnvPessoa: TButton
            Left = 8
            Top = 8
            Width = 177
            Height = 42
            Caption = 'Enviar Pessoa'
            TabOrder = 1
            OnClick = BtnEnvPessoaClick
          end
        end
        object Panel5: TPanel
          Left = 320
          Top = 32
          Width = 281
          Height = 201
          Caption = 'Panel4'
          ShowCaption = False
          TabOrder = 1
          object mRecPessoa: TMemo
            Left = 3
            Top = 56
            Width = 272
            Height = 137
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 14
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object BtnRecPessoa: TButton
            Left = 3
            Top = 8
            Width = 177
            Height = 42
            Caption = 'Receber Pessoa'
            TabOrder = 1
            OnClick = BtnRecPessoaClick
          end
        end
      end
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 247
        Width = 610
        Height = 282
        Align = alTop
        Alignment = taLeftJustify
        Caption = 'Datasnap N'#227'o Nativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 30
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
        object Panel6: TPanel
          Left = 8
          Top = 49
          Width = 306
          Height = 224
          Caption = 'Panel4'
          ShowCaption = False
          TabOrder = 0
          object mEnvPessoaNaoNativo: TMemo
            Left = 8
            Top = 58
            Width = 289
            Height = 153
            Color = clBtnFace
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 15
            Font.Name = 'Segoe UI'
            Font.Style = []
            Lines.Strings = (
              '{'
              '            "ativo": true,'
              '            "dataNascimento": "1998-06-20",'
              '            "iD": 3457,'
              '            "nome": "Cliente Pessoa",'
              '            "renda": 555.34'
              ' }')
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
          end
          object BtnEnvPessoaNaoNativo: TButton
            Left = 8
            Top = 8
            Width = 177
            Height = 42
            Caption = 'Enviar Pessoa'
            TabOrder = 1
            OnClick = BtnEnvPessoaNaoNativoClick
          end
        end
        object Panel7: TPanel
          Left = 328
          Top = 49
          Width = 281
          Height = 224
          Caption = 'Panel4'
          ShowCaption = False
          TabOrder = 1
          object mRecPessoaNaoNativo: TMemo
            Left = 0
            Top = 58
            Width = 272
            Height = 153
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = 14
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object BtnRecPessoaNaoNativo: TButton
            Left = 3
            Top = 8
            Width = 177
            Height = 42
            Caption = 'Receber Pessoa'
            TabOrder = 1
            OnClick = BtnRecPessoaClick
          end
        end
      end
    end
  end
end
