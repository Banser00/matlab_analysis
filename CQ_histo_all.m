clear;clc;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

for i=1:datac
    CQ(i)=CQmap_dis(i,3); 
end

f=figure;
histogram(CQ);
xlim([0 0.2]);
ylim([0 40000]);