unit dragon2;

interface

procedure DrawDragonFractal(x, y, dx, dy: integer);

implementation

uses GraphABC;

procedure DrawDragonFractal(x, y, dx, dy: integer);
var
  turn: array [1..1000] of Boolean; // массив для поворотов
  a, b, d, t: integer;
  f: Boolean;
  i: integer;
begin
  SetWindowSize(790, 500);
  SetWindowCaption('Фракталы. Кривая Дракона');
  
  f := true;
  for a := 1 to 64 do
  begin
    turn[2 * a - 1] := f;
    f := not f;
    turn[2 * a] := turn[a];
  end;
  
  b := 0;
  d := 1;
  f := false;
  MoveTo(x, y);
  
  for a := 1 to 128 do
  begin
    for i := 1 to 127 * 4 do
    begin
      b := b + d;
      x := x + dx;
      y := y + dy;
      LineTo(x, y);
      
      if (f and not turn[b]) or (not f and turn[b]) then
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
    LineTo(x, y);
    
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