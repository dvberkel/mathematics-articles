function next(M)
	r := NumberOfRows(M); c := NumberOfColumns(M);
	N := ZeroMatrix(BaseRing(M),r+1,c+1);
	
	InsertBlock(~N,M,1,1);
	N[r+1,c] := 1; N[r,c+1] := 1; N[r+1,c+1] := 1;
	
	return N;
end function;
