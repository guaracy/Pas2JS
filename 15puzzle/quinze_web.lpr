program quinze_web;

{$mode objfpc}

uses
  BrowserApp, JS, Classes, SysUtils, Web,
  fifteenengine;

type

  { TMyApplication }

  TMyApplication = class(TBrowserApplication)
    btNew: TJSHTMLButtonElement;
    FCanvas: TJSHTMLCanvasElement;
    FCtx: TJSCanvasRenderingContext2D;
    procedure BindElements;
    function OnFormKeyPress(k: TJSKeyBoardEvent): Boolean;
    function NewGame(aEvent: TJSMouseEvent):boolean;
    procedure DrawBoard;
  protected
    procedure DoRun; override;
  public
  end;

procedure TMyApplication.BindElements;
var
  i:integer;
  s:string;
begin
  btNew:=TJSHTMLButtonElement(getHTMLElement('bt_new'));
  btNew.OnClick := @NewGame;
  FCanvas:=TJSHTMLCanvasElement(document.getElementById('my_canvas'));
  FCanvas.width:=BSIZE*4+GAP*5;
  FCanvas.height:=FCanvas.width;
  FCtx:=TJSCanvasRenderingContext2D(FCanvas.getContext('2d'));
  FCtx.font:='bold 40px Arial';
  FCtx.textAlign:= 'center';
  document.onkeydown:=@OnFormKeyPress;
  BoardInit;
  DrawBoard;
end;

function TMyApplication.OnFormKeyPress(k: TJSKeyBoardEvent): Boolean;
Var
  key : word;
begin
  Result:=True;
  case K.Code of
    TJSKeyNames.ArrowRight : key:=VK_RIGHT;
    TJSKeyNames.ArrowUp    : key:=VK_UP;
    TJSKeyNames.ArrowLeft  : key:=VK_LEFT;
    TJSKeyNames.ArrowDown  : key:=VK_DOWN;
  end;
  k.preventDefault;
  if DoMove(key) then
    DrawBoard;
end;

function TMyApplication.NewGame(aEvent: TJSMouseEvent): boolean;
begin
  Shuffle;
  DrawBoard;
end;

procedure TMyApplication.DrawBoard;
var
  i, x, y: Integer;
begin
  for i:=0 to CSIZE do begin
    FCtx.beginPath;
    x:=Board[i].x;
    x:=x*BSIZE+x*GAP+GAP;
    y:=Board[i].y;
    y:=y*BSIZE+y*GAP+GAP;
    FCtx.strokeStyle:='Black';
    if Board[i].n = 0 then begin
      FCtx.fillStyle:=COLORBLANK;
      FCtx.rect(x,y,BSIZE,BSIZE);
      FCtx.fillRect(x,y,BSIZE,BSIZE);
      FCtx.stroke;
      Continue;
    end else begin
      if Board[i].n=i+1 then
        FCtx.fillStyle:=COLOROK
      else
        FCtx.fillStyle:=COLORWRONG;
      FCtx.rect(x,y,BSIZE,BSIZE);
      FCtx.fillRect(x,y,BSIZE,BSIZE);
      FCtx.fillStyle:='Black';
      FCtx.fillText(Board[i].n.ToString, x + BSIZE div 2, y+BSIZE div 2);
      FCtx.stroke;
    end;
  end;
  //
end;


procedure TMyApplication.DoRun;
begin
  BindElements;
  BoardInit;
end;

var
  Application : TMyApplication;

begin
  Application:=TMyApplication.Create(nil);
  Application.Initialize;
  Application.Run;
end.
