function transition_matrix(F,k,m)
	I := IdentityMatrix(F,k);
	
	B := ZeroMatrix(F,k,k);
	s := Matrix(F,1,3,[1,1,1]);
	t := Matrix(F,1,2,[1,1]);
	InsertBlock(~B,t,1,1);
	for index := 2 to k-1 do
		InsertBlock(~B,s,index,index-1);
	end for;
	InsertBlock(~B,t,k,k-1);
	
	T := ZeroMatrix(F,k*m,k*m);
	for index := 0 to m-1 do
		if index lt m-1 then
			InsertBlock(~T,I,index*k+1,(index+1)*k+1);
			InsertBlock(~T,I,(m-1-index)*k+1,(m-1-(index+1))*k+1);
		end if;
		InsertBlock(~T,B,index*k+1,index*k+1);
	end for;
	
	return T;
end function;

function number_of_presses(v)
	presses := 0;
	for index := 1 to Degree(Parent(v)) do
		presses +:= Integers() ! v[index];
	end for;
	return presses;
end function;

function find_minimal_solution(T,s)
	v, Ker := Solution(T,-s);
	solution := v; minimum := number_of_presses(v);
	for w in Ker do
		if number_of_presses(v+w) lt minimum then
			solution := v+w;
			minimum := number_of_presses(solution);		
		end if;
	end for;
	return solution, Ker;
end function;

procedure show_vector(v,k,m)
	for row in [0..m-1] do
		for column in [0..k-1] do
			printf "%o ", v[row*k+column+1];
		end for;
		printf "\n";
	end for;
end procedure;

procedure show_kernel_table(q: max_rows := 20, max_columns := 10, column_offset := 2)
	F := Integers(q);
	max_columns := Min(max_rows,max_columns);
	
	printf "q = %o\n", q;
	printf " "^(column_offset+1);
	for column := 1 to max_columns do
		printf " %" cat IntegerToString(column_offset) cat "o", column;
	end for;
	printf "\n%" cat IntegerToString(column_offset) cat "o:" cat " %" cat IntegerToString(column_offset) cat "o\n", 1,0;
	for row := 2 to max_rows do
		printf "%" cat IntegerToString(column_offset) cat "o:", row;
		for column := 1 to Min(row,max_columns) do
			T := transition_matrix(F,row,column);
			Ker := Kernel(T);
			printf " %" cat IntegerToString(column_offset) cat "o", Dimension(Ker);
		end for;
		printf "\n";
	end for;
end procedure;

function find_period(q,column : verbose := false, max_period := 1000, data_file := "data.dat", save_result := false )
	F := Integers(q);
	if column mod 3 eq 2 then T := [1]; else T := [0]; end if;
	T cat:= [Dimension( Kernel( transition_matrix(F,2,column ) ) )];
	
	column_width := Floor(Log(column)/Log(10)+1); 
	format := "%4o %" cat IntegerToString(column_width) cat "o\n";
	if save_result then
		fprintf data_file, "q = %o column = %o\n" cat format^2, q, column, 1, T[1], 2, T[2];
	end if;
	if verbose then 
		printf "q = %o column = %o\n" cat format^2, q, column, 1, T[1], 2, T[2];
	end if;
	
	period := 2;
	while T ne [column,0] and period lt max_period do
		period +:= 1;
		T[1] := T[2];
		T[2] := Dimension( Kernel( transition_matrix(F,period,column) ) );		
		if save_result then
			fprintf data_file, format, period, T[2];
		end if;
		if verbose then
			printf format, period, T[2];
		end if;	
	end while;
	
	return period, T eq [column,0];
end function;

function guess_period(q,columns: verbose := false , loud := false)
	F := Integers(q);

	V := VectorSpace(F,2*columns);
	
	M := ZeroMatrix(F,2*columns,2*columns);
	
	B := ZeroMatrix(F,columns,columns);
	s := Matrix(F,1,3,[1,1,1]);
	t := Matrix(F,1,2,[1,1]);
	InsertBlock(~B,t,1,1);
	for index := 2 to columns-1 do
		InsertBlock(~B,s,index,index-1);
	end for;
	InsertBlock(~B,t,columns,columns-1);
	
	InsertBlock(~M,B,1,1);
	InsertBlock(~M,IdentityMatrix(F,columns),columns+1,1);
	InsertBlock(~M,IdentityMatrix(F,columns),1,columns+1);
	
	maximum := 1;
	for index := 1 to columns div 2 + columns mod 2 do
		v := V ! 0;
		v[index] := F ! 1;
		if loud then
			printf "%o\n", v;
		end if;		
		v := v*M;
		
		period := 1;
		while not &and[ v[i] eq F!0 : i in [1..columns] ] do
			if loud then
				printf "%o\n", v;
			end if;
			v *:= M;
			period +:= 1;
		end while;
		if loud then
			printf "%o\n\n", v;
		end if;		
		if verbose then
			printf "%2o %o\n", index, period;
		end if;
		if period gt maximum then
			maximum := period;
		end if;
	end for;
	return maximum+1;
end function;


/*
n := 5;
F := GF(3);

T := transition_matrix(F,n,n);

s := Vector(F,n^2,[
	0,0,0,0,0,
	0,0,0,0,0,
	1,0,2,0,1,
	0,0,0,0,0,
	0,0,0,0,0
]);

solution, Ker := find_minimal_solution(T,s);
show_vector(solution,n,n);
*/

//show_kernel_table(2 : max_columns:=25, max_rows:= 25);

/*
column := 3;
printf "column = %o\n", column;
for q in [n : n in [1..7] | IsPrime(n)] do
	printf "q = %2o period = %5o\n", q, find_period(q,column);
end for;
*/

/*
q := 7;
columns := 3;
rows := 84;

F := Integers(q);
T := transition_matrix(F,columns,rows);
Ker := Kernel(T);

data := [0 : i in [1..columns*rows]];
data[2] := 1;
v := Vector(F,columns*rows,data);
s := Solution(T,v);

show_vector(s,columns,rows);
*/

/*
Gamma := Graph<10|[{10,2},{10,1,3,4},{2,4},{2,3,5,6},{4,6},{4,5,7,8},{6,8},{7,8,9,10},{8,10},{8,9,1,2}]>;

q := 5;
F := Integers(q);

R := MatrixRing(F,#Vertices(Gamma));
T := R ! AdjacencyMatrix(Gamma);
T +:= Identity(R);
v := Vector(F,#Vertices(Gamma),[1 : i in [1..#Vertices(Gamma)]]);

s, Ker := Solution(T,-v);
s;
*/

/*
q := 2;
max_column := 10;

first_header := "column";
second_header := "period";

column_width := Max(Floor(Log(max_column)/Log(10)+1),#first_header);
format := "%" cat IntegerToString(column_width) cat "o %o\n";

printf "q = %o\n", q;
printf format, first_header, second_header;
for column := 1 to max_column do
	printf format, column, find_period(q,column);
end for;
*/

/*
q := 2;
F := Integers(q);

columns := 15;
rows := 23;

V := VectorSpace(F,columns*rows);

T := transition_matrix(F,columns,rows);
Ker := Kernel(T);

for row := 1 to rows do;
	w := [V.(column + (row-1)*columns) : column in [1..columns]];
	W := sub<V|w>;
	U := Complement(V,W);
	subKer := Ker meet U;
	printf "%2o %o\n", row, Dimension(subKer);
end for;
*/

/*
q := 5;
max_column := 25;

first_header := "column";
second_header := "period";

column_width := Max(Floor(Log(max_column)/Log(10)+1),#first_header);
format := "%" cat IntegerToString(column_width) cat "o %o\n";

printf "q = %o\n", q;
printf format, first_header, second_header;
printf format, 1, 3;
for column := 2 to max_column do
	printf format, column, guess_period(q,column);
end for;
*/

/*
q := 2; columns := 4;
F := Integers(q);

V := VectorSpace(F,2*columns);
W := {v : v in V};

M := ZeroMatrix(F,2*columns,2*columns);

B := ZeroMatrix(F,columns,columns);
s := Matrix(F,1,3,[1,1,1]);
t := Matrix(F,1,2,[1,1]);
InsertBlock(~B,t,1,1);
for index := 2 to columns-1 do
	InsertBlock(~B,s,index,index-1);
end for;
InsertBlock(~B,t,columns,columns-1);

InsertBlock(~M,B,1,1);
InsertBlock(~M,IdentityMatrix(F,columns),columns+1,1);
InsertBlock(~M,IdentityMatrix(F,columns),1,columns+1);

while not IsEmpty(W) do
	v := Random(W);
	W diff:= {v};

	start := v;
	repeat
		printf "%o\n", v;
		v *:= M;
		W diff:= {v};
	until v eq start;
	printf "\n";
end while;
*/

/*
n := 5; k := 12; m := 12; F := Integers(n);
T := transition_matrix(F,k,m);
Ker := Kernel(T);

a := &cat[ [ m-(column-1) + (row-1)*m : column in [1..m]] : row in [1..k] ];
b := [];
for i := 0 to k-1 do
	for j := 0 to i do
		if i eq j then
			b[i*m+i+1] := i*m+i+1;
		else
			b[i*m+j+1] := j*m+i+1;
			b[j*m+i+1] := i*m+j+1;
		end if;
	end for;
end for;
c := [ [ column + (k-row)*m : column in [1..m]] : row in [1..k]];
if k eq m then
	G := PermutationGroup<k*m|a,b>;
else
	G := PermutationGroup<k*m|a,c>;
end if;

M := [PermutationMatrix(F,g) : g in G];

maximum := 0; K := [];
for v in Ker do
	if number_of_presses(v) gt 0 then
		sym := &+[1 : m in M | v*m eq v];
		if sym gt maximum then
			maximum := sym;
			K := [v];
		elif sym eq maximum then
			Append(~K,v);
		end if;
	end if;
end for;
print K;

extrema := [n*k*m,0]; solutions := [[],[]];
for v in K do
	p := number_of_presses(v);
	if 0 lt p and p lt extrema[1] then
		extrema[1] := p;
		solutions[1] := [v];
	elif p eq extrema[1] then
		Append(~(solutions[1]),v);
	end if;
	if p gt extrema[2] then
		extrema[2] := p;
		solutions[2] := [v];
	elif p eq extrema[2] then
		Append(~(solutions[2]),v);
	end if;
end for;
for index := 1 to 2 do
	print extrema[index];
	for solution in solutions[index] do
		show_vector(solution,k,m);
		print "\n";
	end for;
end for;
*/
