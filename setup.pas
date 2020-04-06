unit setup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, Spin, ExtCtrls, showtimer, DateUtils;

type


  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ColorButton1: TColorButton;
    ColorButton2: TColorButton;
    ColorDialog1: TColorDialog;
    ColorDialog2: TColorDialog;
    DateEdit1: TDateEdit;
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    Timer1: TTimer;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    ToggleBox3: TToggleBox;
    ToggleBox4: TToggleBox;
    ToggleBox5: TToggleBox;
    ToggleBox6: TToggleBox;
    ToggleBox7: TToggleBox;
    ToggleBox8: TToggleBox;
    ToggleBox9: TToggleBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToggleBox1Change(Sender: TToggleBox);
    procedure ToggleBox2Change(Sender: TToggleBox);
    procedure ToggleBox3Change(Sender: TToggleBox);
    procedure ToggleBox4Change(Sender: TToggleBox);
    procedure ToggleBox5Change(Sender: TToggleBox);
    procedure ToggleBox6Change(Sender: TToggleBox);
    procedure ToggleBox7Change(Sender: TToggleBox);
    procedure ToggleBox8Change(Sender: TToggleBox);
    procedure ToggleBox9Change(Sender: TToggleBox);
  private
    { private declarations }
  public
    function LeapYearsBetween(ANow, AThen: TDateTime):Integer;
  end;

var
  Form1: TForm1;
  TimeDiffString: String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.SpinEdit3Change(Sender: TObject);
begin
  if SpinEdit3.Value > 59 then
  begin
    SpinEdit3.Value:=0;
    SpinEdit2.Value:=SpinEdit2.Value+1;
  end else
  begin
    if SpinEdit3.Value < 0 then
    begin
      SpinEdit3.Value:=59;
      SpinEdit2.Value:=SpinEdit2.Value-1;
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  CountToDateTime: TDateTime;
  MSbtw: QWord;
  ddd,mmd,yyyyd,hhd,nnd,ssd,zzzzd: Integer;
begin
  if OpenSettings then
  begin
    OpenSettings:=false;
    Form2.Hide;
    Form1.Show;
    Form1.WindowState:=wsNormal;
  end;
  if CloseThis then Form1.Close;
  CountToDateTime:=EncodeTime(SpinEdit1.Value,SpinEdit2.Value,SpinEdit3.Value,0)+DateEdit1.Date;
  if (Now > CountToDateTime) and CheckBox2.Checked then
  begin
    Paused:=true;
    TimeDiffString:='0.0.0'+sLineBreak+'0:0:0,0000';
  end;
  if not Paused then
  begin
    //Monate ungenau da unterschiedlich lang
    MSbtw:=MilliSecondsBetween(Now, CountToDateTime);
    yyyyd:=trunc(MSbtw/86400000/(365+(LeapYearsBetween(Now, CountToDateTime)/(Abs(YearOf(Now)-YearOf(CountToDateTime))+1))));
    MSbtw:=MSbtw-trunc(yyyyd*86400000*(365+(LeapYearsBetween(Now, CountToDateTime)/(Abs(YearOf(Now)-YearOf(CountToDateTime))+1))));
    mmd:=trunc((MSbtw / 86400000) / 30.4375);
    MSbtw:=MSbtw-trunc(mmd*86400000*30.4375);
    ddd:=MSbtw div 86400000;
    MSbtw:=MSbtw-trunc(ddd*86400000);
    hhd:=MSbtw div 3600000;
    MSbtw:=MSbtw-trunc(hhd*3600000);
    nnd:=MSbtw div 60000;
    MSbtw:=MSbtw-trunc(nnd*60000);
    ssd:=MSbtw div 1000;
    MSbtw:=MSbtw-trunc(ssd*1000);
    zzzzd:=MSbtw;
    if not CheckBox3.Checked then
      TimeDiffString:=IntToStr(ddd)+'.'+IntToStr(mmd)+'.'+IntToStr(yyyyd)+sLineBreak
    else
      TimeDiffString:='';
    TimeDiffString:=TimeDiffString+IntToStr(hhd)+':'+IntToStr(nnd)+':'+IntToStr(ssd)+','+
      Format('%.4d',[zzzzd]);
    if (Now > CountToDateTime) then TimeDiffString:='-'+TimeDiffString;
  end;
  Form2.Label1.Caption:=TimeDiffString;
  end;

procedure TForm1.ToggleBox1Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox2.Checked:=false;
    ToggleBox3.Checked:=false;
    ToggleBox4.Checked:=false;
    ToggleBox5.Checked:=false;
    ToggleBox6.Checked:=false;
    ToggleBox7.Checked:=false;
    ToggleBox8.Checked:=false;
    ToggleBox9.Checked:=false;

    Form2.Label1.Alignment:=taLeftJustify;
    Form2.Label1.Layout:=tlTop;
  end;
end;

procedure TForm1.ToggleBox2Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox1.Checked:=false;
    ToggleBox3.Checked:=false;
    ToggleBox4.Checked:=false;
    ToggleBox5.Checked:=false;
    ToggleBox6.Checked:=false;
    ToggleBox7.Checked:=false;
    ToggleBox8.Checked:=false;
    ToggleBox9.Checked:=false;

    Form2.Label1.Alignment:=taCenter;
    Form2.Label1.Layout:=tlTop;
  end;
end;

procedure TForm1.ToggleBox3Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox1.Checked:=false;
    ToggleBox2.Checked:=false;
    ToggleBox4.Checked:=false;
    ToggleBox5.Checked:=false;
    ToggleBox6.Checked:=false;
    ToggleBox7.Checked:=false;
    ToggleBox8.Checked:=false;
    ToggleBox9.Checked:=false;

    Form2.Label1.Alignment:=taRightJustify;
    Form2.Label1.Layout:=tlTop;
  end;
end;

procedure TForm1.ToggleBox4Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox1.Checked:=false;
    ToggleBox2.Checked:=false;
    ToggleBox3.Checked:=false;
    ToggleBox5.Checked:=false;
    ToggleBox6.Checked:=false;
    ToggleBox7.Checked:=false;
    ToggleBox8.Checked:=false;
    ToggleBox9.Checked:=false;

    Form2.Label1.Alignment:=taLeftJustify;
    Form2.Label1.Layout:=tlCenter;
  end;
end;

procedure TForm1.ToggleBox5Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox1.Checked:=false;
    ToggleBox2.Checked:=false;
    ToggleBox3.Checked:=false;
    ToggleBox4.Checked:=false;
    ToggleBox6.Checked:=false;
    ToggleBox7.Checked:=false;
    ToggleBox8.Checked:=false;
    ToggleBox9.Checked:=false;

    Form2.Label1.Alignment:=taCenter;
    Form2.Label1.Layout:=tlCenter;
  end;
end;

procedure TForm1.ToggleBox6Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox1.Checked:=false;
    ToggleBox2.Checked:=false;
    ToggleBox3.Checked:=false;
    ToggleBox4.Checked:=false;
    ToggleBox5.Checked:=false;
    ToggleBox7.Checked:=false;
    ToggleBox8.Checked:=false;
    ToggleBox9.Checked:=false;

    Form2.Label1.Alignment:=taRightJustify;
    Form2.Label1.Layout:=tlCenter;
  end;
end;

procedure TForm1.ToggleBox7Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox1.Checked:=false;
    ToggleBox2.Checked:=false;
    ToggleBox3.Checked:=false;
    ToggleBox4.Checked:=false;
    ToggleBox5.Checked:=false;
    ToggleBox6.Checked:=false;
    ToggleBox8.Checked:=false;
    ToggleBox9.Checked:=false;

    Form2.Label1.Alignment:=taLeftJustify;
    Form2.Label1.Layout:=tlBottom;
  end;
end;

procedure TForm1.ToggleBox8Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox1.Checked:=false;
    ToggleBox2.Checked:=false;
    ToggleBox3.Checked:=false;
    ToggleBox4.Checked:=false;
    ToggleBox5.Checked:=false;
    ToggleBox6.Checked:=false;
    ToggleBox7.Checked:=false;
    ToggleBox9.Checked:=false;

    Form2.Label1.Alignment:=taCenter;
    Form2.Label1.Layout:=tlBottom;
  end;
end;

procedure TForm1.ToggleBox9Change(Sender: TToggleBox);
begin
  if Sender.Checked then
  begin
    ToggleBox1.Checked:=false;
    ToggleBox2.Checked:=false;
    ToggleBox3.Checked:=false;
    ToggleBox4.Checked:=false;
    ToggleBox5.Checked:=false;
    ToggleBox6.Checked:=false;
    ToggleBox7.Checked:=false;
    ToggleBox8.Checked:=false;

    Form2.Label1.Alignment:=taRightJustify;
    Form2.Label1.Layout:=tlBottom;
  end;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  if SpinEdit2.Value > 59 then
  begin
    SpinEdit2.Value:=0;
    SpinEdit1.Value:=SpinEdit1.Value+1;
  end else
  begin
    if SpinEdit2.Value < 0 then
    begin
      SpinEdit2.Value:=59;
      SpinEdit1.Value:=SpinEdit1.Value-1;
    end;
  end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  if SpinEdit1.Value > 23 then
  begin
    SpinEdit1.Value:=0;
    DateEdit1.Date:=DateEdit1.Date+1;
  end else
  begin
    if SpinEdit1.Value < 0 then
    begin
      SpinEdit1.Value:=23;
      DateEdit1.Date:=DateEdit1.Date-1;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Paused:=true;
  DateEdit1.Date:=DateEdit1.Date;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    Button2.Font := FontDialog1.Font;
    Button2.Font.Size:=0;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.Color:=ColorButton2.ButtonColor;
  Form2.Label1.Font:=FontDialog1.Font;
  Form2.Label1.Font.Color:=ColorButton1.ButtonColor;
  if CheckBox1.Checked then Form2.Label1.Font.Underline:=true else Form2.Label1.Font.Underline:=false;
  Paused:=false;
  Form2.Show;
  Form1.WindowState:=wsMinimized;
end;

function TForm1.LeapYearsBetween(ANow, AThen: TDateTime):Integer;
var LeapYears, AYear, AYearDown: Integer;
begin
  LeapYears:=0;
  if ANow < AThen then
    for AYear := YearOf(ANow) to YearOf(AThen) do
      if isLeapYear(AYear) then
        LeapYears:=LeapYears+1
  else
    for AYearDown := YearOf(ANow) downto YearOf(AThen) do
      if isLeapYear(AYear) then
        LeapYears:=LeapYears+1;
  LeapYearsBetween:=LeapYears;
end;

end.

