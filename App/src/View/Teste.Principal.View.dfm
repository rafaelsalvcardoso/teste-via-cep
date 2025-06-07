object TesteViaCeEPForm: TTesteViaCeEPForm
  Left = 0
  Top = 0
  Caption = 'TesteViaCeEPForm'
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
  TextHeight = 15
  object StringGrid: TStringGrid
    Left = 0
    Top = 280
    Width = 624
    Height = 120
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 144
    ExplicitTop = 152
    ExplicitWidth = 377
  end
  object Panel1: TPanel
    Left = 0
    Top = 400
    Width = 624
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitLeft = -8
    ExplicitTop = 416
    object ConsultarButton: TButton
      AlignWithMargins = True
      Left = 496
      Top = 3
      Width = 125
      Height = 35
      Align = alRight
      Caption = 'Consultar'
      TabOrder = 0
      OnClick = ConsultarButtonClick
    end
  end
end
