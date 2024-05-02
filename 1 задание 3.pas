type
  NodePtr = ^Node;
  Node = record
    data: integer;
    next: NodePtr;
  end;

procedure CreateList(var head: NodePtr; n: integer);
var
  current, newNode: NodePtr;
  i: integer;
begin
  head := nil;
  current := nil;
  
  for i := 1 to n do
  begin
    new(newNode);
    newNode^.data := i;
    newNode^.next := nil;
    
    if head = nil then
      head := newNode
    else
      current^.next := newNode;
      
    current := newNode;
  end;
end;

procedure DisplayList(head: NodePtr);
var
  current: NodePtr;
begin
  current := head;
  
  while current <> nil do
  begin
    writeln(current^.data);
    current := current^.next;
  end;
end;

procedure DisplayEvenElements(head: NodePtr);
var
  current: NodePtr;
begin
  current := head;
  
  writeln('Четные элементы:');
  while current <> nil do
  begin
    if current^.data mod 2 = 0 then
      writeln(current^.data);
    
    current := current^.next;
  end;
end;

var
  myList: NodePtr;
begin
  CreateList(myList, 10);
  
  writeln('Список:');
  DisplayList(myList);
  
  DisplayEvenElements(myList);
end.
