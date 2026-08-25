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
    Width = 241
    Height = 857
    Align = alLeft
    TabOrder = 3
  end
  object Panel2: TPanel
    Left = 616
    Top = 376
    Width = 185
    Height = 41
    Caption = 'Panel1'
    TabOrder = 4
  end
end
