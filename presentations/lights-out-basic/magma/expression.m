q := 2;
F := GF(q);

R<E> := PolynomialRing(F);

function next(R,f0,f1)
	return f1,f0+f1*R.1;
end function;

f0 := R!0;
f1 := R!1;
print f0;
for step := 1 to 64 do
	print f1;
	f0, f1 := next(R,f0,f1);
end for;
