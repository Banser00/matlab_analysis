clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
count=1;
scale=0.01;
frame_cnt=1;
lastNSR=0;
for frame= 0:0.01:0.0
    count=1;
for k=0.9:scale:1.9
    NSRc(1:13)=1;
    for i=int32(frame*datac+1):int32((frame+0.1)*datac)
        if(CQmap_dis(i,1)==0)
          for j=0:8
            if(CQmap_dis(i+j,2)>k &&  CQmap_dis(i+j,2)<k+scale)
                  u=CQmap_dis(i+j,3:5);
                  v=CQmap_dis(i+j,6:8);
                  if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
                    NSR(j+1,NSRc(j+1))= acosd(dot(u,v)/(norm(u)*norm(v)));
                    lastNSR=acosd(dot(u,v)/(norm(u)*norm(v)));
                    NSRc(j+1)=NSRc(j+1)+1;
                  else
                    NSR(j+1,NSRc(j+1))= lastNSR;
                    NSRc(j+1)=NSRc(j+1)+1; 
                  end 
            end
         end
      end
    end
    
%     figure();
%     plot([0:8],[sum(NSR(1,:)')/NSRc(1) sum(NSR(2,:)')/NSRc(2) sum(NSR(3,:)')/NSRc(3) sum(NSR(4,:)')/NSRc(4)...
%     sum(NSR(5,:)')/NSRc(5) sum(NSR(6,:)')/NSRc(6) sum(NSR(7,:)')/NSRc(7) sum(NSR(8,:)')/NSRc(8) sum(NSR(9,:)')/NSRc(9)]);
 
    pixel=int32(0.02*517/k);
    if(pixel>9)
        pixel=9;  
    end
    for kl=1:pixel
       NSRsum(kl)= sum(NSR(kl,:))/NSRc(kl);
    end
    [NSRmin NSRminloc]=min(NSRsum);
    
    out_in = 0;
    for ki=NSRminloc:-1:2
        if((NSRsum(ki-1)-NSRsum(ki))>0.1*(NSRsum(1)-NSRsum(NSRminloc)))
           out(frame_cnt,count)=ki;
           count = count +1;
           out_in=1;
           break;
        end
        if(ki==2)
           out(frame_cnt,count)=NSRminloc;
           count = count +1;
            out_in=1;
        end      
    end
    
    if(out_in==0)
        out(frame_cnt,count)=0;
        count = count +1;
    end
%     xlim([0 12]);
    NSR(:,:)=0;
    NSRsum(:)=9999;
    xlabel('NSR (pixel)');
    ylabel('error (degree)');
    str = sprintf('Depth: %.2f~%.2f',k,k+scale);
    title(str);
end
    frame_cnt = frame_cnt + 1;
end
% plot([0:12]/1.25,[sum(NSR(1,:)')/NSRc(1) sum(NSR(2,:)')/NSRc(2) sum(NSR(3,:)')/NSRc(3) sum(NSR(4,:)')/NSRc(4)...
%     sum(NSR(5,:)')/NSRc(5) sum(NSR(6,:)')/NSRc(6) sum(NSR(7,:)')/NSRc(7) sum(NSR(8,:)')/NSRc(8) ...
%     sum(NSR(9,:)')/NSRc(9) sum(NSR(10,:)')/NSRc(10) sum(NSR(11,:)')/NSRc(11) sum(NSR(12,:)')/NSRc(12) ...
%     sum(NSR(13,:)')/NSRc(13)]);
% xlim([0 12]);