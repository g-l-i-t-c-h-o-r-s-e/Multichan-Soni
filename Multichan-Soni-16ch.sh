ffmpeg -i $1 -f rawvideo -pix_fmt $2 -s $3 -t 5 -y output.raw

ffmpeg -f $4 -ar $5 -ac 16 -i output.raw \
-filter_complex "channelsplit=channel_layout=hexadecagonal[1][2][3][4][5][6][7][8][9][10][11][12][13][14][15][16]" \
-map "[1]" -f $4 -ar $5 -ac 1 -y c-1.$4 \
-map "[2]" -f $4 -ar $5 -ac 1 -y c-2.$4 \
-map "[3]" -f $4 -ar $5 -ac 1 -y c-3.$4 \
-map "[4]" -f $4 -ar $5 -ac 1 -y c-4.$4 \
-map "[5]" -f $4 -ar $5 -ac 1 -y c-5.$4 \
-map "[6]" -f $4 -ar $5 -ac 1 -y c-6.$4 \
-map "[7]" -f $4 -ar $5 -ac 1 -y c-7.$4 \
-map "[8]" -f $4 -ar $5 -ac 1 -y c-8.$4 \
-map "[9]" -f $4 -ar $5 -ac 1 -y c-9.$4 \
-map "[10]" -f $4 -ar $5 -ac 1 -y c-10.$4 \
-map "[11]" -f $4 -ar $5 -ac 1 -y c-11.$4 \
-map "[12]" -f $4 -ar $5 -ac 1 -y c-12.$4 \
-map "[13]" -f $4 -ar $5 -ac 1 -y c-13.$4 \
-map "[14]" -f $4 -ar $5 -ac 1 -y c-14.$4 \
-map "[15]" -f $4 -ar $5 -ac 1 -y c-15.$4 \
-map "[16]" -f $4 -ar $5 -ac 1 -y c-16.$4 \

ffmpeg -f $4 -ar $5 -ac 1 -i c-1.$4 -f $4 -ar $5 -ac 1 -i c-2.$4 -f $4 -ar $5 -ac 1 -i c-3.$4 -f $4 -ar $5 -ac 1 -i c-4.$4 -f $4 -ar $5 -ac 1 -i c-5.$4 -f $4 -ar $5 -ac 1 -i c-6.$4 -f $4 -ar $5 -ac 1 -i c-7.$4 -f $4 -ar $5 -ac 1 -i c-8.$4 -f $4 -ar $5 -ac 1 -i c-9.$4 -f $4 -ar $5 -ac 1 -i c-10.$4 -f $4 -ar $5 -ac 1 -i c-11.$4 -f $4 -ar $5 -ac 1 -i c-12.$4 -f $4 -ar $5 -ac 1 -i c-13.$4 -f $4 -ar $5 -ac 1 -i c-14.$4 -f $4 -ar $5 -ac 1 -i c-15.$4 -f $4 -ar $5 -ac 1 -i c-16.$4 -filter_complex \ "
[0:a]anull[in1]; \
[1:a]anull[in2]; \
[2:a]anull[in3]; \
[3:a]anull[in4]; \
[4:a]anull[in5]; \
[5:a]anull[in6]; \
[6:a]anull[in7]; \
[7:a]anull[in8]; \
[8:a]anull[in9]; \
[9:a]anull[in10]; \
[10:a]anull[in11]; \
[11:a]anull[in12]; \
[12:a]anull[in13]; \
[13:a]crystalizer=10,crystalizer=10,crystalizer=10[in14]; \
[14:a]anull[in15]; \
[15:a]acrusher=20:30:20:0.6:lin:1.5:1:50:true:20:0.3[in16]; \
[in1][in2][in3][in4][in5][in6][in7][in8][in9][in10][in11][in12][in13][in14][in15][in16]join=inputs=16:channel_layout=hexadecagonal:map=0.0-FL|1.0-FR|2.0-FC|3.0-BL|4.0-BR|5.0-BC|6.0-SL|7.0-SR|8.0-TFL|9.0-TFC|10.0-TFR|11.0-TBL|12.0-TBC|13.0-TBR|14.0-WL|15.0-WR:[a]" \
-map [a] -f $4 -ar $5 -ac 16 - |
ffmpeg  -f rawvideo -pix_fmt $2 -s $3 -deinterlace -i - -y MULTIOUT.png

ffplay -loop 9001 MULTIOUT.png
rm c-*

#use "ffmpeg -layouts" to list audio channel layouts.
#use "ffmpeg -pix_fmts" to list colorspaces.
#this script is compatible with ayuv64le, rgb24.

