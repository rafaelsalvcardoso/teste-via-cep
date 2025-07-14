object TesteViaCeEPForm: TTesteViaCeEPForm
  Left = 0
  Top = 0
  Caption = 'TesteViaCeEPForm'
  ClientHeight = 573
  ClientWidth = 896
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
    Width = 896
    Height = 573
    ActivePage = TSConsultarEnderecos
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 894
    ExplicitHeight = 565
    object TSConsultarEnderecos: TTabSheet
      Caption = 'Consultar Endere'#231'os'
      object Memo: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 279
        Width = 882
        Height = 261
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 2
        ExplicitWidth = 880
        ExplicitHeight = 253
      end
      object topPanel: TPanel
        Left = 0
        Top = 0
        Width = 888
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 886
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
        Width = 888
        Height = 203
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 886
        object EnderecoGroupBox: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 108
          Width = 882
          Height = 92
          Align = alBottom
          Caption = 'Por endere'#231'o'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
          ExplicitWidth = 880
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
          Width = 882
          Height = 92
          Align = alBottom
          Caption = 'Por CEP'
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
          ExplicitWidth = 880
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
        Width = 888
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object ConsultarButton: TButton
          AlignWithMargins = True
          Left = 760
          Top = 3
          Width = 125
          Height = 35
          Align = alRight
          Caption = 'Consultar'
          TabOrder = 0
          OnClick = ConsultarButtonClick
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 888
        Height = 502
        Align = alClient
        DataSource = dsEnderecos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CEP'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Logradouro'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Complemento'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Bairro'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Cidade'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UF'
            Width = 30
            Visible = True
          end>
      end
    end
  end
  object dsEnderecos: TDataSource
    AutoEdit = False
    DataSet = CdsEnderecos
    Left = 268
    Top = 258
  end
  object CdsEnderecos: TClientDataSet
    PersistDataPacket.Data = {
      C90000009619E0BD010000001800000007000000000003000000C90002496404
      000100000000000343455001004900000001000557494454480200020009000A
      4C6F677261646F75726F0100490000000100055749445448020002003C000B43
      6F6D706C656D656E746F0100490000000100055749445448020002003C000642
      616972726F010049000000010005574944544802000200280006436964616465
      0100490000000100055749445448020002002800025546010049000000010005
      57494454480200020002000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 228
    Top = 146
    object CdsEnderecosId: TIntegerField
      FieldName = 'Id'
    end
    object CdsEnderecosCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object CdsEnderecosLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 60
    end
    object CdsEnderecosComplemento: TStringField
      FieldName = 'Complemento'
      Size = 60
    end
    object CdsEnderecosBairro: TStringField
      FieldName = 'Bairro'
      Size = 40
    end
    object CdsEnderecosCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object CdsEnderecosUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
  end
end
