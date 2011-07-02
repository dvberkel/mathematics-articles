verbatimtex
\documentclass[12pt]{article}
\begin{document}
etex

prologues := 3;

numeric vertexradius, linewidth;
color vertexcolor;
vertexradius := 1mm;
vertexcolor := 0.7white;
linewidth = 0.3mm;

ahlength := 1.5mm;
labeloffset := 1mm;

picture kill;

def vertex(expr p) =
	path vertexpath;
	vertexpath = fullcircle scaled vertexradius shifted p;
	
	pickup pencircle scaled linewidth;
	
	fill vertexpath withcolor vertexcolor;
	draw vertexpath;
enddef;

def centerarrow(expr P) =
	path q[]; numeric l;
	
	l := length(P);
	
	q1 = subpath (0,l/2) of P;
	q2 = subpath (l/2,l) of P;
	
	pickup pencircle scaled linewidth;
	
	draw q2;
	drawarrow q1;
enddef;

beginfig(1)
	numeric u, radius;
	u := 3cm; radius := 5mm;
	
	z2 = (0,0);
	z3 = (u,0);
	z1 = 1/2*(1,sqrt(3)) scaled u;
	
	centerarrow(z1{dir -140}..{dir -100}z2);
	centerarrow(z1{dir -40}..{dir -80}z3);
	centerarrow(z2{dir 40}..{dir 80}z1);
	centerarrow(z2..z3);
	centerarrow(z3{dir 140}..{dir 100}z1);
	centerarrow(fullcircle scaled radius rotated 120 shifted (z3 + (radius/2)*(dir -60)));

	vertex(z1);
	vertex(z2);
	vertex(z3);

	labeloffset := 2mm;

	label.top(btex $u$ etex,z1);
	label.llft(btex $v$ etex,z2);
	label.urt(btex $w$ etex,z3);
	
	kill = currentpicture;
endfig;

beginfig(2)
	numeric u, i, j, radius;
	u := 2.5cm; radius := 5mm;
	
	for i = 0 upto 2:
		for j = 0 upto 1:
			z[3*j+i+1] = (j*u,i*u);
		endfor;
	endfor;
	
	pickup pencircle scaled linewidth;
	
	for i = 1 upto 3:
		centerarrow(z[i]{dir 20}..{dir -20}z[i+3]);
		centerarrow(z[i+3]{dir -160}..{dir -200}z[i]);
	endfor;
	
	for j = 0 upto 1:
		for i = 1 upto 2:
			centerarrow(z[i+j*3]{dir 70}..{dir 110}z[i+1+j*3]);
			centerarrow(z[i+1+j*3]{dir -110}..{dir -70}z[i+j*3]);
		endfor;
	endfor;

	for i = 0 upto 2:
		centerarrow(fullcircle scaled radius rotated (45*(1-i)) shifted (z[i+1] + (radius/2)*(dir (-135 - 45*i))));
		centerarrow(reverse fullcircle scaled radius rotated (45*(1-i)) shifted (z[i+1] + (radius/2)*(dir (-135 - 45*i))));
		centerarrow(fullcircle scaled radius rotated (45*(i+3)) shifted (z[i+1+3] + (radius/2)*(dir (-45 + 45*i))));
		centerarrow(reverse fullcircle scaled radius rotated (45*(i+3)) shifted (z[i+1+3] + (radius/2)*(dir (-45 + 45*i))));
	endfor;

	for i = 1 upto 6:
		vertex(z[i]);
	endfor; 
	
	labeloffset := 2mm;

	label.llft(btex $(3,1)$ etex,z1);
	label.llft(btex $(2,1)$ etex,z2);
	label.llft(btex $(1,1)$ etex,z3);
	label.llft(btex $(3,2)$ etex,z4);
	label.llft(btex $(2,2)$ etex,z5);
	label.llft(btex $(1,2)$ etex,z6);
endfig;

beginfig(3)
	numeric u, i, j, radius;
	u := 2cm; radius := 5mm;
	
	for i = 0 upto 2:
		for j = 0 upto 1:
			z[3*j+i+1] = (i*u,j*u);
		endfor;
	endfor;
	
	pickup pencircle scaled linewidth;
	
	for i = 1 upto 3:
		draw z[i]--z[i+3];
	endfor;
	
	for j = 0 upto 1:
		for i = 1 upto 2:
			draw z[i+j*3]--z[i+1+j*3];
		endfor;
	endfor;

	for i = 0 upto 2:
		draw fullcircle scaled radius shifted (z[i+1] + (radius/2)*(dir (-135 + 45*i)));
		draw fullcircle scaled radius shifted (z[i+1+3] + (radius/2)*(dir (135 - 45*i)));
	endfor;

	for i = 1 upto 6:
		vertex(z[i]);
	endfor; 
	
	labeloffset := 2mm;
	
	label.ulft(btex $(2,1)$ etex,z1);
	label.ulft(btex $(2,2)$ etex,z2);
	label.ulft(btex $(2,3)$ etex,z3);
	label.llft(btex $(1,1)$ etex,z4);
	label.llft(btex $(1,2)$ etex,z5);
	label.llft(btex $(1,3)$ etex,z6);
endfig;

beginfig(4)
	numeric u, radius;
	u := 15mm; radius := 5mm;
	
	z1 = (0,u);
	z2 = (0,0);
	z3 = (0,-u);
	z4 = (-u,0);
	z5 = (u,0);
	
	centerarrow(z1--z2);
	centerarrow(z2--z3);
	centerarrow(fullcircle scaled radius rotated 90 shifted (z3 + (radius/2)*(dir -90)));
	centerarrow(z2--z4);
	centerarrow(z2--z5);

	vertex(z1);
	vertex(z2);
	vertex(z3);
	vertex(z4);
	vertex(z5);

	labeloffset := 2mm;

	label.urt(btex $u$ etex,z1);
	label.urt(btex $v$ etex,z2);
	label.urt(btex $w$ etex,z3);
	label.urt(btex $x$ etex,z4);
	label.urt(btex $y$ etex,z5);
endfig;

beginfig(5)
	numeric u, radius;
	u := 15mm; radius := 5mm;
	
	z1 = (0,u);
	z2 = (0,0);
	z3 = (0,-u);
	z4 = (-u,0);
	z5 = (u,0);
	
	centerarrow(reverse(z1--z2));
	centerarrow(reverse(z2--z3));
	centerarrow(reverse(fullcircle scaled radius rotated 90 shifted (z3 +(radius/2)*(dir -90))));
	centerarrow(reverse(z2--z4));
	centerarrow(reverse(z2--z5));

	vertex(z1);
	vertex(z2);
	vertex(z3);
	vertex(z4);
	vertex(z5);

	labeloffset := 2mm;

	label.urt(btex $u$ etex,z1);
	label.urt(btex $v$ etex,z2);
	label.urt(btex $w$ etex,z3);
	label.urt(btex $x$ etex,z4);
	label.urt(btex $y$ etex,z5);
endfig;

beginfig(6)
	numeric u, radius;
	u := 3cm; radius := 5mm;
	
	z2 = (0,0);
	z3 = (u,0);
	z1 = 1/2*(1,sqrt(3)) scaled u;
	
	centerarrow(z1{dir -140}..{dir -100}z2);
	centerarrow(z1--z2);
	centerarrow(z2{dir 40}..{dir 80}z1);
	centerarrow(z1{dir -80}..{dir -40}z3);
	centerarrow(z3{dir 100}..{dir 140}z1);
	centerarrow(z2--z3);
	centerarrow(fullcircle scaled radius rotated 60 shifted (z2 + (radius/2)*(dir -120)));

	vertex(z1);
	vertex(z2);
	vertex(z3);

	labeloffset := 2mm;

	label.top(btex $u$ etex,z1);
	label.ulft(btex $v$ etex,z2);
	label.urt(btex $w$ etex,z3);
endfig;

beginfig(7)
	numeric n, i, u, radius;
	u := 2cm; radius := 5mm;
	
	n := 6;
		
	for i = 0 upto n-1:
		z[i] = dir(-60*i+90) scaled u;
	endfor;

	for i = 1 upto n-1:
		centerarrow(z[i]--z[i-1]);
	endfor;
	centerarrow(z[0]--z[n-1]);

	for i = 0 upto n-1:
		centerarrow(fullcircle scaled radius rotated (-60*i-90) shifted (z[i] + (radius/2)*(dir (-60*i+90))));
	endfor;
	
	for i = 0 upto n-1:
		vertex(z[i]);
	endfor;

	labeloffset := 2mm;

	label.bot(btex $u$ etex,z0);
	label.llft(btex $v$ etex,z1);
	label.ulft(btex $w$ etex,z2);
	label.top(btex $x$ etex,z3);
	label.urt(btex $y$ etex,z4);
	label.lrt(btex $z$ etex,z5);
endfig;

beginfig(8)
	numeric u, radius;
	path p;
	u := 2cm; radius := 10mm;
	
	z = (0,0);
	p = fullcircle scaled radius rotated (225) shifted (z + (radius/2)*(dir (45)));

	centerarrow(p);	
	vertex(z);
	label.urt(btex $0$ etex,point length(p)/2 of p)
endfig;

beginfig(9)
	numeric u, radius;
	path p;
	u := 2cm; radius := 10mm;
	
	z = (0,0);
	p = fullcircle scaled radius rotated (225) shifted (z + (radius/2)*(dir (45)));

	centerarrow(p);	
	vertex(z);
	label.urt(btex $1$ etex,point length(p)/2 of p)
endfig;

beginfig(10)
	numeric u, radius;
	path p;
	u := 2cm; radius := 10mm;
	
	z = (0,0);
	p = fullcircle scaled radius rotated (225) shifted (z + (radius/2)*(dir (45)));

	centerarrow(p);	
	vertex(z);
	label.urt(btex $2$ etex,point length(p)/2 of p)
endfig;

end;
