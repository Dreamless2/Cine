object CineMain: TCineMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'CineMain'
  ClientHeight = 979
  ClientWidth = 1568
  Color = clBtnFace
  DoubleBuffered = True
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
    Width = 1568
    Height = 25
    Align = alTop
    TabOrder = 0
  end
  object PanelTopTitle: TPanel
    Left = 0
    Top = 25
    Width = 1568
    Height = 64
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 1
    ExplicitTop = 21
    object Label1: TLabel
      Left = 16
      Top = 9
      Width = 63
      Height = 45
      Caption = 'Cine'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object PanelStatusBar: TPanel
    Left = 0
    Top = 944
    Width = 1568
    Height = 35
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 894
  end
  object PanelDesktop: TPanel
    Left = 0
    Top = 89
    Width = 1568
    Height = 855
    Align = alClient
    TabOrder = 3
    ExplicitHeight = 805
    object PanelButtons: TPanel
      Left = 1
      Top = 1
      Width = 224
      Height = 853
      Align = alLeft
      TabOrder = 0
      ExplicitHeight = 803
      object FecharButton: TButton
        Left = 1
        Top = 800
        Width = 222
        Height = 52
        Align = alBottom
        Caption = 'Fechar'
        TabOrder = 0
        ExplicitTop = 750
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
