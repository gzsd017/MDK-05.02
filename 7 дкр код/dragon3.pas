unit dragon3;

interface

procedure HandleDragonInput(key: integer);

implementation

uses GraphABC, dragon_fractal;

procedure HandleDragonInput(key: integer);
var
  x, y, dx, dy, i: integer;
begin
  x := 200;
  y := 140;
  dx := 0;
  dy := -4;
  i := 0;
  
  case key of
    VK_Up: begin y := y - 50 end;
    VK_Down: begin y := y + 50 end;
    VK_Left: begin x := x - 50 end;
    VK_Right: begin x := x + 50 end;
    VK_z:
      begin
        i := i + 1;
        x := x + i;
        dx := dx - i;
        dy := dy + i;
        y := y - i;
      end;
    VK_x:
      begin
        i := i - 1;
        x := x - i;
        dx := dx + i;
        dy := dy - i;
        y := y + i;
      end;
    VK_a: if i > 0 then i := i - 1;
    VK_d: if i < 4 then i := i + 1;
  end;
  
  Window.Clear;
  DrawDragonFractal(x, y, dx, dy);
  redraw;
end;

end.