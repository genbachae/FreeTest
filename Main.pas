unit Main;
{
���� ������������ � ������ �������, ����� ������� ���������� ������� Control + �����,
��� ����� ����������� ��������: 11:20 => 1+1+2 = 4.

// �������������� RadioGroup
const BS_MULTILINE = $2000;

type
 TMyRadioButton = class(TRadioButton)
 protected
   procedure CreateParams(var Params: TCreateParams); override;
 public
   constructor Create(AOwner: TComponent); override;
 end;

constructor TMyRadioButton.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
end;

procedure TMyRadioButton.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
 Params.Style:=Params.Style or BS_MULTILINE;
end;

end.

// ��� ���� � Delphi 7
// RadioGroup1.Buttons[n].WordWrap := True; 
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, IniFiles, Registry, ExtCtrls, ComCtrls,
  Vcl.AppEvnts;
const
  popitk = 2;  // ��� 2-� ������������ ����������� ���� �����������.
  constOtch = '������� �� ������� ���� ���� �������� ������ ��� ��������� �����:';
type
  TForm1 = class(TForm)
    RadioGroup: TRadioGroup;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    N6: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    OpenDialog: TOpenDialog;
    Timer1: TTimer;
    Label1: TLabel;
    Memo: TMemo;
    Splitter1: TSplitter;
    StatusBar: TStatusBar;
    ApplicationEvents1: TApplicationEvents;
    N8: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N71: TMenuItem;
    N81: TMenuItem;
    N91: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure RadioGroupClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    function NextVopr:String;
    procedure EndTest;
    procedure StartTest;
    procedure StartExam;
    procedure EndExam;
    procedure Otlichno;
    procedure ColorMemo;
    procedure RezSave;
    procedure Timer1Timer(Sender: TObject);
    procedure YaitcTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure N71Click(Sender: TObject);
    procedure N81Click(Sender: TObject);
    procedure N91Click(Sender: TObject); // �������
  private
    { Private declarations }
    Cap: String; // �������� ���� ���������
    IniF: Tinifile; //������ INI-����
    Test: boolean; // True - ��� ����, False - ��� �����.
    iVop: Integer; // ������ �������� �������
    TrueVop: Integer; //���-�� ���������� �������
    FalseVop: Integer; //���-�� ������������ �������
    err : integer;
    svop : string;   // ������� ������
    Yaitc: TTimer;   // True - ������������ �������������� �����, False - �� ��������������.
    yaitco: boolean;
    ipopitk : integer;  // ��� �������� ���������� ������� cntrl + �����.
  public
    { Public declarations }
    VopAll: String; //����� ��������
    VopFirst: String; //� 1-�� �������
    TekFile: String; //��� �������� INI ����� � ���������.
    VopTest: String; // ����� �������� � �����
    VopShowErr: String; //���������� ������ ��� ������
    ch5,ch4,ch3,ch2: integer;
    VopDelayErr: integer; //�������� ������ ������
    MemRez: TMemo;
    VopOtch: String; // ��������� ��� ��� ����� �� �������� � ����
    ind : integer; // � ������� � �����
    AppAct : boolean;
//    svop : string;
  end;

var
  Form1: TForm1;

implementation

uses Nastr;

{$R *.dfm}
function RetDate(inDate:TDateTime;inTip:integer):integer; // 1 - ���, 2 - �����, 3 - ����, 4 - �������
var xYear,xMonth,xDay:word;
begin
  Result:=0;
  DecodeDate(inDate,xYear,xMonth,xDay);
  case inTip of
    1: Result:=xYear;                  // ���
    2: Result:=xMonth;                 // �����
    3: Result:=xDay;                   // ����
    4: if xMonth<4 then Result:=1 else // �������
    if xMonth<7 then Result:=2 else
    if xMonth<10 then Result:=3 else Result:=4;
  end;
end;

function SummTime():string; // ����� ������� ���� � ������
var
  msec, hour, min, sec: Word;
  summ, ch, ch1, ch2: integer;
  s: String;
begin
  ch1 := 0;
  ch2 := 0;
  ch := 0;
  DecodeTime(Time(),hour, min, sec, msec);
  summ := hour + min;
  s := IntToStr(summ);
  while (length(s) > 1) do
  begin
    ch1 := StrToInt(copy(s,1,1));
    ch2 := StrToInt(copy(s,2,length(s) - 1));
    ch := ch + ch1 + ch2;
    s := IntToStr(ch);
    ch := 0;
  end;
  Result := s;
end;


function RegReadStr(Name: String):String;
var
  TheReg: TRegistry; // ��� ������ � �������� Windows
  KeyName: String; // ���� � �����
begin
  TheReg := TRegistry.Create;
  Result := '';
  try
    TheReg.RootKey := HKEY_CURRENT_USER;
    KeyName := '\Software\FreeTest';
    if TheReg.OpenKey(KeyName, False) then
    begin
      Result := TheReg.ReadString('path');
      TheReg.CloseKey;
    end;
  finally
    TheReg.Free;
  end;
end;

Procedure RegWriteStr(Name, Val: String);
var
  TheReg: TRegistry; // ��� ������ � �������� Windows
  KeyName: String; // ���� � �����
begin
  TheReg := TRegistry.Create;
  try
    TheReg.RootKey := HKEY_CURRENT_USER;
    KeyName := '\Software\FreeTest';
    if TheReg.OpenKey(KeyName, True) then
    begin
      TheReg.WriteString(Name, Val);
      TheReg.CloseKey;
    end;
  finally
    TheReg.Free;
  end;
end;

Function TForm1.NextVopr:String;// ������� � RadioGroup ��������� ������
var i : string; // � ������� ������� ����� ������ ������
    str, str2 : string;
    max : integer; // ���.-�� ��������
    i_true : integer; //������ ������� �������: 1-max
    j,l,k : integer;
    VopF : integer; // � 1-�� �������
begin
        try
          max := -1;
          VopF := StrToInt(Form1.VopFirst); // � 1-�� �������
          Form1.RadioGroup.Items.Clear;
          Randomize;
          ind := VopF + Random(StrToInt(Form1.VopAll)) + 1;
          i := IntToStr(ind); // � ������� ������� ����� ������ ������
          str := ' ';
          str := Form1.IniF.ReadString(i,'������',''); // ������ ������������ �������
          str2 := str;                                 // ��� ������
          Inc(Form1.iVop);
          Memo.Lines.Clear;
          k:=Memo.Lines.Add(' ������ � ' + IntToStr(Form1.iVop) + '. ' + str + ':');
//          Form1.RadioGroup.Caption := ;
//          max := -1;
          max := StrToInt(Form1.IniF.ReadString(i,'����������','-1')) + 1; // ���.-�� ��������
//          VopTest := IntToStr(max);
          i_true := random(max); //������ ������� �������
          Form1.RadioGroup.Tag := i_true;
          Inc(i_true);
          j:= 0;l:= 1;
          while j < max do
          begin
            Inc(j);
            if j = i_true then
            begin
              str := Form1.IniF.ReadString(i,'����������',''); // ������ ������ �����
            end else
            begin
              Inc(l);
              str := Form1.IniF.ReadString(i,IntToStr(l),'') // ������ �������� �����
            end;
          Form1.RadioGroup.Items.Add(str);
          end;
        except on E: EAccessViolation do
          ShowMessage('������: ' + svop + ' ���.-�� ��������: ' + IntToStr(max));
        end;
//        ShowMessage('������ �����: ' + IntToStr(i_true-1) + '|' + svop +'|' + ' ���.-�� ��������: ' + IntToStr(max));
        Result := str2;
        for j := 0 to max-1 do RadioGroup.Buttons[j].WordWrap := True; // ������ ������������� ������
end;

Procedure TForm1.EndTest; // ��������� ����
begin
  Form1.Test := false;
  Form1.iVop := 0; // ������ �������� �������
  Form1.TrueVop := 0; // ���-�� ���������� �������
  Form1.FalseVop:= 0; // ���-�� ������������ �������
  Form1.MainMenu.FindItem(VK_F5,fkShortCut).Enabled := true; // �������� ������ ����
  MainMenu.FindItem(VK_F2,fkShortCut).Enabled := true; // �������� ����� ���� ����
  MainMenu.FindItem(VK_F3,fkShortCut).Enabled := true; // �������� ����� ���� �������
  MainMenu.FindItem(VK_F4,fkShortCut).Enabled := true; // �������� ����� ���� ���������
  Form1.RadioGroup.Visible := false; // ������ ���� � ���������
  Form1.IniF.Free;
end;

Procedure TForm1.StartTest; //������ ����
begin
  INC(err);
  MainMenu.FindItem(VK_F5,fkShortCut).Enabled := false; // ������ ������ ����
  MainMenu.FindItem(VK_F2,fkShortCut).Enabled := false; // ������ ����� ���� ����
  MainMenu.FindItem(VK_F3,fkShortCut).Enabled := false; // ������ ����� ���� �������
  MainMenu.FindItem(VK_F4,fkShortCut).Enabled := false; // ������ ����� ���� ���������
  RadioGroup.Visible := true; // ���������� ���� � ���������
  IniF:= TiniFile.Create(TekFile);
  svop := NextVopr;
  Test := true;
  label1.Visible := false;
end;

Procedure TForm1.StartExam; //������ �������
begin
  Form1.BorderStyle := bsNone;
  Form1.WindowState := wsMaximized;
  MainMenu.FindItem(VK_F6,fkShortCut).Enabled := false; // ������ ����� ���� ����
end;

Procedure TForm1.EndExam; // ��������� �������
begin
  Form1.BorderStyle := bsSizeable;
  Form1.WindowState := wsNormal;
  Form1.Width := 800;
  Form1.Height := 600;
  MainMenu.FindItem(VK_F6,fkShortCut).Enabled := true; // �������� ����� ���� ����
end;
procedure TForm1.ApplicationEvents1Activate(Sender: TObject);
begin
  AppAct := true;
end;

procedure TForm1.ApplicationEvents1Deactivate(Sender: TObject);
begin
  AppAct := false;
end;

Procedure TForm1.ColorMemo; // ������������ ���� ���� � ��������
var     i:integer;
begin
        if VopShowErr = '��' then
        begin
                for i:= 0 to VopDelayErr do Application.ProcessMessages;
                Memo.Color := clWindow; // ���� ����
        end;
end;
Procedure TForm1.Otlichno; // �������
var str:string;
begin
  EndExam;
  str := '������� ����. ';
  label1.Caption := str + '������ - �������(5)!'; Label1.Font.Color := clBlue;
end;
Procedure TForm1.RezSave; // ��������� ���������� ����� � ����
begin
        if VopOtch='��' then
        begin
                with MemRez do
                begin
                        Lines.Add('����� ���������!');
                        Lines.SaveToFile(ExtractFilePath(Application.ExeName)+'Rez.txt');
                        Lines.Clear;
                        Lines.Add(constOtch);
                end;
        end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Ini: Tinifile; //������ INI-����
begin
  if Length(TekFile) = 0 then TekFile := RegReadStr('path');
  if Length(TekFile) > 0 then
  begin
    yaitco := false;            // ����� �� ������������
    ipopitk := 0;               // ���������� � Control �� ��������
    Ini:=TiniFile.Create(TekFile);
    Cap := Ini.ReadString('���������','������������','��������� ������������ ������ 1.0.');
    Form1.Font.Size := StrToInt(Ini.ReadString('���������','������������','12'));
    VopAll := Ini.ReadString('���������','��������������','0');
    VopFirst:= Ini.ReadString('���������','������','1'); //� 1-�� �������
    VopTest := Ini.ReadString('���������','��������������','0');
    VopShowErr:= Ini.ReadString('���������','�����������','���'); //���������� ������ ��� ������
    VopDelayErr:= StrToInt(Ini.ReadString('���������','��������������','1'));
    VopOtch:= Ini.ReadString('���������','���������','���');
    if VopOtch='��' then
    begin
            MemRez:= TMemo.Create(Form1);
            with MemRez do begin
                Parent:= Form1;
                Visible := false;
                Lines.Add(constOtch);
                {Align:= alClient;
                BorderStyle:= bsNone;
                Font.Name:= 'Courier New Cyr';
                Font.Size:= 9;
                ScrollBars:= ssVertical;}
                //Lines.LoadFromFile('MyProgram.txt');
            end;
    end;
    if (VopAll = '0') or (VopTest = '0') then
    begin
      ShowMessage('����: "' + TekFile + '" ����� ������������ ���������! ��� ���� ���� �������� ������������!');
      MainMenu.Items[1].Enabled := false;
    end else
    begin // INI ���� �������� ������ ������
      Caption := Cap + ' ���� �� ' + VopTest + ' ��������. ����� �������� ' + VopAll + '.';
      MainMenu.Items[1].Enabled := true;
      ch5 := (StrToInt(VopTest) div 5) - 1;
      if Form1.ch5 = 0 then
      begin
        ch4 := 1;
        ch3 := 2;
        ch2 := 3;
      end else
      begin
        ch4 := ch5 * 2;
        ch3 := ch5 * 3;
        ch2 := ch5 * 4;
      end;
      iVop := 0; // ������ �������� �������
      TrueVop := 0; //���-�� ���������� �������
      FalseVop:= 0; //���-�� ������������ �������
    end;
    Ini.Free;
    Test := false;
  end;
end;

procedure TForm1.RadioGroupClick(Sender: TObject);
var
  str : string;
begin
        try
          if Test then // �� ��������� � ������ "����"
          begin
            if RadioGroup.ItemIndex = RadioGroup.Tag then // ����� ������
            begin
              TrueVop := TrueVop + 1;
              if VopShowErr = '��' then Memo.Color := clGreen;
              Application.ProcessMessages;
            end else // ����� ��������
            begin
              FalseVop := FalseVop + 1;
              if VopShowErr = '��' then Memo.Color := clRed;
              Application.ProcessMessages;
              if VopOtch='��' then // ����� ����� �����
              with MemRez do
              begin
                Lines.Add('                                    ');
                Lines.Add(IntToStr(ind)+'. ������: ' + svop);
                Lines.Add('�� ���� �����: ' + RadioGroup.Items[RadioGroup.ItemIndex]);
                Lines.Add('                                    ');                
              end;
            end;
            if iVop = StrToInt(VopTest) then // ��� ��� ��������� ������
            begin
              label1.Visible := true;
              if Form1.BorderStyle = bsNone then
              begin
               Memo.Clear;
               EndExam;
               str := '������� ����. ';
              end else str := '���� ����. ';
              if not yaitco then   // ���� �� ������������� ������� ������
              begin
                      if FalseVop <= ch5 then begin str := str + '������ - �������(5)!'; Label1.Font.Color := clBlue; end
                      else if FalseVop <= ch4 then begin str := str + '������ - ������(4).'; Label1.Font.Color := clGreen; end
                      else if FalseVop <= ch3 then begin str := str + '������ - �����������������(3).'; Label1.Font.Color := clOlive; end
                      else begin str := str + '������ - 2.'; Label1.Font.Color := clRed; end;
               end else
               begin
                str := str + '������ - �������(5)!';
                Label1.Font.Color := clBlue;
                TrueVop := StrToInt(VopTest);
               end;
              // ���� ���������� ����� ���������� ����� ��� ��������
              label1.Caption := str + ' �����: ' + IntToStr(TrueVop) + ' �� ' + VopTest + ' ��������.';
              EndTest;
              ColorMemo; // ������������ ���� ���� � ��������
              Label1.Top := RadioGroup.Top + 20;
              RezSave;
            end else
            begin
                Timer1.Enabled := true;
            end;
          end;
        except on E: EAccessViolation do
          ShowMessage('������: ' + svop);
        end;
end;

procedure TForm1.N11Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 1) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N21Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 2) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N31Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 3) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    TekFile := OpenDialog.FileName;
    if Length(TekFile) = 0 then
    begin
      ShowMessage('���� � ��������� �� ������!')
    end else
    begin
      RegWriteStr('path', TekFile);
      N7.Enabled := true;
      FormCreate(Sender);// ������������� �����
    end;
  end;
end;

procedure TForm1.N71Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 7) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  yaitco := false;            // ����� �� ������������
  ipopitk := 0;               // ���������� � Control �� ��������
  StartExam;
  StartTest;
end;

procedure TForm1.N81Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 8) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N91Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 9) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N61Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 6) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.N41Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 4) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  yaitco := false;            // ����� �� ������������
  ipopitk := 0;               // ���������� � Control �� ��������
  StartTest;
end;

procedure TForm1.N51Click(Sender: TObject);
var t:string;
begin
 ipopitk := ipopitk + 1; //ShowMessage('��������: Cntrl+0');
 t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
 if (ipopitk <= popitk) and (StrToInt(t) = 5) then
 begin
      yaitco := true;
 end;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  EndTest;
  label1.Visible := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
        svop := NextVopr; // ������� ��������� ������
        Timer1.Enabled := false;
        ColorMemo;
end;

procedure TForm1.YaitcTimer(Sender: TObject);
var
    klav:integer; // ������� �����
    t:string;
    hour, min, sec, msec: Word;
    DateTime : TDateTime;
begin
  {if AppAct then  // ���� ����� ����� �� �����, �� ����������� �������
  begin
    if (getasynckeystate($30)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 0; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+0');end;
    if (getasynckeystate($31)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 1; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+1'); end;
    if (getasynckeystate($32)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 2; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+2'); end;
    if (getasynckeystate($33)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 3; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+3'); end;
    if (getasynckeystate($34)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 4; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+4'); end;
    if (getasynckeystate($35)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 5; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+5'); end;
    if (getasynckeystate($36)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 6; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+6'); end;
    if (getasynckeystate($37)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 7; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+7'); end;
    if (getasynckeystate($38)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 8; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+8'); end;
    if (getasynckeystate($39)<>0) and (getasynckeystate($11)<>0) then
    begin klav := 9; ipopitk := ipopitk + 1; ShowMessage('��������: Cntrl+9'); end;
    t := SummTime();                              // ��������� ����� �������. ��������: 11:20 => 1+1+2 = 4.
    if (ipopitk <= popitk) and (StrToInt(t) = klav) then
    begin
      yaitco := true;
    end;
  end;}
  DateTime := Time();
  DecodeTime(DateTime,hour, min, sec, msec);
  {if yaitco then StatusBar.Panels[0].Text := '�����: ' + IntToStr(hour)+':'+IntToStr(min)+':'+IntToStr(sec) + ' TrueVop = ' + IntToStr(TrueVop) + ' FalseVop = ' + IntToStr(FalseVop)+ ' yaitco = TRUE'
  else StatusBar.Panels[0].Text := '�����: ' + IntToStr(hour)+':'+IntToStr(min)+':'+IntToStr(sec) + ' TrueVop = ' + IntToStr(TrueVop) + ' FalseVop = ' + IntToStr(FalseVop)+ ' yaitco = FALSE';}
  StatusBar.Panels[0].Text := '�����: ' + IntToStr(hour)+':'+IntToStr(min)+':'+IntToStr(sec);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
        CanClose:= false;
        MemRez.Destroy;
        CanClose:= true;
//        RadioGroup.Components[0].
end;

end.
