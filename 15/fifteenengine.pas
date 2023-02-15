unit fifteenengine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, LCLType;

Const
  CSIZE = 15;
  BSIZE = 50;
  GAP = 2;
  BACKGROUND = $00808080;

type Block = Record
    n,
    x,
    y : integer;
  end;

var
  Board : array [0..CSIZE] of Block;
  Blank : integer;

Procedure BoardInit;
procedure Shuffle;
Function  DoMove(key:word):Boolean;
Function IsSolvable:Boolean;


implementation

procedure SetBlank;
var
  i: Integer;
begin
  for i:=0 to CSIZE do
    if Board[i].n = 0 then begin
      Blank:=i;
      {$IFDEF LINUX}
      writeln('blank=',i,' x=',Board[i].x,' y=',Board[i].y
      {$ENDIF}
      Break;
    end;
end;

Procedure BoardInit;
var
  px,py,
  pb: Integer;
begin
  Randomize;
  for pb:=0 to CSIZE do begin
    DivMod(pb,4,py,px);
    with Board[pb] do begin
      n:=pb;
      x:=px;
      y:=py;
    end;
  end;
  Blank:=CSIZE;
end;

procedure Shuffle;
var
  i,j,n: Integer;
begin
  for i := CSIZE downto 0 do begin
    j := Random(i);
    if not (i = j) then begin
      n := Board[i].n;
      Board[i].n := Board[j].n;
      Board[j].n := n;
    end;
  end;
  SetBlank;
end;

Function  CanMove(key:word):Boolean;
begin
  Result:=False;
  case key of
    VK_UP    : if Board[Blank].y = 3 then exit;
    VK_DOWN  : if Board[Blank].y = 0 then exit;
    VK_RIGHT : if Board[Blank].x = 0 then exit;
    VK_LEFT  : if Board[Blank].x = 3 then exit;
  end;
  Result:=True;
end;

Function DoMove(Key:word):Boolean;
var
  d:integer;
begin
  Result:=CanMove(key);
  if not Result then
    exit;
  case Key of
    VK_UP    : d :=  4;
    VK_DOWN  : d := -4;
    VK_RIGHT : d := -1;
    VK_LEFT  : d :=  1;
  end;
  Board[Blank].n := Board[Blank+d].n;
  Blank:=Blank+d;
  Board[Blank].n:=0;
end;

// https://mathworld.wolfram.com/15Puzzle.html
// https://stackoverflow.com/questions/34570344/check-if-15-puzzle-is-solvable

Function IsSolvable:Boolean;
var
//  sol : array[0..15] of integer = (12, 1, 10, 2, 7, 11, 4, 14, 5, 0, 9, 15, 8, 13, 6, 3); // solvable
  sol : array[0..15] of integer = (3, 9, 1, 15, 14, 11, 4, 6, 13, 0, 10, 12, 2, 7, 8, 5); // not solvable
    //sol : array[0..15] of integer = (13, 10, 11, 6, 5, 7, 4, 8, 1, 12, 14, 9, 3, 15, 2, 0); // not solvable
  dbc : integer;
  i,j : integer;
  p,c : integer;
begin
  for i:=0 to CSIZE do
    Board[i].n:=sol[i];
  c:=0;
  SetBlank;
  p:=4-Board[Blank].y;
  for i:=0 to CSIZE - 1 do
    for j:=i to CSIZE -1 do
      if (Board[i].n > 0) and (Board[j].n > 0) then
        if Board[i].n > Board[j].n then
          inc(c);
  Result:=odd(c) xor even(p);
end;

end.

