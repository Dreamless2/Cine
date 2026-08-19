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
  end
  object PanelTopTitle: TPanel
    Left = 0
    Top = 25
    Width = 1373
    Height = 64
    Align = alTop
    TabOrder = 1
  end
  object PanelStatusBar: TPanel
    Left = 0
    Top = 888
    Width = 1373
    Height = 41
    Align = alBottom
    TabOrder = 2
  end
  object PanelDesktop: TPanel
    Left = 0
    Top = 89
    Width = 1373
    Height = 799
    Align = alClient
    TabOrder = 3
    object PanelButtons: TPanel
      Left = 1
      Top = 1
      Width = 224
      Height = 797
      Align = alLeft
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = -4
      object FecharButton: TButton
        Left = 1
        Top = 744
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
        ExplicitLeft = 2
        ExplicitTop = 9
      end
      object SeriesButton: TButton
        Left = 1
        Top = 97
        Width = 222
        Height = 96
        Align = alTop
        Caption = 'S'#233'ries'
        TabOrder = 2
        ExplicitLeft = 2
        ExplicitTop = 9
      end
      object FilmesButton: TButton
        Left = 1
        Top = 1
        Width = 222
        Height = 96
        Align = alTop
        Caption = 'Filmes'
        TabOrder = 3
        ExplicitLeft = 2
        ExplicitTop = 9
      end
    end
  end
end
