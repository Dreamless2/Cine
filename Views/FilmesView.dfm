object PrincipalMain: TPrincipalMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 834
  ClientWidth = 1396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PanelTopBar: TPanel
    Left = 0
    Top = 0
    Width = 1396
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 216
    ExplicitTop = 96
    ExplicitWidth = 185
  end
  object PanelTitle: TPanel
    Left = 0
    Top = 41
    Width = 1396
    Height = 80
    Align = alTop
    TabOrder = 1
  end
  object PanelDesktop: TPanel
    Left = 0
    Top = 121
    Width = 1396
    Height = 713
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 512
    ExplicitTop = 272
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 16
      Top = 14
      Width = 75
      Height = 15
      Caption = 'C'#243'digo TMDB'
    end
    object Label2: TLabel
      Left = 336
      Top = 46
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
  end
end
