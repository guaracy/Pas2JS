unit uquinze;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  fifteenengine;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    pb: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  pb.width:=BSIZE*4+GAP*5;
  pb.Height:=pb.Width;
  BoardInit;
  DrawBoard;
end;

procedure TForm1.DrawBoard;
var
  r:TRect;
  i: Integer;
begin
  with pb.Canvas do begin
    for i:=0 to CSIZE do begin
      r:=Rect(Board[i].x,Board[i].y,Board[i].x+BSIZE,Board[i].y+BSIZE);
      Brush.Color:=clYellow;
      Brush.Style:=bsSolid;
      if Board[i].n = 0 then begin
        Brush.Color:=clRed;
        Rectangle(R);
        Continue;
      end;
      Rectangle(R);

      TextOut(Board[i].x+7,Board[i].y+7,Board[i].n.ToString);
      //Line(Board[i].x,Board[i].y,Board[i].x+BSIZE,Board[i].y+BSIZE);
      //pb.Canvas.Rectangle(Board[i].x,Board[i].y,Board[i].x+BSIZE,Board[i].y+BSIZE);
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
  pb.Canvas.Brush.Color := clRed;
  pb.Canvas.Brush.Style := bsSolid;
  pb.Canvas.FillRect(0, 0, 100, 100);
  pb.Canvas.Brush.Color := clYellow;
  pb.canvas.Brush.Style := bsHorizontal;
  pb.Canvas.Rectangle(100, 100, 200, 200);
end;

end.

