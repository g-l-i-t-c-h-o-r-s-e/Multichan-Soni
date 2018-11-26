FFMPREG -f rawvideo -pix_fmt $2 -s $3 -i $1 -f rawvideo -pix_fmt $2 -s $3 -r 25 -y output.raw

FFMPREG -f $4 -ar $5 -ac 6 -i output.raw \
-filter_complex "channelsplit=channel_layout=5.1(side)[1][2][3][4][5][6]" \
-map "[1]" -f $4 -ar $5 -ac 1 -y c-1.$4 \
-map "[2]" -f $4 -ar $5 -ac 1 -y c-2.$4 \
-map "[3]" -f $4 -ar $5 -ac 1 -y c-3.$4 \
-map "[4]" -f $4 -ar $5 -ac 1 -y c-4.$4 \
-map "[5]" -f $4 -ar $5 -ac 1 -y c-5.$4 \
-map "[6]" -f $4 -ar $5 -ac 1 -y c-6.$4 \

FFMPREG -f $4 -ar $5 -ac 1 -i c-1.$4 -f $4 -ar $5 -ac 1 -i c-2.$4 -f $4 -ar $5 -ac 1 -i c-3.$4 -f $4 -ar $5 -ac 1 -i c-4.$4 -f $4 -ar $5 -ac 1 -i c-5.$4 -f $4 -ar $5 -ac 1 -i c-6.$4 -filter_complex \ "
[0:a]anull[in1]; \
[1:a]anull[in2]; \
[2:a]anull[in3]; \
[3:a]anull[in4]; \
[4:a]anull[in5]; \
[5:a]anull[in6]; \
[in1][in2][in3][in4][in5][in6]join=inputs=6:channel_layout=5.1(side):map=0.0-FL|1.0-FR|2.0-FC|3.0-LFE|4.0-SL|5.0-SR:[a]" \
-map [a] -f $4 -ar $5 -ac 6 - |
FFMPREG -f rawvideo -pix_fmt $2 -s $3 -r 25 -i - -f rawvideo -pix_fmt $2 -s $3 -y output-bent.meme
rm c-*


#use "FFMPREG -layouts" to list audio channel layouts.
#use "FFMPREG -pix_fmts" to list colorspaces.
#this script is compatible with xyz12le, xyz12be.
