// Example 1
standardWidth := 50;

procedure exampleBreak(n : width := standardWidth)
	header := "[ Example " cat IntegerToString(n) cat " ]";
	width -:= #header;
	printf "\n%o%o\n\n", header, "*"^width;
end procedure;

procedure exampleDivider(: width := standardWidth)
	printf "\n%o\n\n", "-"^width;
end procedure;

exampleBreak(1);

printf "Given M and v determine s such that s*M = v\n\n";

R := GF(3);

M := Matrix(R,3,3,[0,1,1,1,0,1,1,0,1]);
v := Vector(R,3,[2,1,0]);

printf "M := \n%o\n\n", M;
printf "v := %o\n\n", v;

Im := Image(M);
if v in Im then
	s, Ker := Solution(M,-v);
	for k in Ker do
		printf "%o*M = %o\n", s+k, -v;
	end for;
else
	printf "v not in Im(M)\n";
end if;

exampleDivider();

printf "Image and Kernel are not orthogonal\n\n";

for w in Basis(Im) do
	for k in Basis(Ker) do
		dot := &+[ w[i] * k[i] : i in [1..Degree(w)] ];
		if dot ne 0 then
			printf  "%o * %o = %o\n", w, k, dot;
		end if;
	end for;
end for;

exampleBreak(2);

m := 2^4*3^3*5^2*7;

R := [Integers(tuple[1]): tuple in Factorization(m)] cat [Integers(m)];
n := 6;
data := [
	1,1,0,1,0,0,
	1,1,1,0,1,0,
	0,1,1,0,0,1,
	1,0,0,1,1,0,
	0,1,0,1,1,1,
	0,0,1,0,1,1
];

M := [* *]; Ker := [* *];
for ring in R do
	m := Matrix(ring,n,n,data);
	Append(~M,m);
	Append(~Ker,Kernel(m));
end for;

Ker;

exampleBreak(3);

printf "Determinant of the window matrix W_c eq (-1)^c\n\n";

function windowMatrix(c,R)
	if c eq 1 then
		W := Matrix(R,2*c,2*c,[1,1,1,0]);
	elif c eq 2 then
		W := Matrix(R,2*c,2*c,[1,1,1,0,1,1,0,1,1,0,0,0,0,1,0,0]);
	else
		E := ZeroMatrix(R,c,c); block := Matrix(R,1,3,[1,1,1]);
		E[1,1] := R!1; E[1,2] := R!1;
		for row in [2..c-1] do
			InsertBlock(~E,block,row,row-1);
		end for;
		E[c,c-1] := R!1; E[c,c] := R!1;
		
		W := ZeroMatrix(R,2*c,2*c);
		InsertBlock(~W,E,1,1);
		InsertBlock(~W,IdentityMatrix(R,c),c+1,1);
		InsertBlock(~W,IdentityMatrix(R,c),1,c+1);		
	end if;
	return W;
end function;

R := GF(3);
for c in [1..5] do
	W := windowMatrix(c,R);
	
	printf "W_%o :=\n%o\n\n", c, W;
	printf "Det(W_%o) = %o\n\n", c, Determinant(W);
end for;
