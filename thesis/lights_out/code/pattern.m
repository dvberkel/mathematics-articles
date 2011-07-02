q := 3;
R := Integers(q);

MAX := 1000;
n := 20;

m := [Ceiling(Log(n)/Log(10)),Ceiling(Log(MAX)/Log(10))];
format := Sprintf("dimension %%%oo occurred %%%oo times\n", m[1], m[2]);


/*
denominator := 17;
for chance in [i/denominator : i in [denominator-1 .. 1 by -1]] do
	dimensionCount := [];
	for i in [1..MAX] do
		Gamma := RandomDigraph(n,chance);
	
		T := MatrixAlgebra(R,n) ! AdjacencyMatrix(Gamma);
		Ker := Kernel(T);
		
		dimension := Dimension(Ker);
		if IsDefined(dimensionCount, dimension+1) then
			dimensionCount[dimension+1] +:= 1;
		else
			dimensionCount[dimension+1] := 1;
		end if;
	end for;
	
	count := [];
	for dimension in [1..#dimensionCount] do
		if IsDefined(dimensionCount,dimension) then
			Append(~count,<dimension-1,dimensionCount[dimension]>);
		end if;
	end for;
	
	printf "chance = %o\n", chance;
	for tuple in count do
		printf format, tuple[1], tuple[2];
	end for;
end for;
*/


/*
count := 0;
for i in [1..MAX] do
	Gamma := [RandomDigraph(n,1/3)];
	Append(~Gamma,IncidenceDigraph(-1*IncidenceMatrix(Gamma[1])));
	
	dimension := [];
	for G in Gamma do
		T := MatrixAlgebra(R,n) ! AdjacencyMatrix(G);
		Ker := Kernel(T);
		
		Append(~dimension,Dimension(Ker));
	end for;
	if dimension[1] eq dimension[2] then
		count +:= 1;
	end if;
end for;
print count, MAX;
*/

/*
Gamma := [RandomDigraph(5,1/3)];
Append(~Gamma,IncidenceDigraph(-1*IncidenceMatrix(Gamma[1])));
Ker := [];
for G in Gamma do
	T := MatrixAlgebra(R,#VertexSet(G)) ! AdjacencyMatrix(G);
	Append(~Ker,Kernel(T));
end for;
Ker;
*/

Gamma := Graph<5|[{5,2},{1,3},{2,4},{3,5},{4,1}]>;
T := MatrixAlgebra(R,#VertexSet(Gamma)) ! AdjacencyMatrix(Gamma);
T := T + IdentityMatrix(R,#VertexSet(Gamma));
Ker := Kernel(T);
