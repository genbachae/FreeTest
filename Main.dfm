object Form1: TForm1
  Left = 257
  Top = 224
  Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1090#1077#1089#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1079#1085#1072#1085#1080#1081' 1.0. '#1060#1072#1081#1083' '#1089' '#1074#1086#1087#1088#1086#1089#1072#1084#1080' '#1085#1077' '#1074#1099#1073#1088#1072#1085'.'
  ClientHeight = 332
  ClientWidth = 890
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 1
    Top = 210
    Width = 8
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 73
    Width = 890
    Height = 9
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 169
  end
  object RadioGroup: TRadioGroup
    Left = 0
    Top = 82
    Width = 890
    Height = 231
    Align = alClient
    Caption = #1042#1072#1088#1080#1072#1085#1090#1099' '#1086#1090#1074#1077#1090#1086#1074':'
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
    TabOrder = 0
    Visible = False
    OnClick = RadioGroupClick
  end
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 890
    Height = 73
    Align = alTop
    Lines.Strings = (
      #1042#1086#1087#1088#1086#1089' '#8470)
    ReadOnly = True
    TabOrder = 1
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 313
    Width = 890
    Height = 19
    Panels = <
      item
        Text = #1042#1088#1077#1084#1103':'
        Width = 50
      end>
  end
  object MainMenu: TMainMenu
    Left = 208
    object N1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      ShortCut = 113
      object N3: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1074#1086#1087#1088#1086#1089#1099
        OnClick = N3Click
      end
    end
    object N2: TMenuItem
      Caption = '&'#1058#1077#1089#1090
      Enabled = False
      ShortCut = 117
      object N6: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        ShortCut = 115
        OnClick = N6Click
      end
      object N4: TMenuItem
        Caption = #1053#1072#1095#1072#1090#1100
        ShortCut = 116
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100
        OnClick = N5Click
      end
    end
    object N7: TMenuItem
      Caption = #1069#1082#1079#1072#1084#1077#1085
      ShortCut = 114
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = #1071#1081#1094#1086
      Visible = False
      object N11: TMenuItem
        Caption = '1'
        ShortCut = 16496
        OnClick = N11Click
      end
      object N21: TMenuItem
        Caption = '2'
        ShortCut = 16497
        OnClick = N21Click
      end
      object N31: TMenuItem
        Caption = '3'
        ShortCut = 16498
        OnClick = N31Click
      end
      object N41: TMenuItem
        Caption = '4'
        ShortCut = 16499
        OnClick = N41Click
      end
      object N51: TMenuItem
        Caption = '5'
        ShortCut = 16500
        OnClick = N51Click
      end
      object N61: TMenuItem
        Caption = '6'
        ShortCut = 16501
        OnClick = N61Click
      end
      object N71: TMenuItem
        Caption = '7'
        ShortCut = 16502
        OnClick = N71Click
      end
      object N81: TMenuItem
        Caption = '8'
        ShortCut = 16503
        OnClick = N81Click
      end
      object N91: TMenuItem
        Caption = '9'
        ShortCut = 16504
        OnClick = N91Click
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 240
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 272
  end
  object Yaitc: TTimer
    OnTimer = YaitcTimer
    Left = 304
  end
  object ApplicationEvents1: TApplicationEvents
    OnActivate = ApplicationEvents1Activate
    OnDeactivate = ApplicationEvents1Deactivate
    Left = 336
  end
end
