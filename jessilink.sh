#/bin/bash
prepend=$1
include=$2
YUI="/path/to/yuicompressor-2.4.6/build/yuicompressor-2.4.6.jar"
for file in $(find . -name *.js); do
        basename=$(basename $file)
        if [ "$include" != "" -a "$basename" != "$include" ]; then
		continue
	fi
	len=${#file}
	if [ ${file:$((len-7)):$((len-3))} = ".min.js" ]; then
		#skipping minified $file
		continue
	fi
	minfile=${file:0:$((len-3))}.min.js
	lenmin=${#minfile}
	java -jar $YUI -o $minfile $file
	echo "<script type=\"text/javascript\" language=\"javascript\" src=\""$prepend${minfile:1:$((lenmin-8))}_$(md5sum $file | cut -d ' ' -f 1).min.js"\"></script>"
done;

