clc;clear;
CQmap_dis=xlsread('RPE.xlsx');
datac=length(CQmap_dis);
rpe_c=datac/13;
rpe_all = 0;

for i =1:rpe_c
    rpe_all = rpe_all + CQmap_dis(2+13*(i-1));
end
rpe_avg = rpe_all/rpe_c 