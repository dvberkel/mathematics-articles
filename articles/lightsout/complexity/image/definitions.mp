verbatimtex
\documentclass{article}
\begin{document}
etex

prologues := 3;

numeric u, vertexradius, linewidth, radius;
color vertexcolor;
vertexradius := 2mm;
vertexcolor := 0.7white;
linewidth = 0.3mm;
u := 1cm; 
radius := 5mm;

ahlength := 2mm;
labeloffset := 1mm;

def vertex(expr p, flag) =
	path vertexpath;
	vertexpath = fullcircle scaled vertexradius shifted p;
	
	pickup pencircle scaled linewidth;
	
	if flag:
		fill vertexpath withcolor vertexcolor;
	else:
		fill vertexpath withcolor white;
	fi;
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

def loop(expr p,angle) =
	fullcircle scaled radius rotated (angle+180) shifted (p + (radius/2)*(dir (angle)));
enddef;

beginfig(1)
	numeric i;
	boolean flag[];
	path p[];
	
	z1 = (0,0); flag1 = true;
	z2 = (0,u); flag2 = true;
	
	p1 = z1{dir 60}..{dir 120}z2;
	p2 = z2{dir -120}..{dir -60}z1;
	p3 = loop(z1,-90);
	p4 = loop(z2,90);
	
	for i := 1 upto 4:
		centerarrow(p[i]);
	endfor;
	for i := 1 upto 2:
		vertex(z[i],flag[i]);
	endfor;

	label.rt( btex $2$ etex,point length(p[1])/2 of p[1]);
	label.lft(btex $2$ etex,point length(p[2])/2 of p[2]);
	label.bot(btex $2$ etex,point length(p[3])/2 of p[3]);
	label.top(btex $2$ etex,point length(p[4])/2 of p[4]);
endfig;

beginfig(2)
	numeric i;
	boolean flag[];
	path p[];
	
	z1 = (0,-u); flag1 = true;
	z2 = (0,u);  flag2 = true;
	z3 = (2u,0); flag3 = false;
	
	p1 = z1{dir 60}..{dir 120}z2;
	p2 = z2{dir -120}..{dir -60}z1;
	p3 = loop(z1,-90);
	p4 = loop(z2,90);
	p5 = z1--z3;
	p6 = z2--z3;
		
	for i := 1 upto 6:
		centerarrow(p[i]);
	endfor;
	for i := 1 upto 3:
		vertex(z[i],flag[i]);
	endfor;

	label.lft(btex $k_{1}$ etex,z1);
	label.lft(btex $k_{0}$ etex,z2);
	label.rt( btex $o$ etex,z3);
	label.rt( btex $2$ etex,point length(p[1])/2 of p[1]);
	label.lft(btex $2$ etex,point length(p[2])/2 of p[2]);
	label.bot(btex $2$ etex,point length(p[3])/2 of p[3]);
	label.top(btex $2$ etex,point length(p[4])/2 of p[4]);
	label.lrt(btex $2$ etex,point length(p[5])/2 of p[5]);
	label.urt(btex $1$ etex,point length(p[6])/2 of p[6]);
endfig;

beginfig(3)
	numeric i;
	boolean flag[];
	path p[];
	
	z0 = (-2u,0);  flag0 = false;
	z1 = (0,-u);   flag1 = true;
	z2 = (0,u);    flag2 = true;
	z3 = (2u,-2u); flag3 = false;
	z4 = (2u,2u);  flag4 = false;
	
	p1  = z1{dir 60}..{dir 120}z2;
	p2  = z2{dir -120}..{dir -60}z1;
	p3  = loop(z1,-90);
	p4  = loop(z2,90);
	p5  = z1--z0;
	p6  = z2--z0;
	p7  = z1--z3;
	p8  = z2--z3;
	p9  = z1--z4;
	p10 = z2--z4;
	
	for i := 1 upto 10:
		centerarrow(p[i]);
	endfor;
	for i := 0 upto 4:
		vertex(z[i],flag[i]);
	endfor;

	label.lft(btex $i$ etex,z0);
	label.lft(btex $k_{0}$ etex,z2);
	label.lft(btex $k_{1}$ etex,z1);
	label.rt( btex $o_{0}$ etex,z4);
	label.rt( btex $o_{n-1}$ etex,z3);
	label.rt(btex $2$ etex,point length(p[1])/2 of p[1]);
	label.lft(btex $2$ etex,point length(p[2])/2 of p[2]);
	label.bot(btex $2$ etex,point length(p[3])/2 of p[3]);
	label.top(btex $2$ etex,point length(p[4])/2 of p[4]);
	label.llft(btex $1$ etex,point length(p[5])/2 of p[5]);
	label.ulft(btex $2$ etex,point length(p[6])/2 of p[6]);
	label.bot(btex $2$ etex,point length(p[7])/2 of p[7]);
	label.urt(btex $1$ etex,point length(p[8])/2 of p[8]);
	label.lrt(btex $2$ etex,point length(p[9])/2 of p[9]);
	label.top(btex $1$ etex,point length(p[10])/2 of p[10]);
endfig;

beginfig(4)
	numeric i,j,beta,gamma;
	boolean flag[];
	pair w[];
	path p[];
	
	beta = 5; gamma = 20;
	
	w0 = (3/2*u,0);
	w1 = (0,3/2*u);
	w2 = (-3/2*u,0);
	w3 = (0,-3/2*u);
	
	for i := 0 upto 3:
		z[i] = w[i] rotated beta;
		flag[i] = true;
	endfor;
	z4 = (-3u,3u);  flag4 = false;
	z5 = (-3u,-3u); flag5 = false;
	z6 = (3u,0);    flag6 = false;
	
	for i := 0 upto 3:
		for j := 0 upto 2:
			p[3*i+j] = z[i]--z[4+j];
		endfor;
		for j := 0 upto 2:
			p[3*i+j+12] = z[i]{dir (135+beta-gamma + 45*j + 90*i)}..{dir (135+beta+gamma + 45*j+90*i)}z[(i+j+1) mod 4];
		endfor;
		p[i+24] = loop(z[i],90*i+beta)
	endfor;
	
	for i := 0 upto 11:
		centerarrow(p[i]);
	endfor;
%	for i := 12 upto 27:
%		centerarrow(p[i]);
%	endfor;
	for i := 0 upto 6:
		vertex(z[i],flag[i]);
	endfor;
	
	label.bot(btex $k_{0}$ etex,z0);
	label.top(btex $k_{1}$ etex,z1);
	label.lft(btex $k_{2}$ etex,z2);
	label.bot(btex $k_{3}$ etex,z3);
	label.lft(btex $i_{0}$ etex,z4);
	label.lft(btex $i_{1}$ etex,z5);
	label.rt( btex $o$ etex,z6);
	label.llft(btex $2$ etex,point length(p[0])/2 of p[0]);
	label.ulft(btex $2$ etex,point length(p[1])/2 of p[1]);
	label.ulft(btex $\mu(r_{0})$ etex,point length(p[2])/2 of p[2]);
	label.urt(btex $2$ etex,point length(p[3])/2 of p[3]);
	label.lrt(btex $1$ etex,point length(p[4])/2 of p[4]);
	label.top(btex $\mu(r_{1})$ etex,point length(p[5])/2 of p[5]);
	label.llft(btex $1$ etex,point length(p[6])/2 of p[6]);
	label.ulft(btex $2$ etex,point length(p[7])/2 of p[7]);
	label.ulft(btex $\mu(r_{2})$ etex,point length(p[8])/2 of p[8]);
	label.urt(btex $1$ etex,point length(p[9])/2 of p[9]);
	label.lrt(btex $1$ etex,point length(p[10])/2 of p[10]);
	label.lrt(btex $\mu(r_{3})$ etex,point length(p[11])/2 of p[11]);
	
endfig;

beginfig(5)
	numeric i;
	boolean flag[];
	path p[];
	
	z0 = (-2u,0); flag0 = false;
	z1 = (0,-u);  flag1 = true;
	z2 = (0,u);   flag2 = true;
	z3 = (2u,0);  flag3 = false;
	
	p1  = z1{dir 60}..{dir 120}z2;
	p2  = z2{dir -120}..{dir -60}z1;
	p3  = loop(z1,-90);
	p4  = loop(z2,90);
	p5  = z1--z0;
	p6  = z2--z0;
	p7  = z1--z3;
	p8  = z2--z3;
	
	for i := 1 upto 8:
		centerarrow(p[i]);
	endfor;
	for i := 0 upto 3:
		vertex(z[i],flag[i]);
	endfor;

	label.lft(btex $i$ etex,z0);
	label.lft(btex $k_{0}$ etex,z2);
	label.lft(btex $k_{1}$ etex,z1);
	label.rt( btex $o$ etex,z3);
	label.rt(btex $2$ etex,point length(p[1])/2 of p[1]);
	label.lft(btex $2$ etex,point length(p[2])/2 of p[2]);
	label.bot(btex $2$ etex,point length(p[3])/2 of p[3]);
	label.top(btex $2$ etex,point length(p[4])/2 of p[4]);
	label.llft(btex $1$ etex,point length(p[5])/2 of p[5]);
	label.ulft(btex $2$ etex,point length(p[6])/2 of p[6]);
	label.bot(btex $2$ etex,point length(p[7])/2 of p[7]);
	label.urt(btex $1$ etex,point length(p[8])/2 of p[8]);
endfig;

beginfig(6)
	numeric i;
	boolean flag[];
	path p[];
	
	z0 = (-2u,0); flag0 = false;
	z1 = (0,-u);  flag1 = true;
	z2 = (0,u);   flag2 = true;
	z3 = (2u,0);  flag3 = false;
	
	p1  = z1{dir 60}..{dir 120}z2;
	p2  = z2{dir -120}..{dir -60}z1;
	p3  = loop(z1,-90);
	p4  = loop(z2,90);
	p5  = z1--z0;
	p6  = z2--z0;
	p7  = z1--z3;
	p8  = z2--z3;
	
	for i := 1 upto 8:
		centerarrow(p[i]);
	endfor;
	for i := 0 upto 3:
		vertex(z[i],flag[i]);
	endfor;

	label.lft(btex $i$ etex,z0);
	label.lft(btex $k_{0}$ etex,z2);
	label.lft(btex $k_{1}$ etex,z1);
	label.rt( btex $o$ etex,z3);
	label.rt(btex $2$ etex,point length(p[1])/2 of p[1]);
	label.lft(btex $2$ etex,point length(p[2])/2 of p[2]);
	label.bot(btex $2$ etex,point length(p[3])/2 of p[3]);
	label.top(btex $2$ etex,point length(p[4])/2 of p[4]);
	label.llft(btex $1$ etex,point length(p[5])/2 of p[5]);
	label.ulft(btex $2$ etex,point length(p[6])/2 of p[6]);
	label.bot(btex $1$ etex,point length(p[7])/2 of p[7]);
	label.urt(btex $2$ etex,point length(p[8])/2 of p[8]);
endfig;

end;
