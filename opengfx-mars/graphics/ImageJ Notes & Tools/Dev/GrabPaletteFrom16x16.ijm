r=newArray(256);
g=newArray(256);
b=newArray(256);
for (i=0; i<256; i++) {
	x=i%16;
	y=floor(i/16);
	v=getPixel(x, y);
	r[i]=(v>>16)&0xff;
	g[i]=(v>>8)&0xff;
	b[i]=(v>>0)&0xff;
}
rs="r=newArray(";
gs="g=newArray(";
bs="b=newArray(";
delim="";
for (i=0; i<lengthOf(r); i++) {
	rs+=""+delim+r[i];
	gs+=""+delim+g[i];
	bs+=""+delim+b[i];
	delim=", ";
}
rs+=");";
gs+=");";
bs+=");";
print(rs);
print(gs);
print(bs);
