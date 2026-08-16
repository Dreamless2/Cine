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
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 504
    ExplicitTop = 128
    ExplicitWidth = 185
  end
  object PanelTopTitle: TPanel
    Left = 0
    Top = 41
    Width = 1088
    Height = 56
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 14
      Top = 10
      Width = 181
      Height = 36
      Caption = 'Token TMDB'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
  end
  object PanelStatusBar: TPanel
    Left = 0
    Top = 298
    Width = 1088
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 192
    ExplicitTop = 176
    ExplicitWidth = 185
  end
  object PanelDesktop: TPanel
    Left = 0
    Top = 97
    Width = 1088
    Height = 201
    Align = alClient
    TabOrder = 3
    ExplicitLeft = 368
    ExplicitTop = 234
    ExplicitHeight = 216
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
