dumpSpriteLocations(5);

function dumpSpriteLocations(md) {
	for (y=0; y<getHeight(); y++) {
		for (x=0; x<getWidth(); x++) {
			v=getPixel(x, y);
			if (v!=255) {
				xx=0;
				v=getPixel(x+xx, y);
				while(v!=255 && x+xx<getWidth()) {
					xx++;
					v=getPixel(x+xx, y);
				}
				yy=0;
				v=getPixel(x, y+yy);
				while(v!=255 && y+yy<getHeight()) {
					yy++;
					v=getPixel(x, y+yy);
				}
				makeRectangle(x, y, xx, yy);
				setColor(255);
				fill();
				run("Select None");
				if (xx>md && yy>md) {
					print("["+x+", "+y+", "+xx+", "+yy+", "+-32+", "+0+"]");
				}
			}
		}
	}
}
