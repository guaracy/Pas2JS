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
    pb: TPanel;
    procedure Button1Click(Sender: TObject);
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
      canvas.Brush.Color:=clSilver;
      canvas.Brush.Style:=bsSolid;
      if Board[i].n = 0 then begin
        canvas.Brush.Color:=clRed;
        canvas.Brush.Style:=bsCross;
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

end.

