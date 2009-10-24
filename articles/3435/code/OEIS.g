next := function(coefficients, b)
	local i;
	coefficients[1] := coefficients[1] + 1;
	i := 1;
	while coefficients[i] = b do
		coefficients[i] := 0;
		i := i + 1;
		if (i <= Length(coefficients)) then
			coefficients[i] := coefficients[i] + 1;
		else
			Add(coefficients, 1);
		fi;
	od;
	return coefficients;
end;

munchausen := function(coefficients)
	local sum, coefficient;
	sum := 0;
	for coefficient in coefficients do
		sum := sum + coefficient^coefficient;
	od;
	return sum;
end;

for b in [2..10] do
	max := 2*b^b;
	n := 1;	coefficients := [1];
	while n <= max do
		sum := munchausen(coefficients);
	
		if (n = sum) then
			Print(n, "\n");
		fi;
		
		n := n + 1; 
		coefficients := next(coefficients, b);
	od;
od;
