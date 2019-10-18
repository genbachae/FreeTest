object Form2: TForm2
  Left = 408
  Top = 279
  Width = 410
  Height = 158
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    402
    124)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 9
    Width = 153
    Height = 19
    Anchors = [akLeft, akTop, akRight]
    Caption = #1074#1086#1087#1088#1086#1089#1086#1074' '#1074' '#1090#1077#1089#1090#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 390
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = #1054#1094#1077#1085#1082#1072' '#1054#1058#1051#1048#1063#1053#1054'(5) '#1074#1099#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1084#1072#1082#1089#1080#1084#1091#1084' 0 '#1086#1096#1080#1073#1082#1072#1093
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 390
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = #1054#1094#1077#1085#1082#1072' '#1061#1054#1056#1054#1064#1054'(4) '#1074#1099#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1084#1072#1082#1089#1080#1084#1091#1084' 1 '#1086#1096#1080#1073#1082#1077
  end
  object Label4: TLabel
    Left = 8
    Top = 64
    Width = 390
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = #1054#1094#1077#1085#1082#1072' '#1059#1044#1054#1042#1051#1045#1058#1042#1054#1056#1048#1058#1045#1051#1068#1053#1054'(3) '#1074#1099#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1084#1072#1082#1089#1080#1084#1091#1084' 2 '#1086#1096#1080#1073#1082#1072#1093
  end
  object Label5: TLabel
    Left = 8
    Top = 80
    Width = 390
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Caption = #1054#1094#1077#1085#1082#1072' 2 '#1074#1099#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1084#1072#1082#1089#1080#1084#1091#1084' 3 '#1086#1096#1080#1073#1082#1072#1093
  end
  object SpinEdit: TSpinEdit
    Left = 8
    Top = 8
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 5
    OnChange = SpinEditChange
  end
  object BitBtn1: TBitBtn
    Left = 136
    Top = 96
    Width = 97
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
    Style = bsNew
  end
end
