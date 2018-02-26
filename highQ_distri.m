clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
frame_cnt=1;
local_c=1;
cnt(1:20)=1;
max_CQ=0;
last_cnt=0;
   

for i=1:datac
     if(CQmap_dis(i,1)~=999) 

         variance_l=var(100*CQmap_dis((last_cnt+1):(i-1),3));
%          if (variance_l>1000) 
%             last_cnt=i;
%             continue; 
%          end
         [max_m m_num]=max(CQmap_dis(i,3:22)/sum(CQmap_dis(i,3:22)));
         min_num=CQmap_dis(i,23)*100;
%          mean_l=40+8*(m_num-1);
         mean_p=CQmap_dis(i,3:22)/sum(CQmap_dis(i,3:22));
         mean_l=dot([40:8:192],mean_p);
       
 
%          str = sprintf('%.5f.png',CQmap_dis(i,1));
%          f=figure;
%          
%          plot([40:8:192],CQmap_dis(i,3:22)/(sum(CQmap_dis(i,3:22))*8));
%          hold on
%          pd = makedist('Normal','mu',mean_l,'sigma',(variance_l)^0.5);
%          t = truncate(pd,40,200)
%          x = 40:1:200;
%          plot(x,pdf(t,x),'Color','red','LineWidth',2)
%          hold off 
%          str2 = sprintf('speed: %f',CQmap_dis(i,2));
%          title(str2);
%          xlabel('distance (cm)');
%          ylabel('probability density(%)');
%          legend('Top 10% CQ','truncated normal distribution');
%          saveas(f,str);
         
         last_cnt=i;
          if(CQmap_dis(i,23)<0.9 )
           number(frame_cnt)=i;
           mean_cnt(frame_cnt)=mean_l;
           speed_cnt(frame_cnt)=CQmap_dis(i,2);
           var_cnt(frame_cnt)=variance_l; 
           near_cnt(frame_cnt)=CQmap_dis(i,23);
           max_CQ=0;
           frame_cnt=frame_cnt+1;
           cnt(1:20)=1;
           CQ_dep = zeros(20,1);
       
          end
     end 
   for(j=0.4:0.08:1.92)
      if(CQmap_dis(i,3)>j && CQmap_dis(i,3)<=j+0.08)
         index=int32(1+(j-0.4)/0.08);
         cnt(index)=cnt(index)+1;
      end
   end
end