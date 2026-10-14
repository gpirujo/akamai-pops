echo Regenerating map
geopref="05-locations"
web="index.html"

cat "pre.html" >$web
cat "$geopref"/[0-9]* |
while read line
do
    echo "          L.marker([$line]),"
done >>$web
cat "post.html" >>$web
