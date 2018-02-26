clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
OSRc(1:13)=1;
cnt=1;  
for i=1:datac
    if(CQmap_dis(i,1)==99999)

        figure;
        plot([0:12],[sum(OSR(1,:)')/OSRc(1) sum(OSR(2,:)')/OSRc(2) sum(OSR(3,:)')/OSRc(3) sum(OSR(4,:)')/OSRc(4)...
        sum(OSR(5,:)')/OSRc(5) sum(OSR(6,:)')/OSRc(6) sum(OSR(7,:)')/OSRc(7) sum(OSR(8,:)')/OSRc(8) ...
        sum(OSR(9,:)')/OSRc(9) sum(OSR(10,:)')/OSRc(10) sum(OSR(11,:)')/OSRc(11) sum(OSR(12,:)')/OSRc(12) ...
        sum(OSR(13,:)')/OSRc(13)]);
        xlim([0 12]);
%         ylim([0 0.6])
        hold on
        plot([0:12],[0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2])
        str = sprintf('speed: %f',CQmap_dis(i-1,2));
        title(str);
        xlabel('OSR (pixel)');
        ylabel('Error');

        cnt=cnt+1;  
        OSRc(1:13)=1;
    else
      for j=0:12
         if(CQmap_dis(i,5)>1.4 && CQmap_dis(i,5)<1.2)
            break; 
         end
         if(CQmap_dis(i,1)==j && rms(CQmap_dis(i,3:5)-CQmap_dis(i,6:8))<0.5)
           OSR(j+1,OSRc(j+1)) = rms(CQmap_dis(i,3:5)-CQmap_dis(i,6:8));    
           OSRc(j+1)=OSRc(j+1)+1;
         end
      end
    end
end
