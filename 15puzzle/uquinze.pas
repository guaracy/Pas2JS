unit uquinze;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, LCLType,
  fifteenengine;

type

  { TForm1 }

  TForm1 = class(TForm)
    btNew: TButton;
    lbInfo: TLabel;
    pnTitle: TPanel;
    pnBoard: TPanel;
    procedure btNewClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure pnBoardPaint(Sender: TObject);
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
  pnBoard.Caption:='';
  pnBoard.width:=BSIZE*4+GAP*5;
  pnBoard.Height:=pnBoard.Width;
  pnBoard.Font.Size:=BSIZE div 3;
  BoardInit;
end;

procedure TForm1.pnBoardPaint(Sender: TObject);
begin
  DrawBoard;
end;

procedure TForm1.DrawBoard;
var
  R: TRect;
  ts: TTextStyle;
  i, x, y: Integer;
begin
  with pnBoard.Canvas do begin
    for i:=0 to CSIZE do begin
      x:=Board[i].x;
      x:=x*BSIZE+x*GAP+GAP;
      y:=Board[i].y;
      y:=y*BSIZE+y*GAP+GAP;
      Brush.Color:=clYellow;
      Brush.Style:=bsSolid;
      if Board[i].n = 0 then begin
        Brush.Color:=COLORBLANK;
        Rectangle(x,y,x+BSIZE,y+BSIZE);
        Continue;
      end;
      ts := TextStyle;
      ts.Alignment := taCenter;
      ts.Layout := tlCenter;
      if Board[i].n = i+1 then
        Brush.Color:=COLOROK
      else
        Brush.Color:=COLORWRONG;
      Rectangle(x,y,x+BSIZE,y+BSIZE);
      R.Create(Point(x,y),BSIZE,BSIZE);
      TextRect(R, 0, 0, Board[i].n.ToString, ts);
      //TextOut(x+7,y+7,Board[i].n.ToString);
    end;
  end;
end;

procedure TForm1.btNewClick(Sender: TObject);
begin
  Shuffle;
  DrawBoard;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if DoMove(Key) then
    DrawBoard;
end;

end.

