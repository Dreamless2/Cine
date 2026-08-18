object PrincipalMain: TPrincipalMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 706
  ClientWidth = 1338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object PanelDesktop: TPanel
    Left = 0
    Top = 0
    Width = 1338
    Height = 706
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 32
    ExplicitTop = 121
    ExplicitWidth = 1396
    ExplicitHeight = 713
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
      Left = 727
      Top = 337
      Width = 24
      Height = 15
      Caption = 'Tags'
    end
    object Label9: TLabel
      Left = 16
      Top = 387
      Width = 46
      Height = 15
      Caption = 'Franquia'
    end
    object Label10: TLabel
      Left = 16
      Top = 437
      Width = 38
      Height = 15
      Caption = 'G'#234'nero'
    end
    object Label11: TLabel
      Left = 495
      Top = 437
      Width = 36
      Height = 15
      Caption = 'Diretor'
    end
    object Label12: TLabel
      Left = 17
      Top = 487
      Width = 39
      Height = 15
      Caption = 'Artistas'
    end
    object Label13: TLabel
      Left = 16
      Top = 539
      Width = 53
      Height = 15
      Caption = 'Produtora'
    end
    object Label14: TLabel
      Left = 888
      Top = 14
      Width = 53
      Height = 15
      Caption = 'Produtora'
    end
    object Edit1: TEdit
      Left = 16
      Top = 35
      Width = 121
      Height = 23
      NumbersOnly = True
      TabOrder = 0
      TextHint = 'C'#243'digo TMDB'
    end
    object Edit2: TEdit
      Left = 143
      Top = 35
      Width = 554
      Height = 23
      TabOrder = 1
      TextHint = 'Nome'
    end
    object ComboBox1: TComboBox
      Left = 703
      Top = 35
      Width = 145
      Height = 23
      TabOrder = 2
      Text = 'Dublado'
      Items.Strings = (
        'Dublado'
        'Legendado'
        'Nacional'
        'Desconhecido')
    end
    object Memo1: TMemo
      Left = 15
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
      Width = 705
      Height = 23
      TabOrder = 4
      TextHint = 'Nome Original'
    end
    object MaskEdit1: TMaskEdit
      Left = 727
      Top = 308
      Width = 120
      Height = 23
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
    end
    object Edit4: TEdit
      Left = 727
      Top = 358
      Width = 120
      Height = 23
      TabOrder = 6
      TextHint = 'Tags'
    end
    object Edit5: TEdit
      Left = 16
      Top = 358
      Width = 705
      Height = 23
      TabOrder = 7
      TextHint = 'Nome Alternativo'
    end
    object Edit6: TEdit
      Left = 17
      Top = 408
      Width = 831
      Height = 23
      TabOrder = 8
      TextHint = 'Franquia'
    end
    object Edit7: TEdit
      Left = 17
      Top = 458
      Width = 472
      Height = 23
      TabOrder = 9
      TextHint = 'G'#234'nero'
    end
    object Edit8: TEdit
      Left = 495
      Top = 458
      Width = 353
      Height = 23
      TabOrder = 10
      TextHint = 'Diretor'
    end
    object Edit9: TEdit
      Left = 17
      Top = 508
      Width = 831
      Height = 23
      TabOrder = 11
      TextHint = 'Artistas'
    end
    object Edit10: TEdit
      Left = 16
      Top = 560
      Width = 831
      Height = 23
      TabOrder = 12
      TextHint = 'Produtora'
    end
    object Memo2: TMemo
      Left = 854
      Top = 35
      Width = 467
      Height = 548
      Lines.Strings = (
        'Memo1')
      TabOrder = 13
    end
    object Button1: TButton
      Left = 248
      Top = 624
      Width = 203
      Height = 57
      Caption = 'Button1'
      TabOrder = 14
    end
    object Button2: TButton
      Left = 480
      Top = 624
      Width = 203
      Height = 57
      Caption = 'Button1'
      TabOrder = 15
    end
    object Button3: TButton
      Left = 712
      Top = 624
      Width = 203
      Height = 57
      Caption = 'Button1'
      TabOrder = 16
    end
    object Button4: TButton
      Left = 944
      Top = 624
      Width = 203
      Height = 57
      Caption = 'Button1'
      TabOrder = 17
    end
  end
end
