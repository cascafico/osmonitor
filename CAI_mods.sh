######## start customization
#AREACODE=3600000000 + <see areacodes in actions file>
AREACODE=$1
INTERVAL="1 hour ago"
INTERVAL="10 days ago"
INTERVAL="yesterday"
INTERVAL="3 days ago"
######## end customization

# dates for overpass syntax: 
T0=`date -d "$INTERVAL" '+%Y-%m-%dT%H:%M:%SZ'`
T1=`date                '+%Y-%m-%dT%H:%M:%SZ'`
# dates for parding OSM xml
IERI=`date -d "$INTERVAL" '+%Y-%m-%d'`
OGGI=`date +"%Y-%m-%d"`


# extracting overpass adiff differences
curl -G 'http://overpass-api.de/api/interpreter' --data-urlencode 'data=[out:xml][timeout:300][adiff:"'$T0'","'$T1'"];area('$AREACODE')->.searchArea;(relation["operator"~"^club alpino italiano",i](area.searchArea);relation["operator"="CAI"](area.searchArea););(._;>;);out meta geom;' > $AREACODE'.osm'

echo "<HTML><BODY>Monitor process run on $T1<BR>$INTERVAL changesets:<BR>" > $AREACODE'changeset.html'
cat $AREACODE'.osm' | grep "$IERI\|$OGGI" | grep changeset | awk ' { $changeset=substr($0,index($0, "changeset")+11,8); print "<A HREF=https://overpass-api.de/achavi/?changeset="$changeset">"$changeset"</A><BR>" }' | sort -u >> $AREACODE'changeset.html'
echo "</BODY></HTML>" >> $AREACODE'changeset.html'


