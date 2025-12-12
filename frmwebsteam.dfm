object Formwebsteam: TFormwebsteam
  Left = 0
  Top = 0
  Caption = 'Formwebsteam'
  ClientHeight = 586
  ClientWidth = 828
  Color = 6178602
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object EdgeBrowser1: TEdgeBrowser
    Left = 0
    Top = 23
    Width = 478
    Height = 563
    Align = alClient
    TabOrder = 1
    AllowSingleSignOnUsingOSPrimaryAccount = False
    TargetCompatibleBrowserVersion = '117.0.2045.28'
    UserDataFolder = 
      'C:\HF_Desenvolvimento\Sistemas\HFManagerD12\Data\WebView2\bds.ex' +
      'e.WebView2'
    OnExecuteScript = EdgeBrowser1ExecuteScript
    OnNavigationCompleted = EdgeBrowser1NavigationCompleted
  end
  object Edit1: TEdit
    Left = 0
    Top = 0
    Width = 828
    Height = 23
    Align = alTop
    Color = 2169367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    OnChange = Edit1Change
  end
  object Panel1: TPanel
    Left = 478
    Top = 23
    Width = 350
    Height = 563
    Align = alRight
    BevelInner = bvLowered
    BevelOuter = bvNone
    Color = 2169367
    ParentBackground = False
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 527
      Width = 348
      Height = 35
      Align = alBottom
      TabOrder = 0
      object BitBtn4: TBitBtn
        Left = 1
        Top = 1
        Width = 346
        Height = 33
        Cursor = crHandPoint
        Align = alClient
        Caption = 'Sair'
        TabOrder = 0
        OnClick = BitBtn4Click
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 492
      Width = 348
      Height = 35
      Align = alBottom
      TabOrder = 1
      object BitBtn3: TBitBtn
        Left = 1
        Top = 1
        Width = 346
        Height = 33
        Cursor = crHandPoint
        Align = alClient
        Caption = 'Adicionar ao servidor (.bat)'
        Enabled = False
        TabOrder = 0
        OnClick = BitBtn3Click
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 457
      Width = 348
      Height = 35
      Align = alBottom
      TabOrder = 2
      object BitBtn2: TBitBtn
        Left = 1
        Top = 1
        Width = 346
        Height = 33
        Cursor = crHandPoint
        Align = alClient
        Caption = 'Baixar selecionado(s) da steam'
        Enabled = False
        TabOrder = 0
        OnClick = BitBtn2Click
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 387
      Width = 348
      Height = 35
      Align = alBottom
      TabOrder = 3
      object BitBtn1: TBitBtn
        Left = 1
        Top = 1
        Width = 346
        Height = 33
        Cursor = crHandPoint
        Align = alClient
        Caption = 'Selecionar'
        Enabled = False
        TabOrder = 0
        OnClick = BitBtn1Click
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 348
      Height = 236
      Align = alClient
      TabOrder = 4
      object Memo1: TMemo
        Left = 1
        Top = 1
        Width = 346
        Height = 189
        Align = alClient
        Color = 2169367
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = Memo1Change
        OnKeyDown = Memo1KeyDown
        OnKeyPress = Memo1KeyPress
      end
      object Panel9: TPanel
        Left = 1
        Top = 210
        Width = 346
        Height = 25
        Align = alBottom
        BevelInner = bvLowered
        BevelOuter = bvNone
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 1
        object BitBtn6: TBitBtn
          Left = 1
          Top = 1
          Width = 344
          Height = 23
          Cursor = crHandPoint
          Align = alClient
          Caption = 'Recuperar '#250'ltima lista de mod'
          TabOrder = 0
          OnClick = BitBtn6Click
        end
      end
      object Panel10: TPanel
        Left = 1
        Top = 190
        Width = 346
        Height = 20
        Align = alBottom
        Alignment = taLeftJustify
        BevelInner = bvLowered
        BevelOuter = bvNone
        Color = 13750737
        ParentBackground = False
        TabOrder = 2
      end
    end
    object Panel7: TPanel
      Left = 1
      Top = 422
      Width = 348
      Height = 35
      Align = alBottom
      TabOrder = 5
      object BitBtn5: TBitBtn
        Left = 1
        Top = 1
        Width = 346
        Height = 33
        Cursor = crHandPoint
        Align = alClient
        Caption = 'Remover da sele'#231#227'o'
        Enabled = False
        TabOrder = 0
        OnClick = BitBtn5Click
      end
    end
    object Panel8: TPanel
      Left = 1
      Top = 237
      Width = 348
      Height = 150
      Align = alBottom
      TabOrder = 6
      object Memo2: TMemo
        Left = 1
        Top = 1
        Width = 346
        Height = 148
        Align = alClient
        Color = 2169367
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          '1 - Acesse a pagina do mod;'
          '2 - Clique em selecionar;'
          '3 - Clique em Baixar;'
          '4 - Clique em add ao servidor (opcional)'
          ''
          'Para remover um mod j'#225' selecionado, acesse a pagina do mod '
          'e clique em '#39'Remover da sele'#231#227'o'#39' ou selecione o mod que '
          'deseja exluir na caixa de sele'#231#227'o acima e clique em DELETE')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
end
