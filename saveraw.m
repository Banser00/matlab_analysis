clc;clear;

txtname='CQmap2_rpy.txt';
matname='raw_rpyY.mat';

fileID = fopen(txtname,'r');
formatSpec = '%f';
CQin = fscanf(fileID,formatSpec);
CQmap_dis=reshape(CQin,11,length(CQin)/11);
CQmap_dis=CQmap_dis';

datac=length(CQmap_dis);

raw(:,1)=CQmap_dis(:,11);
raw(:,2:3)=CQmap_dis(:,9:10);
raw(:,4:9)=CQmap_dis(:,3:8);

save(matname,'raw');