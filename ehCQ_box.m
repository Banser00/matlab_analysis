clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
frame_cnt=1;
local_c=1;
cnt(1:20)=1;
for i=1:datac
   if(i>1)
     if(CQmap_dis(i,1)~=CQmap_dis(i-1,1)) 
         str = sprintf('%.5f.png',CQmap_dis(i-1,1));
         f=figure;
         plot([0.4:0.08:1.92],cnt(:));
         %ylim([0 max(CQmap_dis(:,2))]);
         saveas(f,str);      
         frame_cnt=frame_cnt+1;
         cnt(1:20)=1;
         CQ_dep = zeros(20,1);
     end 
   end
   for(j=0.4:0.08:1.92)
      if(CQmap_dis(i,2)>j && CQmap_dis(i,2)<=j+0.08)
         index=int32(1+(j-0.4)/0.08);
         cnt(index)=cnt(index)+1;
      end
   end
end