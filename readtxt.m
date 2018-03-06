clc;clear;

txtname='record_D3.txt';

fileID = fopen(txtname,'r');
formatSpec = '%f';
edgein = fscanf(fileID,formatSpec);
edge=reshape(edgein,77,length(edgein)/77);
edge=edge';

txtname='CQmap_D3.txt';

fileID = fopen(txtname,'r');
formatSpec = '%f';
CQin = fscanf(fileID,formatSpec);
CQmap_dis=reshape(CQin,11,length(CQin)/11);
CQmap_dis=CQmap_dis';