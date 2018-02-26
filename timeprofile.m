clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

sample=mean(CQmap_dis(:,1))*1000;
salient=mean(CQmap_dis(:,2))*1000;
nor=mean(CQmap_dis(:,3))*1000;
sort=mean(CQmap_dis(:,4))*1000;