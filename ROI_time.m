clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

sample=mean(CQmap_dis(:,2));
iter=mean(CQmap_dis(:,3));
weighting=mean(CQmap_dis(:,4));
merge=mean(CQmap_dis(:,5));