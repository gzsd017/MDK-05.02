program lab15;

// Задача 1: вывод значения переменной и указателя на нее
procedure task1();
type
  ptr_int = ^integer;

var
  i: integer;
  i_ptr: ptr_int;
begin
  i := 2;
  i_ptr := @i;
  writeln('i: ', i, ' ', 'i_ptr: ', i_ptr^);
end;

// Задача 2: определение длины первого слова из файла
function TakeWord(F: Text): string;
var
  c: char;
begin
  reset(F);
  Result := '';
  c := ' ';
  while not eof(F) and (c <= ' ') do
    read(F, c);
  while not eof(F) and (c > ' ') do begin
    Result := Result + c;
    read(F, c);
  end;
  CloseFile(F);
  TakeWord := Result;
end;

procedure task2();
var
  r: string;
  f: TextFile;
const
  FILE_NAME = 'word.txt';
begin
  Assign(f, FILE_NAME);
  r := TakeWord(f);
  writeln(Length(r)); // вывод длины слова
end;

// Задача 3: работа с связным списком
procedure task3();
type
  PNode = ^Node;
  Node = record
    val: integer;
    next: pointer;
  end;
var
  Head, NewNode, pp: PNode;
  i: integer;
begin
  New(Head);
  Head^.val := 0;
  Head^.next := nil;
  
  i := 1;
  while i <= 10 do begin
    pp := Head;
    while pp^.next <> nil do
      pp := pp^.next;
    New(NewNode);
    NewNode^.val := i;
    NewNode^.next := nil;
    pp^.next := NewNode;
    i := i + 1;
  end;
  
  pp := Head^.next;
  while pp <> nil do begin
    writeln(pp^.val); // вывод элемента списка
    pp := pp^.next;
  end;
  
  pp := Head^.next;
  while pp <> nil do begin
    if pp^.val mod 2 = 0 then
      writeln(pp^.val); // вывод четных элементов списка
    pp := pp^.next;
  end;
end;

// Задача 4: вычисление минимального и максимального элементов
procedure task4();
type
  PNode = ^Node;
  Node = record
    val: integer;
    next: pointer;
  end;
var
  Head, NewNode, pp: PNode;
  i, min, max: integer;
begin
  New(Head);
  Head^.val := 0;
  Head^.next := nil;
  
  i := 501;
  while i <= 1000 do begin
    pp := Head;
    while pp^.next <> nil do begin
      pp := pp^.next;
    end;
    New(NewNode);
    NewNode^.val := (Abs(1000 - i) + Abs(1000 - (i*i)) + Abs(1000 - (i*i*i))) mod 500;
    NewNode^.next := nil;
    pp^.next := NewNode;
    i := i + 1;
  end;
  
  pp := Head^.next;
  min := pp^.val;
  max := pp^.val;
  while pp <> nil do begin
    if pp^.val > max then
      max := pp^.val;
    if pp^.val < min then
      min := pp^.val;
    pp := pp^.next;
  end;
  writeln('Минимальное значение: ', min);
  writeln('Максимальное значение: ', max);
end;

begin
  task4(); // вызов нужной задачи
end.