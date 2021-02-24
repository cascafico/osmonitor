######## start customization
REGIONE="FVG"
#AREACODE=3600000000 + <see areacodes file>
AREACODE=3600179296
INTERVAL="yesterday"
#INTERVAL="1 hour ago"
######## end customization

# dates for overpass syntax: 
T0=`date -d "$INTERVAL" '+%Y-%m-%dT%H:%M:%SZ'`
T1=`date                '+%Y-%m-%dT%H:%M:%SZ'`
# dates for parding OSM xml
IERI=`date -d "$INTERVAL" '+%Y-%m-%d'`
OGGI=`date +"%Y-%m-%d"`

REGIONEQ=$REGIONE'adiff'$OGGI'.xml'

rm $REGIONE*

# extracting overpass adiff differences
curl -G 'http://overpass-api.de/api/interpreter' --data-urlencode 'data=[out:xml][timeout:300][adiff:"'$T0'","'$T1'"];area('$AREACODE')->.searchArea;(relation["operator"="Club Alpino Italiano"](area.searchArea);relation["operator"="CAI"](area.searchArea););(._;>;);out meta geom;' > $REGIONEQ

# parsing involved changeset(s)
cat $REGIONEQ | grep "$IERI\|$OGGI" | grep changeset | awk ' { print substr($0,index($0, "changeset")+11,8) }' | sort -u > $REGIONE'changeset.lst'

# sorting and compacting changeset list
# sort -u $REGIONEchangeset.lst -o $REGIONEchangeset.lst
