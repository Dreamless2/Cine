object CineMain: TCineMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'CineMain'
  ClientHeight = 929
  ClientWidth = 1373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object PanelTopBar: TPanel
    Left = 0
    Top = 0
    Width = 1373
    Height = 25
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1311
  end
  object PanelTopTitle: TPanel
    Left = 0
    Top = 25
    Width = 1373
    Height = 64
    Align = alTop
    TabOrder = 1
    ExplicitTop = 41
    ExplicitWidth = 1311
  end
  object PanelStatusBar: TPanel
    Left = 0
    Top = 888
    Width = 1373
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 636
    ExplicitWidth = 1311
  end
  object PanelDesktop: TPanel
    Left = 0
    Top = 89
    Width = 1373
    Height = 799
    Align = alClient
    TabOrder = 3
    ExplicitTop = 82
    ExplicitWidth = 1311
    ExplicitHeight = 554
    object PanelButtons: TPanel
      Left = 1
      Top = 1
      Width = 224
      Height = 797
      Align = alLeft
      TabOrder = 0
    end
  end
end
