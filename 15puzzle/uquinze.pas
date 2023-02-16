unit uquinze;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, LCLType,
  fifteenengine;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    pb: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure pbClick(Sender: TObject);
  private

  public
    procedure DrawBoard;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  pb.Caption:='';
  pb.Color:=BACKGROUND;
  pb.width:=BSIZE*4+GAP*5;
  pb.Height:=pb.Width;
  pb.Font.Size:=BSIZE div 2;
  BoardInit;
  DrawBoard;
end;

procedure TForm1.pbClick(Sender: TObject);
begin
  DrawBoard;
end;

procedure TForm1.DrawBoard;
var
  i, x, y: Integer;
begin
  with pb.Canvas do begin
    for i:=0 to CSIZE do begin
      x:=Board[i].x;
      x:=x*BSIZE+x*GAP+GAP;
      y:=Board[i].y;
      y:=y*BSIZE+y*GAP+GAP;
      Brush.Color:=clYellow;
      Brush.Style:=bsSolid;
      if Board[i].n = 0 then begin
        Brush.Color:=BACKGROUND;
        Rectangle(x,y,x+BSIZE,y+BSIZE);
        Continue;
      end;
      Rectangle(x,y,x+BSIZE,y+BSIZE);
      TextOut(x+7,y+7,Board[i].n.ToString);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Shuffle;
  DrawBoard;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if IsSolvable then
    label1.Caption:='SOLUÇÃO'
  else
    label1.Caption:='*SEM SOLUÇÃO*';
  DrawBoard;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if DoMove(Key) then
    DrawBoard;
end;

end.

