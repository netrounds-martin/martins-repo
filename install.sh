#!/bin/bash
apt-get update && apt-get install ffmpeg -y && apt-get install nginx -y && apt-get update &&
echo "Which video would you like to stream? (location/file.mp4)"
read VIDIN &&
echo "What would you like to call the .m3u8 file (No file extension needed)?"
read LISTOUT &&
ffmpeg -i $VIDIN -hls_time 2 -strict -2 -hls_flags single_file ${LISTOUT}.m3u8 && echo "Your video files are called ${LISTOUT}.ts and ${LISTOUT}.m3u8" && 
mv ${LISTOUT}.ts /var/www/html/ && mv ${LISTOUT}.m3u8 /var/www/html/ &&
echo "<!DOCTYPE html>
<html>
<head>
    <title>Live Stream</title>
</head>

<body>
    <div id="player">
        <video width="640" height="480" src="${LISTOUT}.m3u8" type="application/x-mpegURL" />
            Your browser does not support HTML5 streaming!
        </video>
    </div>
</body>
</html" > /var/www/html/index.nginx-debian.html &&
sed -i -e 's/80/5333/g' /etc/nginx/sites-enabled/default &&
echo "    " \
echo "    " \
echo "!!! Now enter http://<serverip>:5333/${LISTOUT}.m3u8 into Netrounds OTT monitoring. !!!" \
echo "    "
#EOF
