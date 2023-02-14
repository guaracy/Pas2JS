unit fifteenengine;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math;

Const
  CSIZE = 15;
  BSIZE = 50;
  GAP = 2;

type Block = Record
    n,
    x,
    y : integer;
  end;

var
  Board : array [0..CSIZE] of Block;

Procedure BoardInit;
procedure Shuffle;



implementation

Procedure BoardInit;
var
  px,py,
  pb: Integer;
begin
  for pb:=0 to CSIZE do begin
    DivMod(pb,4,py,px);
    writeln('pb=',pb,' x=',px,' y=',py);
    with Board[pb] do begin
      n:=pb;
      x:=px*BSIZE+px*GAP+GAP;
      y:=py*BSIZE+py*GAP+GAP;
    end;
  end;
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
end;

end.

