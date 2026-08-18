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
    object Label1: TLabel
      Left = 16
      Top = 14
      Width = 75
      Height = 15
      Caption = 'C'#243'digo TMDB'
    end
    object Label2: TLabel
      Left = 272
      Top = 14
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 464
      Top = 6
      Width = 75
      Height = 15
      Caption = 'Tipo de '#193'udio'
    end
    object Label4: TLabel
      Left = 16
      Top = 54
      Width = 41
      Height = 15
      Caption = 'Sinopse'
    end
    object Label5: TLabel
      Left = 16
      Top = 134
      Width = 78
      Height = 15
      Caption = 'Nome Original'
    end
    object Label6: TLabel
      Left = 248
      Top = 134
      Width = 109
      Height = 15
      Caption = 'Data de Lan'#231'amento'
    end
    object Label7: TLabel
      Left = 32
      Top = 232
      Width = 34
      Height = 15
      Caption = 'Label7'
    end
  end
end
