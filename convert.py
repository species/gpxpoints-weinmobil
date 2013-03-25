import subprocess
import os

for  i in range(0,200):
     subprocess.call(" grep -v logout original_data.csv | sed  '1p;/;"+str(i)+";/!d'| gpsbabel -i unicsv -f - -x transform,trk=wpt,del -o gpx -F "+str(i)+".gpx",shell=True)
     if os.path.getsize(str(i)+".gpx")==361:
         os.remove(str(i)+".gpx")
