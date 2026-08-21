object CineMain: TCineMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'CineMain'
  ClientHeight = 981
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
    BevelOuter = bvNone
    Color = 6900229
    ParentBackground = False
    TabOrder = 0
  end
  object PanelTopTitle: TPanel
    Left = 0
    Top = 25
    Width = 1568
    Height = 64
    Align = alTop
    BevelOuter = bvNone
    Color = 4731908
    ParentBackground = False
    TabOrder = 1
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
    Top = 946
    Width = 1568
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    Color = 4731908
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 894
  end
  object PanelDesktop: TPanel
    Left = 0
    Top = 89
    Width = 1568
    Height = 857
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitHeight = 805
    object PanelButtons: TPanel
      Left = 0
      Top = 0
      Width = 224
      Height = 857
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitHeight = 803
      object FecharButton: TButton
        Left = 0
        Top = 805
        Width = 224
        Height = 52
        Align = alBottom
        Caption = 'Fechar'
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 750
        ExplicitWidth = 222
      end
      object AnimesButton: TButton
        Left = 0
        Top = 192
        Width = 224
        Height = 96
        Align = alTop
        Caption = 'Animes'
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 193
        ExplicitWidth = 222
      end
      object SeriesButton: TButton
        Left = 0
        Top = 96
        Width = 224
        Height = 96
        Align = alTop
        Caption = 'S'#233'ries'
        TabOrder = 2
        ExplicitLeft = 1
        ExplicitTop = 97
        ExplicitWidth = 222
      end
      object FilmesButton: TButton
        Left = 0
        Top = 0
        Width = 224
        Height = 96
        Align = alTop
        Caption = 'Filmes'
        TabOrder = 3
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 222
      end
    end
  end
end
