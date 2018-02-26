clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

Q1= prctile(CQmap_dis(:,3),25)
Q2= prctile(CQmap_dis(:,3),50)
Q3= prctile(CQmap_dis(:,3),75)