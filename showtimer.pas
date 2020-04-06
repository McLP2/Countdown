unit showtimer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Label1: TLabel;
    Pause: TMenuItem;
    Settings: TMenuItem;
    CloseBtn: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure CloseBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure Label1Click(Sender: TObject);
    procedure PauseClick(Sender: TObject);
    procedure SettingsClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
  CloseThis, Paused, OpenSettings: Boolean;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.CloseBtnClick(Sender: TObject);
begin
  CloseThis:=true;
end;

procedure TForm2.FormKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #27 then CloseThis:=true;
end;

procedure TForm2.Label1Click(Sender: TObject);
begin

end;

procedure TForm2.PauseClick(Sender: TObject);
begin
  if Paused then
  begin
    Paused:=false;
    Pause.Caption:='Pause';
  end else
  begin
    Paused:=true;
    Pause.Caption:='Resume';
  end;
end;

procedure TForm2.SettingsClick(Sender: TObject);
begin
  Paused:=true;
  OpenSettings:=true;
end;

end.

