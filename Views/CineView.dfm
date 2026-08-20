object CineMain: TCineMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'CineMain'
  ClientHeight = 929
  ClientWidth = 1562
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
    Width = 1562
    Height = 25
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 1373
  end
  object PanelTopTitle: TPanel
    Left = 0
    Top = 25
    Width = 1562
    Height = 64
    Align = alTop
    TabOrder = 1
    ExplicitTop = 21
    ExplicitWidth = 1373
  end
  object PanelStatusBar: TPanel
    Left = 0
    Top = 894
    Width = 1562
    Height = 35
    Align = alBottom
    TabOrder = 2
    ExplicitWidth = 1373
  end
  object PanelDesktop: TPanel
    Left = 0
    Top = 89
    Width = 1562
    Height = 805
    Align = alClient
    TabOrder = 3
    ExplicitTop = 83
    ExplicitWidth = 1373
    object PanelButtons: TPanel
      Left = 1
      Top = 1
      Width = 224
      Height = 803
      Align = alLeft
      TabOrder = 0
      object FecharButton: TButton
        Left = 1
        Top = 750
        Width = 222
        Height = 52
        Align = alBottom
        Caption = 'Fechar'
        TabOrder = 0
      end
      object AnimesButton: TButton
        Left = 1
        Top = 193
        Width = 222
        Height = 96
        Align = alTop
        Caption = 'Animes'
        TabOrder = 1
      end
      object SeriesButton: TButton
        Left = 1
        Top = 97
        Width = 222
        Height = 96
        Align = alTop
        Caption = 'S'#233'ries'
        TabOrder = 2
      end
      object FilmesButton: TButton
        Left = 1
        Top = 1
        Width = 222
        Height = 96
        Align = alTop
        Caption = 'Filmes'
        TabOrder = 3
      end
    end
  end
end
