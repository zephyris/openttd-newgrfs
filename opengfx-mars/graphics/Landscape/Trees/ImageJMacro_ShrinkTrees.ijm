tw=32;
th=64;
oh=58;
factor=0.5;
shrinkTree();

function shrinkTree() {
	for (x=0; x<getWidth(); x+=tw+1) {
		makeRectangle(x, 0, tw, oh);
		run("Duplicate...", "title=temp");
		run("Size...", "width="+getWidth()*factor+" height="+getHeight()*factor+" constrain interpolation=None");
		nw=getWidth();
		nh=getHeight();
		run("Select All");
		run("Copy");
		close();
		v=255>>16+255>>8+255;
		for (a=0; a<tw; a++) {
			for (b=0; b<th; b++) {
				setPixel(a+x, b, v);
			}
		}
		makeRectangle(x, 0, tw, th);
		setColor(0);
		fill();
		makeRectangle(x+(tw-nw)/2, oh-nh, nw, nh);
		run("Paste");
	}
}
