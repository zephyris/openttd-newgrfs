r=newArray(0, 16, 32, 48, 64, 80, 100, 116, 132, 148, 168, 184, 200, 216, 232, 252, 52, 68, 88, 108, 132, 156, 176, 204, 48, 64, 80, 96, 120, 148, 176, 204, 72, 88, 104, 124, 152, 184, 212, 244, 64, 88, 112, 136, 160, 188, 204, 220, 236, 252, 252, 252, 252, 76, 96, 116, 136, 156, 176, 196, 68, 96, 128, 156, 184, 212, 232, 252, 252, 252, 32, 64, 84, 108, 128, 148, 168, 184, 196, 212, 8, 16, 32, 48, 64, 84, 104, 128, 28, 44, 60, 80, 104, 128, 152, 180, 16, 32, 56, 76, 96, 120, 152, 184, 32, 56, 72, 88, 104, 124, 140, 160, 76, 96, 116, 136, 164, 184, 204, 212, 224, 236, 80, 100, 120, 140, 160, 184, 36, 48, 64, 80, 100, 132, 172, 212, 40, 64, 88, 104, 120, 140, 160, 188, 0, 0, 0, 0, 0, 24, 56, 88, 128, 188, 16, 24, 40, 52, 80, 116, 156, 204, 172, 212, 252, 252, 252, 252, 252, 252, 72, 92, 112, 140, 168, 200, 208, 232, 60, 92, 128, 160, 196, 224, 252, 252, 252, 252, 252, 252, 252, 252, 204, 228, 252, 252, 252, 252, 8, 12, 20, 28, 40, 56, 72, 100, 92, 108, 124, 144, 224, 200, 180, 132, 88, 244, 244, 244, 244, 244, 244, 244, 244, 244, 244, 244, 244, 76, 108, 144, 176, 210, 252, 252, 252, 252, 252, 252, 252, 64, 255, 48, 64, 80, 255, 32, 36, 40, 44, 48, 72, 100, 216, 96, 68, 255);
g=newArray(0, 16, 32, 48, 64, 80, 100, 116, 132, 148, 168, 184, 200, 216, 232, 252, 60, 76, 96, 116, 140, 160, 184, 208, 44, 60, 76, 92, 120, 148, 176, 204, 44, 60, 80, 104, 132, 160, 188, 220, 0, 4, 16, 32, 56, 84, 104, 132, 156, 188, 208, 232, 252, 40, 60, 88, 116, 136, 156, 180, 24, 44, 68, 96, 120, 156, 184, 212, 248, 252, 4, 20, 28, 44, 56, 72, 92, 108, 128, 148, 52, 64, 80, 96, 112, 132, 148, 168, 52, 68, 88, 104, 124, 148, 176, 204, 52, 72, 96, 116, 136, 164, 192, 220, 24, 28, 40, 52, 64, 84, 108, 128, 40, 52, 68, 84, 96, 112, 128, 148, 168, 188, 28, 40, 56, 76, 100, 136, 40, 52, 64, 80, 100, 132, 172, 212, 20, 44, 64, 76, 88, 104, 136, 168, 24, 36, 52, 72, 96, 120, 144, 168, 196, 224, 64, 80, 96, 112, 140, 172, 204, 240, 52, 52, 52, 100, 144, 184, 216, 244, 20, 44, 68, 100, 136, 176, 184, 208, 0, 0, 0, 0, 0, 0, 0, 80, 108, 136, 164, 192, 220, 252, 136, 144, 156, 176, 196, 216, 24, 36, 52, 68, 92, 120, 152, 172, 156, 176, 200, 224, 244, 236, 220, 188, 152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24, 44, 72, 108, 146, 60, 84, 104, 124, 148, 172, 196, 0, 0, 48, 64, 80, 255, 68, 72, 76, 80, 84, 100, 132, 244, 128, 96, 255);
b=newArray(255, 16, 32, 48, 64, 80, 100, 116, 132, 148, 168, 184, 200, 216, 232, 252, 72, 92, 112, 132, 152, 172, 196, 220, 4, 12, 20, 28, 64, 100, 132, 168, 4, 20, 44, 72, 92, 120, 148, 176, 4, 16, 32, 52, 76, 108, 124, 144, 164, 192, 0, 60, 128, 0, 8, 28, 56, 80, 108, 136, 0, 4, 8, 16, 24, 32, 16, 0, 128, 192, 0, 8, 16, 28, 40, 56, 76, 88, 108, 128, 0, 0, 4, 4, 12, 20, 28, 44, 24, 32, 48, 60, 76, 92, 108, 124, 24, 44, 72, 88, 108, 136, 168, 200, 0, 0, 4, 12, 24, 44, 64, 88, 16, 24, 40, 56, 64, 80, 96, 112, 128, 148, 4, 20, 40, 64, 96, 136, 68, 84, 100, 116, 136, 164, 192, 224, 112, 144, 172, 196, 224, 252, 252, 252, 108, 132, 160, 184, 212, 220, 232, 240, 252, 252, 96, 108, 120, 132, 160, 192, 220, 252, 52, 52, 52, 88, 124, 160, 200, 236, 112, 140, 168, 196, 224, 248, 255, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 4, 0, 48, 100, 152, 88, 104, 124, 140, 164, 188, 216, 224, 52, 64, 76, 92, 252, 248, 236, 216, 172, 244, 244, 244, 244, 244, 244, 244, 244, 244, 244, 244, 244, 8, 24, 52, 84, 126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 112, 116, 120, 124, 128, 144, 168, 252, 164, 140, 255);

e=newArray(227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 254);
n=newArray(0, 255, 80, 81, 82, 83, 84, 85, 86, 87, 198, 199, 200, 201, 202, 203, 204, 205, 255);
//make8bpp(r, g, b, e, n, 1);

path=getDirectory("");
processDirectory(path);

function processDirectory(path) {
	files=getFileList(path);
	for (i=0; i<lengthOf(files); i++) {
		if (File.isDirectory(path+files[i])==true) {
			processDirectory(""+path+files[i]);
		} else if(endsWith(files[i], "_32bpp.png")==true) {
			open(path+files[i]);
			make8bpp(r, g, b, e, n, 1);
			saveAs("PNG", ""+path+substring(files[i], 0, lengthOf(files[i])-lengthOf("_32bpp.png"))+"_8bpp");
			close();
		}
	}
}

//r, g, b = arrays of valid r[i]g[i]b[i] values. The length of r, g and b must be the same.
//e = indices of values in the valid rgb value arrays to exclude from the final image
//n = indices of values in the valid rgb value arrays to exclude from dithering
//    (i.e. if the current pixel value exactly matches the rgb values of one of the indices in this array then do not allow it to be dithered)
//d = dithering factor (0 to 1)
function make8bpp(r, g, b, e, n, dither) {
	run("RGB Color");

	//Loop through image and identify pixels that should be excluded from dithering
	//Record in an array
	ddither=newArray(getWidth()*getHeight());
	//Loop through pixels
	for (y=0; y<getHeight(); y++) {
		for (x=0; x<getWidth(); x++) {
			//Get RGB value of current pixel
			rgb=getRgb(x, y);
			ddither[x+y*getWidth()]=-1;
			//Loop through list of indices to exclude from dithering
			for (j=0; j<lengthOf(n); j++)  {
				//If the RGB value of the pixel matches the RGB value of an index then record that index in ddither for the appropriate pixel
				if (rgb[0]==r[n[j]] && rgb[1]==g[n[j]] && rgb[2]==b[n[j]]) {
					ddither[x+y*getWidth()]=n[j];
				}
			}
		}
	}

	//Set up the dithering array reference
	//Sierra dithering http://www.tannerhelland.com/4660/dithering-eleven-algorithms-source-code/
	//dx and dy are the x/y size of the error propogation matrix
	//dox and doy are the origin (i.e. the location of the pixel currently being analysed)
	//da is the actual error propogation matrix, and df is the division factor for normalisation of the matrix
	dx=5;
	dy=3;
	dox=2;
	doy=0;
	da=newArray(-1, -1, -1, 5, 3,
	    2, 4, 5, 4, 2,
	    0, 2, 3, 2, 0);
	df=32;

	//Do the dithering
	//Loop through all image pixels
	for (y=0; y<getHeight(); y++) {
		for (x=0; x<getWidth(); x++) {
			//If the pixel is not marked as do not dither
			if (ddither[x+y*getWidth()]==-1) {
				//Get the RGB value and determine the most similar colour in the indexed pallete by euclidian RGB distance
				rgb=getRgb(x, y);
				//mind is the current minimum distance, drgb is the error in rgb for the best match, and index is the index of the best match
				mind=255*255*255;
				drgb=newArray(3);
				index=0;
				//Loop through all entries in the palette
				for (i=0; i<lengthOf(r); i++) {
					//Determine the euclidian rgb distance
					d=pow(pow(rgb[0]-r[i], 2)+pow(rgb[1]-g[i], 2)+pow(rgb[2]-b[i], 2), 0.5);
					//If the distance is shorter than previously found
					if (d<mind) {
						//Loop and check whether that palette index is marked to be excluded from the final image
						exclude=false;
						//Loop through the exclude list
						for (j=0; j<lengthOf(e); j++) {
							//Mark as excluded if it matches
							if (e[j]==i) {
								exclude=true;
							}
						}
						//So long as the palette entry is not excluded from the final image redetermine mind, drgb and index
						if (exclude==false) {
							mind=d;
							drgb[0]=rgb[0]-r[i];
							drgb[1]=rgb[1]-g[i];
							drgb[2]=rgb[2]-b[i];
							index=i;
						}
						//If mind==0 then the absolute best match has been found, so set i to length of r to skip further analysis
						if (mind==0) {
							i=lengthOf(r);
						}
					}
				}
				//Set the pixel to an rgb value equal to the brightness of the selected palette index
				setPixel(x, y, (index&0xff)<<16+(index&0xff)<<8+(index&0xff)<<0);
				//Do the actual dithering
				//Diffuse errors according to the dithering matrix
				//Loop through the pixels which are in the dithering matrix
				for (tdy=0; tdy<dy; tdy++) {
					for (tdx=0; tdx<dx; tdx++) {
						//If the dithering matrix entry is defined (i.e is not -1)
						if (da[tdx+tdy*dx]!=-1) {
							//If the pixel is within the bounds of the image
							if (x+tdx-dox>=0 && x+tdx-dox<getWidth() && y+tdy-doy>=0 && y+tdy-doy<getHeight()) {
								//And if the pixel is not marked as do not dither
								if (ddither[x+tdx-dox+(y+tdy-doy)*getWidth()]==-1) {
									//Get the pixel value of the pixels to diffuse errors to
									rgb=getRgb(x+tdx-dox, y+tdy-doy);
									//Diffuse the errors to the pixel value according to the values in the da diffusion matrix and df
									rgb[0]=maxOf(minOf(rgb[0]+dither*drgb[0]*da[tdx+tdy*dx]/df, 255), 0);
									rgb[1]=maxOf(minOf(rgb[1]+dither*drgb[1]*da[tdx+tdy*dx]/df, 255), 0);
									rgb[2]=maxOf(minOf(rgb[2]+dither*drgb[2]*da[tdx+tdy*dx]/df, 255), 0);
									//Reset the adjusted pixel value
									setRgb(x+tdx-dox, y+tdy-doy, rgb);
								}
							}
						}
					}
				}
			} else {
				//If the pixel was marked as do not dither then just set it to a brightness equivalent to the correct index
				setPixel(x, y, (ddither[x+y*getWidth()]&0xff)<<16+(ddither[x+y*getWidth()]&0xff)<<8+(ddither[x+y*getWidth()]&0xff)<<0);
			}
			//Update display to show a visual display of progress
			updateDisplay();
		}
	}
	//Finish by setting the image to 8bit
	//Takes the pixel brightnesses and sets the 8bpp pixel value to that brightness
	run("8-bit");
	//Apply the palette as a LUT to apply the correct final colours
	setLut(r, g, b);
}

function getRgb(x, y) {
	rgb=newArray(3);
	v=getPixel(x, y);
	rgb[0]=(v>>16)&0xff;
	rgb[1]=(v>>8)&0xff;
	rgb[2]=(v>>0)&0xff;
	return rgb;
}

function setRgb(x, y, rgb) {
	r=(rgb[0]&0xff)<<16;
	g=(rgb[1]&0xff)<<8;
	b=(rgb[2]&0xff)<<0;
	setPixel(x, y, r+g+b);
}
