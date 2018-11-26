ffmpeg -i $1 -f rawvideo -pix_fmt $2 -s $3 -r 10 -t 5 -y output.raw

ffmpeg -f $4 -ar $5 -ac 3 -i output.raw \
-filter_complex "channelsplit=channel_layout=2.1[1][2][3]" \
-map "[1]" -f $4 -ar $5 -ac 1 -y c-1.$4 \
-map "[2]" -f $4 -ar $5 -ac 1 -y c-2.$4 \
-map "[3]" -f $4 -ar $5 -ac 1 -y c-3.$4 \

ffmpeg -f $4 -ar $5 -ac 1 -i c-1.$4 -f $4 -ar $5 -ac 1 -i c-2.$4 -f $4 -ar $5 -ac 1 -i c-3.$4 -filter_complex \ "
[0:a]anull[in1]; \
[1:a]chorus=0.1:1:1:1:1:0.1[in2]; \
[2:a]anull[in3]; \
[in1][in2][in3]join=inputs=3:channel_layout=2.1:map=0.0-FL|1.0-FR|2.0-LFE:[a]" \
-map [a] -f $4 -ar $5 -ac 3 - |
ffmpeg -f rawvideo -pix_fmt $2 -s $3 -r 10 -i - -c:v huffyuv -y MULTIOUT.avi

ffplay -loop 9001 MULTIOUT.avi 
rm c-*

#use "ffmpeg -layouts" to list audio channel layouts.
#use "ffmpeg -pix_fmts" to list colorspaces.
#this script is compatible with rgb24, bgr24 I think lol.
