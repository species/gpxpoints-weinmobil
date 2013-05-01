#!/bin/bash

for i in `seq 0 200`; do
	grep -v logout original_data.csv | sed  "1p;/;$i;/!d" > single/"$i".csv
	awk "/login/{n++}{print >\"single/$i.out\" n \".csv\" }" single/"$i".csv
	rm single/"$i".csv
done

rm `find . -size 37c`
rm `find . -size 54c`

cd single
echo "date;time;notes;name;lat;lon;comment" > startstring
for i in `ls -1 *csv`; do
	if ! head -1 $i|grep -q "date;time;notes;name;lat;lon;comment"; then
		cat startstring $i > n$i
		rm $i
	fi
	cat n$i | gpsbabel -i unicsv -f - -x transform,trk=wpt,del -o gpx -F$i.gpx
done

#rm `find . -size 361c`

#     subprocess.call(" grep -v logout original_data.csv | sed  '1p;/;"+str(i)+";/!d'| gpsbabel -i unicsv -f - -x transform,trk=wpt,del -o gpx -F "+str(i)+".gpx",shell=True)
#     if os.path.getsize(str(i)+".gpx")==361:
#         os.remove(str(i)+".gpx")
