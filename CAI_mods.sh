######## start customization

#INTERVAL="1 hour ago"
#INTERVAL="10 days ago"
#INTERVAL="yesterday"
INTERVAL="24 hours ago"
######## end customization

#AREACODE=3600000000 + <see areacodes in actions file>
# you can update areacodes with query
# http://overpass-turbo.eu/s/14bK


AREANAME=$1
case $AREANAME in
  sic)
    AREACODE=3600039152
    ;;
  pug)
    AREACODE=3600040095
    ;;
  bas)
    AREACODE=3600040137
    ;;
  cam)
    AREACODE=3600040218
    ;;
  laz)
    AREACODE=3600040784
    ;;
  mol)
    AREACODE=3600041256
    ;;
  tos)
    AREACODE=3600041977
    ;;
  umb)
    AREACODE=3600042004
    ;;
  emr)
    AREACODE=3600042611
    ;;
  ven)
    AREACODE=3600043648
    ;;
  pie)
    AREACODE=3600044874
    ;;
  lom)
    AREACODE=3600044879
    ;;
  val)
    AREACODE=3600045155
    ;;
  taa)
    AREACODE=3600045757
    ;;
  mar)
    AREACODE=3600053060
    ;;
  abr)
    AREACODE=3600053937
    ;;
  fri)
    AREACODE=3600179296
    ;;
  lig)
    AREACODE=3600301482
    ;;
  cal)
    AREACODE=3601783980
    ;;
  sar)
    AREACODE=3607361997
    ;;
esac


# dates for overpass syntax: 
T0=`date -d "$INTERVAL" '+%Y-%m-%dT%H:%M:%SZ'`
T1=`date                '+%Y-%m-%dT%H:%M:%SZ'`
# dates for parding OSM xml
IERI=`date -d "$INTERVAL" '+%Y-%m-%d'`
OGGI=`date +"%Y-%m-%d"`

# extracting overpass adiff differences
curl -G 'http://overpass-api.de/api/interpreter' --data-urlencode 'data=[out:xml][timeout:300][adiff:"'$T0'","'$T1'"];area('$AREACODE')->.searchArea;(relation["operator"~"^club alpino italiano",i](area.searchArea);relation["operator"="CAI"](area.searchArea););(._;>;);out meta geom;' > $AREANAME'.osm'

# no report if no modifications
if  [ `cat $AREANAME.osm | grep action | wc -l` == 0 ]
then
   rm -f $AREANAME.osm
   exit    
fi

echo "<HTML><BODY>Monitor process run on $T1<BR>Changesets since $INTERVAL:<BR>" > $AREANAME'_changeset.html'
cat $AREANAME'.osm' | grep "$IERI\|$OGGI" | grep changeset | awk ' { match($0, /changeset=\"([0-9]+)\"/, a); print "<A HREF=https://overpass-api.de/achavi/?changeset="a[1]">"a[1]"</A><BR>" }' | sort -u >> $AREANAME'_changeset.html'
echo "</BODY></HTML>" >> $AREANAME'_changeset.html'
