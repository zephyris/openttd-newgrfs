string=File.openAsString("");
lines=split(string, "\n");
header=smartSplit(lines[0], ",");
j=0;
for (i=1; i<lengthOf(lines); i++) {
	data=smartSplit(lines[i], ",");
	if (lengthOf(data)==lengthOf(header)) {
		printNml(data, header, j+1);
	}
	j++;
}
for (i=1; i<lengthOf(lines); i++) {
	data=smartSplit(lines[i], ",");
	if (lengthOf(data)==lengthOf(header)) {
		print(""+substring(data[3], 7, lengthOf(data[3])-1)+"\t\t\t:"+data[1]);
	}
}

function printNml(data, header, j) {
	print("//Engine "+j);
	print("spriteset (spriteset"+data[2]+", \""+data[0]+".png\") {");
	print("\ttemplate_magtr_8PT(0, 0)");
	print("}");
	print("");
	print("item(FEAT_TRAINS, item"+data[2]+") {");
	print("\tproperty {");
	for (i=3; i<lengthOf(data); i++) {
		pf=8;
		pl=pf*4-lengthOf(header[i]);
		ps="";
		for (k=0; k<floor(pl/pf); k++) {
			ps+="\t";
		}
		print("\t\t"+header[i]+":\t"+ps+data[i]+";");
	}
	print("\t}");
	print("\tgraphics {");
	print("\t\tdefault:\tspriteset"+data[2]+";");
	print("\t}");
	print("}");
	print("");
}

function smartSplit(string, delim) {
	string=replace(string, ", ", "###");
	array=split(string, ",");
	for (i=0; i<lengthOf(array); i++) {
		array[i]=replace(array[i], "###", ", ");
		if (startsWith(array[i], "\"")==true) {
			array[i]=substring(array[i], 1, lengthOf(array[i]));
		}
		if (endsWith(array[i], "\"")==true) {
			array[i]=substring(array[i], 0, lengthOf(array[i])-1);
		}
	}
	return array;
}
