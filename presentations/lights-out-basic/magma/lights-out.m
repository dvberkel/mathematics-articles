function effectMatrix(F,n)
	if (n eq 1 or n eq 2) then
		return Matrix(F,n,n,[1,1,1,1][1..n^2]);
	end if;
	
	r2 := Matrix(F,1,2,[1,1]);
	r3 := Matrix(F,1,3,[1,1,1]);

	En := ZeroMatrix(F,n,n);
	InsertBlock(~En,r2,1,1);
	for i := 2 to n-1 do
		InsertBlock(~En,r3,i,i-1);
	end for;
	InsertBlock(~En,r2,n,n-1);
	
	return En;	
end function;

function windowMatrix(F,n)
	On := ZeroMatrix(F,n,n);
	In := IdentityMatrix(F,n);
	En := effectMatrix(F,n);
	
	Wn := ZeroMatrix(F,2*n,2*n);
	InsertBlock(~Wn,En,1,1);
	InsertBlock(~Wn,In,1,n+1);
	InsertBlock(~Wn,In,n+1,1);
	InsertBlock(~Wn,On,n+1,n+1);
	
	return Wn;
end function;

function indexOf(start,finish)
	current := start;
	index := 1;
	while current ne finish do
		current := current * start;
		index := index + 1;
	end while;
	return index;
end function;

function dimensionsOfKernel(F,n)
	Wn := windowMatrix(F,n);

	I2n := IdentityMatrix(F,2*n);
	power := I2n; dimensions := [];
	repeat
		EnP := Submatrix(power,1,1,n,n);
		dimension := Dimension(Kernel(EnP));
		Append(~dimensions,dimension);
		power := power * Wn;
	until dimension eq n;
	return dimensions, power, indexOf(power,I2n);
end function;

q := 2;
F := GF(q);

for n := 1 to 5 do
	dimensions, WnP, index := dimensionsOfKernel(F,n);
	printf "%5o %o\n", index, dimensions;
end for;
