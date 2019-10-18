unit Nastr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin, IniFiles;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpinEdit: TSpinEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure SpinEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Main;

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  Ini: TIniFile;
begin
    Ini:=TiniFile.Create(Form1.TekFile);
    Form1.VopTest := IntToStr(SpinEdit.Value);
    Ini.WriteString('Настройки','ВопросовВТесте', Form1.VopTest);
    Ini.Free;
    Form1.FormCreate(Sender);// Инициализация формы
    Close;
end;

procedure TForm2.SpinEditChange(Sender: TObject);
begin
  if (SpinEdit.Value = 5) then
  begin
    Form1.ch5 := (SpinEdit.Value div 5) - 1;
  end else Form1.ch5 := SpinEdit.Value div 5;
  if Form1.ch5 = 0 then
  begin
    Form1.ch4 := 1;
    Form1.ch3 := 2;
    Form1.ch2 := 3;
  end else
  begin
    Form1.ch4 := Form1.ch5 * 2;
    Form1.ch3 := Form1.ch5 * 3;
    Form1.ch2 := Form1.ch5 * 4;
  end;
  label2.Caption := 'Оценка ОТЛИЧНО(5) выставляется при максимум ' + IntToStr(Form1.ch5) + ' ошибках';
  label3.Caption := 'Оценка ХОРОШО(4) выставляется при максимум ' + IntToStr(Form1.ch4) + ' ошибках';
  label4.Caption := 'Оценка УДОВЛЕТВОРИТЕЛЬНО(3) выставляется при максимум ' + IntToStr(Form1.ch3) + ' ошибках';
  label5.Caption := 'Оценка 2 выставляется при максимум ' + IntToStr(Form1.ch2) + ' ошибках';
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
begin
    Ini:=TiniFile.Create(Form1.TekFile);
    SpinEdit.Value := StrToInt(Ini.ReadString('Настройки','ВопросовВТесте', '5'));
    Form1.VopTest := IntToStr(SpinEdit.Value);
    Ini.Free;
end;

end.
