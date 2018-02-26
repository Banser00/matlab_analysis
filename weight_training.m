clear;clc;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

CQ_c=1;
for i=1:datac
   if(CQmap_dis(i,1)==99999)
      CQ(CQ_c)=CQmap_dis(i,2);
      intensity(CQ_c,1:49)=CQmap_dis(i+1 ,1:49);
      CQ_c=CQ_c+1;
   end
end

weight = intensity\CQ';