var
  i: Integer; 
  i_ptr: ^Integer; 

begin
  i := 2; 
  i_ptr := @i; 

  WriteLn(i_ptr^); 
end.