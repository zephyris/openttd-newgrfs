path=getDirectory("");
open(pad(1, 4));
w=getWidth();
h=getHeight();
close();
newImage("Untitled", "RGB white", w*8+9, h+2, 1);
tgt=getImageID();
for (i=0; i<8; i++) {
	open(pad(i+1, 4));
	makeRectangle(0, 0, w, h);
	run("Copy");
	close();
	selectImage(tgt);
	makeRectangle((w+1)*i+1, 1, w, h);
	run("Paste");
}
saveAs("PNG", path+"combined_32bpp.png");
close();

function pad(n, l) {
	s=""+n;
	while (lengthOf(s)<l) {
		s="0"+s;
	}
	return s+".png";
}
