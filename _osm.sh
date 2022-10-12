# source: https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames#Bourne_shell_with_Awk

function xtile2long() {
    local xtile=$1
    local zoom=$2
    echo "$xtile $zoom" | awk '{printf("%.9f", $1 / 2.0^$2 * 360.0 - 180)}'
}

function long2xtile() {
    local long=$1
    local zoom=$2
    echo "$long $zoom" | awk '{ xtile = ($1 + 180.0) / 360 * 2.0^$2;
  xtile+=xtile<0?-0.5:0.5;
  printf("%d", xtile ) }'
}

function ytile2lat() {
    local ytile=$1
    local zoom=$2
    local tms=$3
    if [ -n "$tms" ]; then
        #  from tms_numbering into osm_numbering
        ytile=$(echo "$ytile $zoom" | awk '{printf("%d\n",((2.0^$2)-1)-$1)}')
    fi
    lat=$(echo "$ytile $zoom" | awk -v PI=3.14159265358979323846 '{
       num_tiles = PI - 2.0 * PI * $1 / 2.0^$2;
       printf("%.9f", 180.0 / PI * atan2(0.5 * (exp(num_tiles) - exp(-num_tiles)),1)); }')
    echo "${lat}"
}

function lat2ytile() {
    local lat=$1
    local zoom=$2
    local tms=$3
    local ytile
    ytile=$(echo "$lat $zoom" | awk -v PI=3.14159265358979323846 '{
   tan_x=sin($1 * PI / 180.0)/cos($1 * PI / 180.0);
   ytile = (1 - log(tan_x + 1/cos($1 * PI/ 180))/PI)/2 * 2.0^$2; 
   ytile+=ytile<0?-0.5:0.5;
   printf("%d", ytile ) }')
    if [ -n "$tms" ]; then
        #  from oms_numbering into tms_numbering
        ytile=$(echo "$ytile $zoom" | awk '{printf("%d\n",((2.0^$2)-1)-$1)}')
    fi
    echo "${ytile}"
}
