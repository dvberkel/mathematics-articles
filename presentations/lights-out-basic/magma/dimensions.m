load "magma/lights-out.m";

q := 2;
F := GF(q);

for n := 1 to 35 do
	dimensions, WnP, index := dimensionsOfKernel(F,n);
	printf "%3o %3o %o\n", n, index, #dimensions;
end for;
