program Dragon1;

uses GraphABC, dragon_fractal, dragon_input_handler;

begin
  LockDrawing;
  DrawDragonFractal(200, 140, 0, -4);
  redraw;
  
  onKeyDown += HandleDragonInput; 
end.