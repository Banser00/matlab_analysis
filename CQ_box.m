clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
frame_cnt=1;
local_c=1;
cnt(1:20)=1;
max_CQ=0;
last_cnt=0;
   

for i=1:datac
     if(CQmap_dis(i,2)~=CQmap_dis(i,2)) 
         draw1=CQ_dep(1,:);
         draw1(find(draw1==0))=[NaN];
         draw2=CQ_dep(2,:);
         draw2(find(draw2==0))=[NaN];
         draw3=CQ_dep(3,:);
         draw3(find(draw3==0))=[NaN];
         draw4=CQ_dep(4,:);
         draw4(find(draw4==0))=[NaN];
         draw5=CQ_dep(5,:);
         draw5(find(draw5==0))=[NaN];
         draw6=CQ_dep(6,:);
         draw6(find(draw6==0))=[NaN];
         draw7=CQ_dep(7,:);
         draw7(find(draw7==0))=[NaN];
         draw8=CQ_dep(8,:);
         draw8(find(draw8==0))=[NaN];
         draw9=CQ_dep(9,:);
         draw9(find(draw9==0))=[NaN];
         draw10=CQ_dep(10,:);
         draw10(find(draw10==0))=[NaN];
         draw11=CQ_dep(11,:);
         draw11(find(draw11==0))=[NaN];
         draw12=CQ_dep(12,:);
         draw12(find(draw12==0))=[NaN];
         draw13=CQ_dep(13,:);
         draw13(find(draw13==0))=[NaN];
         draw14=CQ_dep(14,:);
         draw14(find(draw14==0))=[NaN];
         draw15=CQ_dep(15,:);
         draw15(find(draw15==0))=[NaN];
         draw16=CQ_dep(16,:);
         draw16(find(draw16==0))=[NaN];
         draw17=CQ_dep(17,:);
         draw17(find(draw17==0))=[NaN];
         draw18=CQ_dep(18,:);
         draw18(find(draw18==0))=[NaN];
         draw19=CQ_dep(19,:);
         draw19(find(draw19==0))=[NaN];
         draw20=CQ_dep(20,:);
         draw20(find(draw20==0))=[NaN];
         str = sprintf('%.5f.png',CQmap_dis(i,1));
         f=figure;
         subplot(2,1,1)
         boxplot([draw1' draw2' draw3' draw4' draw5' draw6' draw7' draw8'...
             draw9' draw10' draw11' draw12' draw13' draw14' draw15' draw16'...
             draw17' draw18' draw19' draw20']);
          set(gca, 'YScale', 'log');
        subplot(2,1,2)
           
        mean_l=mean(CQmap_dis(last_cnt+1:i-1,3));
        variance_l=var(CQmap_dis(last_cnt+1:i-1,3));
        
        x_l = [0.4:.08:2];
        %norm = normpdf(x_l,mean_l,variance_l);
        norm = normpdf(x_l,0.56,0.25);
        plot(x_l,norm);

         %ylim([0 max(CQmap_dis(:,2))]);
         %str2 = sprintf('speed: %.5f',(CQmap_dis(i-1,4)));
         %title(str2);
         saveas(f,str);
         max_CQ=0;
         frame_cnt=frame_cnt+1;
         cnt(1:20)=1;
         CQ_dep = zeros(20,1);
         last_cnt=i;
     end 
   for(j=0.4:0.08:1.92)
      if(CQmap_dis(i,3)>j && CQmap_dis(i,3)<=j+0.08)
         index=int32(1+(j-0.4)/0.08);
         CQ_dep(index,cnt(index))=1/(CQmap_dis(i,2)); 
         cnt(index)=cnt(index)+1;
         if((1/CQmap_dis(i,2))>max_CQ)
            max_CQ = 10/ CQmap_dis(i,2);
         end
      end
   end
end