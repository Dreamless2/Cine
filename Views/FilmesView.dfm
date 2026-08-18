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
    ExplicitLeft = 128
    ExplicitTop = 47
    object Label1: TLabel
      Left = 16
      Top = 14
      Width = 75
      Height = 15
      Caption = 'C'#243'digo TMDB'
    end
    object Label2: TLabel
      Left = 152
      Top = 14
      Width = 33
      Height = 15
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 712
      Top = 6
      Width = 75
      Height = 15
      Caption = 'Tipo de '#193'udio'
    end
    object Label4: TLabel
      Left = 16
      Top = 64
      Width = 41
      Height = 15
      Caption = 'Sinopse'
    end
    object Label5: TLabel
      Left = 16
      Top = 287
      Width = 78
      Height = 15
      Caption = 'Nome Original'
    end
    object Label6: TLabel
      Left = 727
      Top = 287
      Width = 109
      Height = 15
      Caption = 'Data de Lan'#231'amento'
    end
    object Label7: TLabel
      Left = 16
      Top = 337
      Width = 94
      Height = 15
      Caption = 'Nome Alternativo'
    end
    object Label8: TLabel
      Left = 333
      Top = 544
      Width = 24
      Height = 15
      Caption = 'Tags'
    end
    object Label9: TLabel
      Left = 91
      Top = 600
      Width = 46
      Height = 15
      Caption = 'Franquia'
    end
    object Edit1: TEdit
      Left = 16
      Top = 35
      Width = 121
      Height = 23
      TabOrder = 0
      Text = 'Edit1'
    end
    object Edit2: TEdit
      Left = 143
      Top = 35
      Width = 554
      Height = 23
      TabOrder = 1
      Text = 'Edit1'
    end
    object ComboBox1: TComboBox
      Left = 703
      Top = 35
      Width = 145
      Height = 23
      TabOrder = 2
      Text = 'ComboBox1'
    end
    object Memo1: TMemo
      Left = 16
      Top = 85
      Width = 832
      Height = 196
      Lines.Strings = (
        'Memo1')
      TabOrder = 3
    end
    object Edit3: TEdit
      Left = 16
      Top = 308
      Width = 554
      Height = 23
      TabOrder = 4
      Text = 'Edit1'
    end
    object MaskEdit1: TMaskEdit
      Left = 727
      Top = 308
      Width = 121
      Height = 23
      TabOrder = 5
      Text = 'MaskEdit1'
    end
  end
end
