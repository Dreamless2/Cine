object SeriesMain: TSeriesMain
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'SeriesMain'
  ClientHeight = 867
  ClientWidth = 1341
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PanelDesktop: TPanel
    Left = 0
    Top = 0
    Width = 1341
    Height = 867
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitWidth = 1464
    ExplicitHeight = 914
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
      Left = 703
      Top = 14
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
      Width = 77
      Height = 15
      Caption = 'Data de Estreia'
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
      Top = 537
      Width = 46
      Height = 15
      Caption = 'Franquia'
    end
    object Label10: TLabel
      Left = 15
      Top = 587
      Width = 38
      Height = 15
      Caption = 'G'#234'nero'
    end
    object Label11: TLabel
      Left = 495
      Top = 587
      Width = 36
      Height = 15
      Caption = 'Diretor'
    end
    object Label12: TLabel
      Left = 16
      Top = 637
      Width = 39
      Height = 15
      Caption = 'Artistas'
    end
    object Label13: TLabel
      Left = 17
      Top = 687
      Width = 53
      Height = 15
      Caption = 'Produtora'
    end
    object Label14: TLabel
      Left = 854
      Top = 14
      Width = 43
      Height = 15
      Caption = 'Resumo'
    end
    object Label15: TLabel
      Left = 17
      Top = 387
      Width = 29
      Height = 15
      Caption = 'Filme'
    end
    object Label16: TLabel
      Left = 727
      Top = 387
      Width = 53
      Height = 15
      Caption = 'Fase MCU'
    end
    object Label17: TLabel
      Left = 17
      Top = 437
      Width = 98
      Height = 15
      Caption = 'Local de Produ'#231#227'o'
    end
    object Label18: TLabel
      Left = 561
      Top = 437
      Width = 79
      Height = 15
      Caption = 'IdiomaOriginal'
    end
    object Label19: TLabel
      Left = 17
      Top = 487
      Width = 100
      Height = 15
      Caption = 'Obra de Refer'#234'ncia'
    end
    object Label20: TLabel
      Left = 455
      Top = 487
      Width = 41
      Height = 15
      Caption = 'Autores'
    end
    object Label21: TLabel
      Left = 455
      Top = 537
      Width = 69
      Height = 15
      Caption = 'Showrunners'
    end
    object CodigoBox: TEdit
      Left = 16
      Top = 35
      Width = 121
      Height = 23
      NumbersOnly = True
      TabOrder = 0
      TextHint = 'C'#243'digo TMDB'
    end
    object NomeBox: TEdit
      Left = 143
      Top = 35
      Width = 554
      Height = 23
      TabOrder = 1
      TextHint = 'Nome'
    end
    object AudioBox: TComboBox
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
    object SinopseBox: TMemo
      Left = 15
      Top = 85
      Width = 832
      Height = 196
      Lines.Strings = (
        '')
      TabOrder = 3
    end
    object OriginalBox: TEdit
      Left = 16
      Top = 308
      Width = 705
      Height = 23
      TabOrder = 4
      TextHint = 'Nome Original'
    end
    object EstreiaBox: TMaskEdit
      Left = 727
      Top = 308
      Width = 120
      Height = 23
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
    end
    object TagsBox: TEdit
      Left = 727
      Top = 358
      Width = 120
      Height = 23
      TabOrder = 6
      TextHint = 'Tags'
    end
    object AlternativoBox: TEdit
      Left = 16
      Top = 358
      Width = 705
      Height = 23
      TabOrder = 7
      TextHint = 'Nome Alternativo'
    end
    object FranquiaBox: TEdit
      Left = 17
      Top = 558
      Width = 432
      Height = 23
      TabOrder = 8
      TextHint = 'Franquia'
    end
    object GeneroBox: TEdit
      Left = 17
      Top = 608
      Width = 472
      Height = 23
      TabOrder = 9
      TextHint = 'G'#234'nero'
    end
    object DiretorBox: TEdit
      Left = 495
      Top = 608
      Width = 353
      Height = 23
      TabOrder = 10
      TextHint = 'Diretor'
    end
    object ArtistasBox: TEdit
      Left = 17
      Top = 658
      Width = 831
      Height = 23
      TabOrder = 11
      TextHint = 'Artistas'
    end
    object ProdutoraBox: TEdit
      Left = 16
      Top = 708
      Width = 831
      Height = 23
      TabOrder = 12
      TextHint = 'Produtora'
    end
    object ResumoBox: TMemo
      Left = 854
      Top = 35
      Width = 467
      Height = 696
      TabOrder = 13
    end
    object CopiarButton: TButton
      Left = 196
      Top = 773
      Width = 203
      Height = 57
      Caption = 'Copiar'
      TabOrder = 14
    end
    object SalvarButton: TButton
      Left = 444
      Top = 773
      Width = 203
      Height = 57
      Caption = 'Salvar/Atualizar'
      TabOrder = 15
    end
    object Anterior: TButton
      Left = 693
      Top = 773
      Width = 203
      Height = 57
      Caption = 'Anterior'
      TabOrder = 16
    end
    object ProximoButton: TButton
      Left = 942
      Top = 773
      Width = 203
      Height = 57
      Caption = 'Pr'#243'ximo'
      TabOrder = 17
    end
    object FilmeBox: TEdit
      Left = 17
      Top = 408
      Width = 704
      Height = 23
      TabOrder = 18
      TextHint = 'Filme'
    end
    object MCUBox: TEdit
      Left = 727
      Top = 408
      Width = 120
      Height = 23
      TabOrder = 19
      TextHint = 'Fase MCU'
    end
    object Edit1: TEdit
      Left = 15
      Top = 458
      Width = 434
      Height = 23
      TabOrder = 20
      TextHint = 'Filme'
    end
    object Edit2: TEdit
      Left = 455
      Top = 458
      Width = 393
      Height = 23
      TabOrder = 21
      TextHint = 'Filme'
    end
    object Edit3: TEdit
      Left = 15
      Top = 508
      Width = 434
      Height = 23
      TabOrder = 22
      TextHint = 'Filme'
    end
    object Edit4: TEdit
      Left = 455
      Top = 508
      Width = 393
      Height = 23
      TabOrder = 23
      TextHint = 'Filme'
    end
    object Edit5: TEdit
      Left = 455
      Top = 558
      Width = 393
      Height = 23
      TabOrder = 24
      TextHint = 'Filme'
    end
  end
end
