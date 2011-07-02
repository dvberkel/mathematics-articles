load "magma/lights-out.m";
load "magma/kernel.m";

procedure postscript(v)
	print "[";
	for i in [1 .. 5 * 23] do
		if i mod 5 eq 1 then
			printf "\t[";
		end if;
		value := true;
		if v[i] eq 0 then
			value := false;
		end if;
		printf "%o ", value;
		if i mod 5 eq 0 then
			print "]";
		end if;
	end for;
	print "]";
end procedure;

q := 2;
F := GF(q);

for n := 1 to 35 do
	dimensions, WnP, index := dimensionsOfKernel(F,n);
	printf "%3o %3o %o\n", n, index, #dimensions;
end for;

dimensions, _, _ := dimensionsOfKernel(F,5); dimensions;
Md := layout(F,5,#dimensions - 1);
Kd := Kernel(Md);
M7 := layout(F,5,7);
K7 := Kernel(M7);
M15 := layout(F,5,15);
K15 := Kernel(M15);

//v := Kd.1 + Kd.3;
//postscript(v);
