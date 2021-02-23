# based on query
# https://overpass-turbo.eu/s/142m

INTERVAL="yesterday"

T0=`date -d "$INTERVAL" '+%Y-%m-%dT%H:%M:%SZ'`
T1=`date                '+%Y-%m-%dT%H:%M:%SZ'`
AREACODE=3600179296

curl -G 'http://overpass-api.de/api/interpreter' --data-urlencode 'data=[out:xml][timeout:300][adiff:"'$T0'","'$T1'"];area('$AREACODE')->.searchArea;(relation["operator"="Club Alpino Italiano"](area.searchArea);rel
ation["operator"="CAI"](area.searchArea););(._;>;);out meta geom;' > CAI_mods.osm


#wget -O CAI_mods.osm "https://overpass-api.de/api/interpreter?data=%5Bout%3Axml%5D%5Btimeout%3A300%5D%5Badiff%3A%222021%2D02%2D15T00%3A00%3A00Z%22%2C%222021%2D02%2D23T00%3A00%3A00Z%22%5D%3Barea%283600179296%29%2D%3E%2EsearchArea%3B%28relation%5B%22route%22%3D%22hiking%22%5D%5B%22operator%22%7E%22club%20alpino%20italiano%22%2Ci%5D%28area%2EsearchArea%29%3B%29%3Bout%3B%0A"
cat CAI_mods.osm | grep "relation id" | awk -F\" '{print "https://pewu.github.io/osm-history/#/relation/"$2}' | sort -u > last_changes_relations
