uses
GraphABC;

var
x, y, dx, dy, depth: Integer;
scaleFactor: Double = 2.0; // начальный масштабный коэффициент

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
end.