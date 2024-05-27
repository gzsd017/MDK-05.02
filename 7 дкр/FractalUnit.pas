unit FractalUnit;

interface

procedure DrawDragonFractal(x, y, dx, dy: Integer; scaleFactor: Double; depth: Integer);

implementation

uses
  GraphABC;

procedure DrawDragonFractal(x, y, dx, dy: Integer; scaleFactor: Double; depth: Integer);
var
  turn: array [1..1000] of Boolean;
  a, b, d, t: Integer;
  f: Boolean;
  i: Integer;
begin
  f := true;
  for a := 1 to 64 do
  begin
    turn[2 * a - 1] := f;
    f := not f;
    turn[2 * a] := turn[a];
  end;
  b := 0;
  d := 1;
  f := False;
  MoveTo(Round(x * scaleFactor), Round(y * scaleFactor));
  for a := 1 to depth do
  begin
    for i := 1 to 127 * 4 do
    begin
      b := b + d;
      x := x + dx;
      y := y + dy;
      LineTo(Round(x * scaleFactor), Round(y * scaleFactor));
      
      if f and not turn[b] or not f and turn[b] then
      begin
        t := dy;
        dy := -dx;
      end
      else
      begin
        t := -dy;
        dy := dx;
      end;
      dx := t;
    end;
    
    b := b + d;
    d := -d;
    f := not f;
    x := x + dx;
    y := y + dy;
    LineTo(Round(x * scaleFactor), Round(y * scaleFactor));
    
    if turn[a] then
    begin
      t := dy;
      dy := -dx;
    end
    else
    begin
      t := -dy;
      dy := dx;
    end;
    dx := t;
  end;
end;

end.