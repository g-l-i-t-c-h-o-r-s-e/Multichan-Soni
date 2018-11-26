ffmpeg -i $1 -f rawvideo -pix_fmt $2 -s $3 -r 24 -t 5 -y output.raw

ffmpeg -f $4 -ar $5 -ac 4 -i output.raw \
-filter_complex "channelsplit=channel_layout=4.0[1][2][3][4]" \
-map "[1]" -f $4 -ar $5 -ac 1 -y c-1.$4 \
-map "[2]" -f $4 -ar $5 -ac 1 -y c-2.$4 \
-map "[3]" -f $4 -ar $5 -ac 1 -y c-3.$4 \
-map "[4]" -f $4 -ar $5 -ac 1 -y c-4.$4 \

ffmpeg -f $4 -ar $5 -ac 1 -i c-1.$4 -f $4 -ar $5 -ac 1 -i c-2.$4 -f $4 -ar $5 -ac 1 -i c-3.$4 -f $4 -ar $5 -ac 1 -i c-4.$4 -filter_complex \ "
[0:a]anull[in1]; \
[1:a]anull[in2]; \
[2:a]acrusher=20:30:20:0.6:lin:1.5:1:50:true:20:0.3[in3]; \
[3:a]anull[in4]; \
[in1][in2][in3][in4]join=inputs=4:channel_layout=4.0:map=0.0-FL|1.0-FR|2.0-FC|3.0-BC:[a]" \
-map [a] -f $4 -ar $5 -ac 4 - |
ffmpeg -f rawvideo -pix_fmt $2 -s $3 -i - -y MULTIOUT.bmp

ffplay -loop 9001 MULTIOUT.bmp
rm c-*

#use "ffmpeg -layouts" to list audio channel layouts.
#use "ffmpeg -pix_fmts" to list colorspaces.
#this script is compatible with bgra, rgba, rgba64be, rgba64le, .
