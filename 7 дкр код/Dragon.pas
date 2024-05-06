program Dragon;

uses
  GraphABC, DragonFractalModule;

var
  x, y, dx, dy, i: integer;
  scaleFactor: Double = 1.0; // начальный масштабный коэффициент

procedure KeyDown(key: integer);
begin
  case key of
    VK_Up:
    begin
      y := y - 50;
    end;
    VK_Down:
    begin
      y := y + 50;
    end;
    VK_Left:
    begin
      x := x - 50;
    end;
    VK_Right:
    begin
      x := x + 50;
    end;
    VK_x:
    begin
      scaleFactor := scaleFactor * 1.1; // увеличение масштаба на 10%
    end;
    VK_z:
    begin
      scaleFactor := scaleFactor / 1.1; // уменьшение масштаба на 10%
    end;
  end;
  Window.Clear;
  DrawDragonFractal(x, y, dx, dy, scaleFactor);
  redraw;
end;

begin
  LockDrawing;
  x := 200;
  y := 140;
  dx := 0;
  dy := -4;
  DrawDragonFractal(x, y, dx, dy, scaleFactor);
  redraw;
  onKeyDown += KeyDown;
end.