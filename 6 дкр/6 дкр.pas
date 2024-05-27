program dkr6;

uses crt;

type PNode = ^Node;
     Node = record
       data: integer;
       next: PNode;
     end;
type TQueue = record
       head, tail: PNode;
       Cnt : Integer; 
     end;
     
var
  staticQueue: array[1..5] of integer;
  dynamicQueue: TQueue;
  choice, value, headd, taill: integer;


//Динамическая структура     
procedure PushTail( var Q: TQueue; x: integer );
var NewNode: PNode;
begin
  New(NewNode);
  NewNode^.data := x;
  NewNode^.next := nil;
  if Q.tail <> nil then
    Q.tail^.next := NewNode;
  Q.tail := NewNode; 
  if Q.head = nil then Q.head := Q.tail;
end;

function Pop ( var Q: TQueue ): integer;
var top: PNode;
begin
  if Q.head = nil then begin
    Result := MaxInt;
    Exit;
  end;
  top := Q.head;
  Result := top^.data;
  Q.head := top^.next;
  if Q.head = nil then Q.tail := nil;
  Dispose(top);
end;

procedure ShowDynamicQueue(Q: TQueue);
var
  currentNode: PNode;
begin
  currentNode := Q.head;
  if currentNode = nil then
  begin
    writeln('Dinamucheskaya ochered pusta');
    Exit;
  end;

  writeln('Elementy dinamycheskoy ocheredy:');
  while currentNode <> nil do
  begin
    write(currentNode^.data, ' ');
    currentNode := currentNode^.next;
  end;
  writeln;
end;
//Статическая структура
procedure Enqueue(value: integer);
begin
  taill := taill + 1;
  staticQueue[taill] := value;
end;

function Dequeue: integer;
begin
  if headd = taill then
    raise Exception.Create('Ochered pusta');

  headd := headd + 1;
  Result := staticQueue[headd];
end;

procedure ShowStaticQueue;
var
  i: Integer;
begin
  writeln('Elementy statycheskoy ocheredy:');
  for i := (headd + 1) to taill do
    write(staticQueue[i], ' ');
  writeln;
end;

begin

  repeat
    writeln('1. Dobavit v ochered (dinamycheskaya struktura)');
    writeln('2. Udalit iz ocheredy (dinamycheskaya struktura)');
    writeln('3. Dobavit v ochered (statycheskaya struktura)');
    writeln('4. Udalit iz ocheredy (statycheskaya struktura)');
    writeln('5. Prosmotr statycheskoy ocheredy');
    writeln('6. Prosmotr dinamycheskoy ocheredy');
    writeln('7. Exit');
    write('Vvedite chislo (1-7): ');
    readln(choice);

    case choice of
      1:
      begin
        write('Vvedite znachenie: ');
        readln(value);
        PushTail(dynamicQueue, value);
      end;
      2:
      begin
        writeln('Udalennoe znachenue: ', Pop(dynamicQueue));
      end;
      3:
      begin
        write('Vvedite znachenie: ');
        readln(value);
        Enqueue(value);        
      end;
      4:
      begin
        writeln('Udalennoe znachenue: ', Dequeue);  
      end;
      5: ShowStaticQueue;
      6: ShowDynamicQueue(dynamicQueue);
      7: writeln('Exit...');
    else
      writeln('Nekorrektnoe znachenie. Povtorite popitku.');
    end;
  until choice = 7;
end.
