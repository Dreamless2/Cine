object TokenMain: TTokenMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Token'
  ClientHeight = 339
  ClientWidth = 1088
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
    Width = 1088
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
    Width = 1088
    Height = 64
    Align = alTop
    BevelOuter = bvNone
    Color = 4731908
    ParentBackground = False
    TabOrder = 1
    object Label2: TLabel
      Left = 442
      Top = 9
      Width = 204
      Height = 38
      Caption = 'Cine - Token'
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
    Top = 304
    Width = 1088
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    Color = 4731908
    ParentBackground = False
    TabOrder = 2
  end
  object PanelDesktop: TPanel
    Left = 0
    Top = 89
    Width = 1088
    Height = 215
    Align = alClient
    TabOrder = 3
    ExplicitTop = 97
    ExplicitHeight = 201
    object Label1: TLabel
      Left = 49
      Top = 28
      Width = 68
      Height = 15
      Caption = 'Token TMDB'
    end
    object TokenButton: TButton
      Left = 328
      Top = 114
      Width = 177
      Height = 57
      Caption = 'Gravar Token'
      TabOrder = 0
    end
    object TokenBox: TEdit
      Left = 49
      Top = 60
      Width = 990
      Height = 23
      TabOrder = 1
      TextHint = 'Token TMDB'
    end
    object CloseButton: TButton
      Left = 583
      Top = 111
      Width = 177
      Height = 57
      Caption = 'Fechar'
      TabOrder = 2
    end
  end
end
