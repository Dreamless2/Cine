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
    object Label1: TLabel
      Left = 747
      Top = 13
      Width = 74
      Height = 38
      Caption = 'Cine'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -32
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 89
    Width = 235
    Height = 857
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitLeft = -6
    ExplicitTop = 83
    object FilmesButton: TStyledButton
      Left = -6
      Top = 0
      Width = 235
      Height = 97
      Caption = 'FilmesButton'
      TabOrder = 0
      StyleFamily = 'Bootstrap'
    end
    object StyledButton1: TStyledButton
      Left = -6
      Top = 95
      Width = 235
      Height = 97
      Caption = 'SeriesButton'
      TabOrder = 1
      StyleFamily = 'Bootstrap'
    end
    object StyledButton2: TStyledButton
      Left = -6
      Top = 184
      Width = 235
      Height = 97
      Caption = 'AnimesButton'
      TabOrder = 2
      StyleFamily = 'Bootstrap'
    end
    object StyledButton3: TStyledButton
      Left = -6
      Top = 760
      Width = 235
      Height = 97
      Caption = 'FecharButton'
      TabOrder = 3
      StyleFamily = 'Bootstrap'
    end
  end
  object PanelDesktop: TPanel
    Left = 235
    Top = 89
    Width = 1333
    Height = 857
    Align = alClient
    TabOrder = 4
    ExplicitLeft = 616
    ExplicitTop = 376
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
end
