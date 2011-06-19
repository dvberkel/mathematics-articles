load "magma/lights-out.m";

function layout(F, c, r)
	M := ZeroMatrix(F, c * r, c * r);
	
	Ec := effectMatrix(F,c);
	for index in [1..r] do
		InsertBlock(~M, Ec, 1 + (index - 1) * c,1 + (index - 1) * c);
	end for;
	
	Ic := IdentityMatrix(F,c);
	for index in [1..r-1] do
		InsertBlock(~M, Ic, 1 + index * c, 1 + (index - 1) * c);
		InsertBlock(~M, Ic, 1 + (index - 1) * c, 1 + index * c);
	end for;

	return M;
end function;
