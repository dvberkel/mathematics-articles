function chase_matrix(F,r)
	I := IdentityMatrix(F,r);
	
	B := ZeroMatrix(F,r,r);
	s := Matrix(F,1,3,[1,1,1]);
	t := Matrix(F,1,2,[1,1]);
	InsertBlock(~B,t,1,1);
	for index := 2 to r-1 do
		InsertBlock(~B,s,index,index-1);
	end for;
	InsertBlock(~B,t,r,r-1);
	
	T := ZeroMatrix(F,2*r,2*r);
	InsertBlock(~T,B,1,1);
	InsertBlock(~T,I,r+1,1);
	InsertBlock(~T,I,1,r+1);
	
	return T;
end function;

F := GF(5);
r := 3;
for r in [2..10] do
	T := chase_matrix(F,r);
	X := IdentityMatrix(F,2*r);
	Y := X; n := 0;
	repeat
		Y *:= T;
		n +:= 1;
	until Y eq X;
	print r, n;
end for;

