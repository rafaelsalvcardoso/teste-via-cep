object TesteViaCeEPForm: TTesteViaCeEPForm
  Left = 0
  Top = 0
  Caption = 'TesteViaCeEPForm'
  ClientHeight = 573
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 647
    Height = 573
    ActivePage = TSConsultarEnderecos
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 624
    ExplicitHeight = 484
    object TSConsultarEnderecos: TTabSheet
      Caption = 'Consultar Endere'#231'os'
      object Memo: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 279
        Width = 633
        Height = 261
        Align = alClient
        TabOrder = 2
        ExplicitTop = 256
        ExplicitHeight = 262
      end
      object topPanel: TPanel
        Left = 0
        Top = 0
        Width = 639
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object Label5: TLabel
          Left = 11
          Top = 19
          Width = 104
          Height = 15
          Caption = 'Formato do retorno'
        end
        object FormatoComboBox: TComboBox
          Left = 11
          Top = 40
          Width = 145
          Height = 23
          ItemIndex = 0
          TabOrder = 0
          Text = 'JSON'
          Items.Strings = (
            'JSON'
            'XML')
        end
      end
      object ConsultaPanel: TPanel
        Left = 0
        Top = 73
        Width = 639
        Height = 203
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 54
        object EnderecoGroupBox: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 108
          Width = 633
          Height = 92
          Align = alBottom
          Caption = 'Por endere'#231'o'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
          ExplicitTop = 191
          ExplicitWidth = 610
          object Label1: TLabel
            Left = 8
            Top = 22
            Width = 14
            Height = 15
            Caption = 'UF'
          end
          object Label2: TLabel
            Left = 135
            Top = 22
            Width = 37
            Height = 15
            Caption = 'Cidade'
          end
          object Label3: TLabel
            Left = 341
            Top = 22
            Width = 62
            Height = 15
            Caption = 'Logradouro'
          end
          object EditUF: TEdit
            Left = 8
            Top = 43
            Width = 121
            Height = 21
            TabOrder = 0
          end
          object EditCidade: TEdit
            Left = 135
            Top = 43
            Width = 200
            Height = 21
            TabOrder = 1
          end
          object EditLogradouro: TEdit
            Left = 341
            Top = 43
            Width = 200
            Height = 21
            TabOrder = 2
          end
          object ExecutarEnderecoButton: TButton
            Left = 547
            Top = 41
            Width = 75
            Height = 25
            Caption = 'Executar'
            TabOrder = 3
            OnClick = ExecutarEnderecoButtonClick
          end
        end
        object CEPGroupBox: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 10
          Width = 633
          Height = 92
          Align = alBottom
          Caption = 'Por CEP'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
          ExplicitLeft = 0
          ExplicitTop = 96
          ExplicitWidth = 616
          object Label4: TLabel
            Left = 8
            Top = 27
            Width = 21
            Height = 15
            Caption = 'CEP'
          end
          object CepEdit: TEdit
            Left = 8
            Top = 48
            Width = 145
            Height = 21
            TabOrder = 0
          end
          object ExecutarCepButton: TButton
            Left = 159
            Top = 47
            Width = 75
            Height = 25
            Caption = 'Executar'
            TabOrder = 1
            OnClick = ExecutarCepButtonClick
          end
        end
      end
    end
    object TSListarEnderecos: TTabSheet
      Caption = 'Listar Endere'#231'os'
      ImageIndex = 1
      object Panel: TPanel
        Left = 0
        Top = 502
        Width = 639
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = -3
        ExplicitTop = 122
        ExplicitWidth = 577
        object ConsultarButton: TButton
          AlignWithMargins = True
          Left = 511
          Top = 3
          Width = 125
          Height = 35
          Align = alRight
          Caption = 'Consultar'
          TabOrder = 0
          OnClick = ConsultarButtonClick
          ExplicitLeft = 449
        end
      end
      object StringGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 639
        Height = 502
        Align = alClient
        BorderStyle = bsNone
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        ExplicitTop = 114
        ExplicitWidth = 577
        ExplicitHeight = 120
      end
    end
  end
end
