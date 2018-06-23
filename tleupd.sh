#!/bin/sh

echo "TLE File Creator"
echo ""
echo "Downloading Celestrak TLE Files"
wget http://www.celestrak.com/NORAD/elements/musson.txt
wget http://www.celestrak.com/NORAD/elements/stations.txt
wget http://www.celestrak.com/NORAD/elements/amateur.txt
wget http://www.celestrak.com/NORAD/elements/weather.txt
wget http://www.celestrak.com/NORAD/elements/noaa.txt
wget http://www.amsat.org/amsat/ftp/keps/current/nasabare.txt
echo "Searching for NORAD IDs and Creating Favorite TLE File"
echo "ISS (ZARYA)" >> fav.txt
egrep -A1 -w '25544U' stations.txt >> fav.txt
echo "PCSAT (NO-44)" >> fav.txt
egrep -A1 -w '26931U' amateur.txt >> fav.txt
echo "SAUDISAT 1C (SO-50)" >> fav.txt
egrep -A1 -w '27607U' amateur.txt >> fav.txt
echo "NOAA 15 [B]" >> fav.txt
egrep -A1 -w '25338U' noaa.txt >> fav.txt
echo "NOAA 18 [B]" >> fav.txt
egrep -A1 -w '28654U' noaa.txt >> fav.txt
echo "NOAA 19 [+]" >> fav.txt
egrep -A1 -w '33591U' noaa.txt >> fav.txt
echo "METEOR-M 1" >> fav.txt
egrep -A1 -w '35865U' weather.txt >> fav.txt
echo "METEOR-M 2" >> fav.txt
egrep -A1 -w '40069U' weather.txt >> fav.txt
echo "PSAT" >> fav.txt
egrep -A1 -w '40654U' nasabare.txt >> fav.txt
echo "FOX-1A" >> fav.txt
egrep -A1 -w '40967U' nasabare.txt >> fav.txt
echo "FOX-1B" >> fav.txt
egrep -A1 -w '43017U' nasabare.txt >> fav.txt
echo "FOX-1D" >> fav.txt
egrep -A1 -w '43137U' nasabare.txt >> fav.txt
echo "LILACSAT 2" >> fav.txt
egrep -A1 -w '40908U' amateur.txt >> fav.txt
echo "FUNCUBE-1 (AO-73)" >> fav.txt
egrep -A1 -w '39444U' amateur.txt >> fav.txt
echo "COSMOS 2407 [+]" >> fav.txt
egrep -A1 -w '28380U' musson.txt >> fav.txt
echo "COSMOS 2463 [+]" >> fav.txt
egrep -A1 -w '36519U' musson.txt >> fav.txt
echo "Downloading Space-track TLE Files"

curl -c cookies.txt -b cookies.txt https://www.space-track.org/ajaxauth/login -d 'identity=username&password=password'

curl --limit-rate 100K --cookie cookies.txt https://www.space-track.org/basicspacedata/query/class/tle_latest/ORDINAL/1/EPOCH/%3Enow-30/orderby/NORAD_CAT_ID/format/3le > catalog.txt

echo "Generating Deadsat TLE From NORAD IDs"
echo "UOSAT 2 (UO-11)" >> deadsat.txt
egrep -A1 -w '14781U' catalog.txt >> deadsat.txt
echo "TIROS N [P]" >> deadsat.txt
egrep -A1 -w '11060U' catalog.txt >> deadsat.txt
echo "NOAA 9 [P]" >> deadsat.txt
egrep -A1 -w '15427U' catalog.txt >> deadsat.txt
echo "EUTELSAT 1-F4 (ECS 4)" >> deadsat.txt
egrep -A1 -w '18351U' catalog.txt >> deadsat.txt
echo "EUTELSAT 1-F5 (ECS 5)" >> deadsat.txt
egrep -A1 -w '19331U' catalog.txt >> deadsat.txt
echo "FENGYUN 1D" >> deadsat.txt
egrep -A1 -w '27431U' catalog.txt >> deadsat.txt
echo "CBERS 2B" >> deadsat.txt
egrep -A1 -w '32062U' catalog.txt >> deadsat.txt
echo "GEOSAT" >> deadsat.txt
egrep -A1 -w '15595U' catalog.txt >> deadsat.txt
echo "Akebono EXOS-D" >> deadsat.txt
egrep -A1 -w '19822U' catalog.txt >> deadsat.txt
echo "HAMSAT" >> deadsat.txt
egrep -A1 -w '28650U' catalog.txt >> deadsat.txt
echo ""

if egrep -q -A1 -w '07530U' catalog.txt; then
echo "OSCAR 7 (AO-7)" >> deadsat.txt
egrep -A1 -w '07530U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found OSCAR 7 fixing fuqups
echo "OSCAR 7 (AO-7)" >> deadsat.txt
egrep -A1 -w '7530U' catalog.txt >> deadsat.txt
sed -i 's/1  7530U/1 07530U/g' deadsat.txt
sed -i 's/2  7530/2 07530/g' deadsat.txt
fi

if egrep -q -A1 -w '00965U' catalog.txt; then
echo "TRANSIT 5B-5" >> deadsat.txt
egrep -A1 -w '00965U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found TRANSIT 5B-5 fixing fuqups
echo "TRANSIT 5B-5" >> deadsat.txt
egrep -A1 -w '965U' catalog.txt >> deadsat.txt
sed -i 's/1   965U/1 00965U/g' deadsat.txt
sed -i 's/2   965/2 00965/g' deadsat.txt
fi

if egrep -q -A1 -w '01430U' catalog.txt; then
echo "Tiros 10" >> deadsat.txt
egrep -A1 -w '01430U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found Tiros 10 fixing fuqups
echo "Tiros 10" >> deadsat.txt
egrep -A1 -w '1430U' catalog.txt >> deadsat.txt
sed -i 's/1  1430U/1 01430U/g' deadsat.txt
sed -i 's/2  1430/2 01430/g' deadsat.txt
fi

if egrep -q -A1 -w '01002U' catalog.txt; then
echo "LES-1" >> deadsat.txt
egrep -A1 -w '01002U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found LES-1 fixing fuqups
echo "LES-1" >> deadsat.txt
egrep -A1 -w '1002U' catalog.txt >> deadsat.txt
sed -i 's/1  1002U/1 01002U/g' deadsat.txt
sed -i 's/2  1002/2 01002/g' deadsat.txt
fi

if egrep -q -A1 -w '01291U' catalog.txt; then
echo "SOLRAD 7B" >> deadsat.txt
egrep -A1 -w '01291U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found SOLRAD 7B fixing fuqups
echo "SOLRAD 7B" >> deadsat.txt
egrep -A1 -w '1291U' catalog.txt >> deadsat.txt
sed -i 's/1  1291U/1 01291U/g' deadsat.txt
sed -i 's/2  1291/2 01291/g' deadsat.txt
fi

if egrep -q -A1 -w '01804U' catalog.txt; then
echo "ALOUETTE 2" >> deadsat.txt
egrep -A1 -w '01804U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found ALOUETTE 2 fixing fuqups
echo "ALOUETTE 2" >> deadsat.txt
egrep -A1 -w '1804U' catalog.txt >> deadsat.txt
sed -i 's/1  1804U/1 01804U/g' deadsat.txt
sed -i 's/2  1804/2 01804/g' deadsat.txt
fi

if egrep -q -A1 -w '03669U' catalog.txt; then
echo "ISIS 1" >> deadsat.txt
egrep -A1 -w '03669U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found ISIS 1 fixing fuqups
echo "ISIS 1" >> deadsat.txt
egrep -A1 -w '3669U' catalog.txt >> deadsat.txt
sed -i 's/1  3669U/1 03669U/g' deadsat.txt
sed -i 's/2  3669/2 03669/g' deadsat.txt
fi

if egrep -q -A1 -w '05485U' catalog.txt; then
echo "SHINSEI (MS-F2)" >> deadsat.txt
egrep -A1 -w '05485U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found SHINSEI fixing fuqups
echo "SHINSEI (MS-F2)" >> deadsat.txt
egrep -A1 -w '5485U' catalog.txt >> deadsat.txt
sed -i 's/1  5485U/1 05485U/g' deadsat.txt
sed -i 's/2  5485/2 05485/g' deadsat.txt
fi

if egrep -q -A1 -w '03891U' catalog.txt; then
echo "SECOR 13 (EGRS 13)" >> deadsat.txt
egrep -A1 -w '03891U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found SECOR 13 fixing fuqups
echo "SECOR 13 (EGRS 13)" >> deadsat.txt
egrep -A1 -w '3891U' catalog.txt >> deadsat.txt
sed -i 's/1  3891U/1 03891U/g' deadsat.txt
sed -i 's/2  3891/2 03891/g' deadsat.txt
fi

if egrep -q -A1 -w '02412U' catalog.txt; then
echo "EGRS 7" >> deadsat.txt
egrep -A1 -w '02412U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found EGRS 7 fixing fuqups
echo "EGRS 7" >> deadsat.txt
egrep -A1 -w '2412U' catalog.txt >> deadsat.txt
sed -i 's/1  2412U/1 02412U/g' deadsat.txt
sed -i 's/2  2412/2 02412/g' deadsat.txt
fi

if egrep -q -A1 -w '04237U' catalog.txt; then
echo "S69-4" >> deadsat.txt
egrep -A1 -w '04237U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found S69-4 fixing fuqups
echo "S69-4" >> deadsat.txt
egrep -A1 -w '4237U' catalog.txt >> deadsat.txt
sed -i 's/1  4237U/1 04237U/g' deadsat.txt
sed -i 's/2  4237/2 04237/g' deadsat.txt
fi

if egrep -q -A1 -w '04256U' catalog.txt; then
echo "TIMATION-II" >> deadsat.txt
egrep -A1 -w '04256U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found TIMATION-II fixing fuqups
echo "TIMATION-II" >> deadsat.txt
egrep -A1 -w '4256U' catalog.txt >> deadsat.txt
sed -i 's/1  4256U/1 04256U/g' deadsat.txt
sed -i 's/2  4256/2 04256/g' deadsat.txt
fi

if egrep -q -A1 -w '02411U' catalog.txt; then
echo "SECOR 7 (ERS 15)" >> deadsat.txt
egrep -A1 -w '02411U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found SECOR 7 fixing fuqups
echo "SECOR 7 (ERS 15)" >> deadsat.txt
egrep -A1 -w '2411U' catalog.txt >> deadsat.txt
sed -i 's/1  2411U/1 02411U/g' deadsat.txt
sed -i 's/2  2411/2 02411/g' deadsat.txt
fi

if egrep -q -A1 -w '02389U' catalog.txt; then
echo "OV 3-3" >> deadsat.txt
egrep -A1 -w '02389U' catalog.txt >> deadsat.txt
else
echo ""
echo Not found OV 3-3 fixing fuqups
echo "OV 3-3" >> deadsat.txt
egrep -A1 -w '2389U' catalog.txt >> deadsat.txt
sed -i 's/1  2389U/1 02389U/g' deadsat.txt
sed -i 's/2  2389/2 02389/g' deadsat.txt
fi

echo ""
echo "Cleaning up"
rm musson.txt stations.txt amateur.txt weather.txt nasabare.txt noaa.txt catalog.txt cookies.txt

echo "Done"
exit
