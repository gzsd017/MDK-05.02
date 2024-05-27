unit MainUnit;

interface

procedure KeyDown(key: Integer);
procedure RunDragonFractal;

implementation

uses
  GraphABC, FractalUnit;

var
  x, y, dx, dy, depth: Integer;
  scaleFactor: Double = 2.0; // начальный масштабный коэффициент

procedure KeyDown(key: Integer);
begin
  case key of
    VK_Up:
    begin
      y := y - 10;
    end;
    VK_Down:
    begin
      y := y + 10;
    end;
    VK_Left:
    begin
      x := x - 10;
    end;
    VK_Right:
    begin
      x := x + 10;
    end;
    VK_x:
    begin
      scaleFactor := scaleFactor * 1.1; // увеличение масштаба на 10%
    end;
    VK_z:
    begin
      scaleFactor := scaleFactor / 1.1; // уменьшение масштаба на 10%
    end;
    VK_w:
    begin
      depth := depth + 1; // увеличение глубины фрактала
    end;
    VK_s:
    begin
      if depth > 1 then
      begin
        depth := depth - 1; // уменьшение глубины фрактала
      end;
    end;
  end;
  
  Window.Clear;
  DrawDragonFractal(x, y, dx, dy, scaleFactor, depth);
  Redraw;
end;

procedure RunDragonFractal;
begin
  LockDrawing;
  x := 200;
  y := 140;
  dx := 0;
  dy := -4;
  depth := 1; // начальная глубина фрактала
  DrawDragonFractal(x, y, dx, dy, scaleFactor, depth);
  Redraw;
  OnKeyDown := KeyDown;
end;

end.