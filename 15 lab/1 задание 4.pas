type
  NodePtr = ^Node;
  Node = record
    data: integer;
    next: NodePtr;
  end;

procedure FindMinMaxElement(head: NodePtr; var minElement, maxElement: integer);
var
  current: NodePtr;
begin
  if head = nil then
  begin
    minElement := 0;
    maxElement := 0;
    exit;
  end;

  current := head;
  minElement := current^.data;
  maxElement := current^.data;

  while current <> nil do
  begin
    if current^.data < minElement then
      minElement := current^.data;

    if current^.data > maxElement then
      maxElement := current^.data;

    current := current^.next;
  end;
end;

procedure DisplayList(head: NodePtr);
var
  current: NodePtr;
begin
  current := head;

  while current <> nil do
  begin
    write(current^.data, ' ');
    current := current^.next;
  end;
  writeln;
end;

var
  myList, current, newNode: NodePtr;
  minVal, maxVal: integer;
  i: integer;
begin
  myList := nil;

  for i := 10 downto 1 do
  begin
    new(newNode);
    newNode^.data := i;
    newNode^.next := myList;
    myList := newNode;
  end;

  writeln('Список:');
  DisplayList(myList);

  FindMinMaxElement(myList, minVal, maxVal);
  writeln('Минимальный элемент: ', minVal);
  writeln('Максимальный элемент: ', maxVal);
end.
