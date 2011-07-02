/*
 * Solving the matrix recursion
 * 	x_{n+2} = x_{n+1}*E + x_{n}
 * with initial conditions
 *	x_0 = 0, x_1 = I
 *
 */

function makeE(c,q)
	F := GF(2);
	E := ZeroMatrix(F,c,c);
	s := Matrix(F,1,3,[1,1,1]);
	t := Matrix(F,1,2,[1,1]);
	InsertBlock(~E,t,1,1);
	for row := 2 to c-1 do
		InsertBlock(~E,s,row,row-1);
	end for;
	InsertBlock(~E,t,c,c-1);
	
	return E;
end function;

q := 2;
c := 4;
for c in [2..10] do
print "c=", c;

F  := GF(q);
FA := FreeAlgebra(F,c*c);

K := MatrixAlgebra(FA,c);
X := Matrix(FA,c,c,[FA.i : i in [1..c^2]]);
G := GL(c,q);
E := makeE(c,q);

for P in G do
	if X*(K!(P^-1)) - (K!P)*X eq X*(K!E) then
		print c, P;
		print "-"^50;
		break P;
	end if;
end for;
end for;
