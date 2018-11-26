ffmpeg -i $1 -f rawvideo -pix_fmt $2 -s $3 -t 5 -y output.raw

ffmpeg -f $4 -ar $5 -ac 8 -i output.raw \
-filter_complex "channelsplit=channel_layout=7.1[1][2][3][4][5][6][7][8]" \
-map "[1]" -f $4 -ar $5 -ac 1 -y c-1.$4 \
-map "[2]" -f $4 -ar $5 -ac 1 -y c-2.$4 \
-map "[3]" -f $4 -ar $5 -ac 1 -y c-3.$4 \
-map "[4]" -f $4 -ar $5 -ac 1 -y c-4.$4 \
-map "[5]" -f $4 -ar $5 -ac 1 -y c-5.$4 \
-map "[6]" -f $4 -ar $5 -ac 1 -y c-6.$4 \
-map "[7]" -f $4 -ar $5 -ac 1 -y c-7.$4 \
-map "[8]" -f $4 -ar $5 -ac 1 -y c-8.$4 \

ffmpeg -f $4 -ar $5 -ac 1 -i c-1.$4 -f $4 -ar $5 -ac 1 -i c-2.$4 -f $4 -ar $5 -ac 1 -i c-3.$4 -f $4 -ar $5 -ac 1 -i c-4.$4 -f $4 -ar $5 -ac 1 -i c-5.$4 -f $4 -ar $5 -ac 1 -i c-6.$4 -f $4 -ar $5 -ac 1 -i c-7.$4 -f $4 -ar $5 -ac 1 -i c-8.$4 -filter_complex \ "
[0:a]anull[in1]; \
[1:a]anull[in2]; \
[2:a]anull[in3]; \
[3:a]anull[in4]; \
[4:a]anull[in5]; \
[5:a]anull[in6]; \
[6:a]anull[in7]; \
[7:a]anull[in8]; \
[in1][in2][in3][in4][in5][in6][in7][in8]join=inputs=8:channel_layout=7.1:map=0.0-FL|1.0-FR|2.0-FC|3.0-LFE|4.0-BL|5.0-BR|6.0-SL|7.0-SR:[a]" \
-map [a] -f $4 -ar $5 -ac 8 - |
ffmpeg -f rawvideo -pix_fmt $2 -s $3 -i - -c:v huffyuv -y MULTIOUT.avi

ffplay -loop 9001 MULTIOUT.avi
rm c-*

#use "ffmpeg -layouts" to list audio channel layouts.
#use "ffmpeg -pix_fmts" to list colorspaces.
#this script is compatible with ayuv64le.

