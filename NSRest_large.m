clc;clear;
edge=xlsread('record.xlsx');
datae=length(edge);

LBP = edge;

% NSR estimation
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

scale=0.01;
frame_cnt=1;
lastNSR=0;
h_count=1;
count=1;
lpc=1;

% Preprocessing
for frame = 0:0.05:0.95
    k_c(1:101)=1;
    NSR(1:9,1)=0;
 
    LBP_count=1;
    for i=int32(frame*datac+1):int32((frame+0.05)*datac)
        for k=0.9:scale:1.9
            if(CQmap_dis(i,2)>k &&  CQmap_dis(i,2)<k+scale && CQmap_dis(i,1)==0)
               index=int32((k-0.9)/0.01 + 1);
               CQ_index(index,k_c(index))= i;
               k_c(index)=k_c(index)+1;
            end
        end
    end


% check number of layers
nl=1;
for i=1:101
    if(k_c(i)>1)
        nice_layer(nl)=i;
        nl=nl+1;
    end
end

for p_l=1:nl-1
% cluster
p_layer=nice_layer(p_l);


fix_in=1;
search_x=0;
search_y=0;
s_range=100;
s_count=1;
LBPc=1;

NSRc(1:13)=1;
for i=1:(k_c(p_layer)-1)

    if(CQ_index(p_layer,i)~=0)
        for j=0:8
            u=CQmap_dis(CQ_index(p_layer,i)+j,3:5);
            v=CQmap_dis(CQ_index(p_layer,i)+j,6:8);
            if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
                NSR(j+1,NSRc(j+1))= acosd(dot(u,v)/(norm(u)*norm(v)));
                lastNSR=acosd(dot(u,v)/(norm(u)*norm(v)));
                NSRc(j+1)=NSRc(j+1)+1;
            else
                NSR(j+1,NSRc(j+1))= lastNSR;
                NSRc(j+1)=NSRc(j+1)+1; 
            end 
        end
        LBP_index=(CQ_index(p_layer,i)-1)/13 + 1;
        LBP_nsr(LBPc,:)=LBP(LBP_index,:);
        LBP_cq(LBPc)=CQ_index(p_layer,i);
        LBPc = LBPc + 1;
    end
end
    
    for LC=1:(LBPc-1)
        if(NSR(1,LC)<20)
           continue; 
        end

    
     pixel=int32(0.02*517/k);
    if(pixel>9)
        pixel=9;  
    end
    for kl=1:9
       NSRsum(kl)= NSR(kl,LC);
    end
    
    %find out minimum
    [NSRmin NSRminloc]=min(NSRsum);
    for kl=1:9
       if(NSRsum(kl)<10 && abs(NSRsum(kl)-NSRmin) <5 && kl < NSRminloc)
           NSRmin=NSRsum(kl);
           NSRminloc=kl;
       end
    end
    out_in = 0;
    for ki=NSRminloc:-1:2
        if((NSRsum(ki-1)-NSRsum(ki))>0.05*(NSRsum(1)-NSRsum(NSRminloc)))
           out(1,count)=ki;
           out(2,count)=p_layer;
           count = count +1;
           out_in=1;
           break;
        end
        if(ki==2)
           out(1,count)=NSRminloc;
           out(2,count)=p_layer;
           count = count +1;
            out_in=1;
        end      
    end
    
    if(out_in==0)
        out(1,count)=0;
        out(2,count)=p_layer;
        count = count +1;
    end
%         str = sprintf('%d | %d | %d | %d | %d',LBP_cq(LC),LBP_nsr(LC) ,LBP_nsr1(LC),LBP_nsr2(LC),out(1,count-1));
%         figure();
%         plot([1:9],NSR(:,LC));
%         title(str);
        % store LBP and min
        for lp=1:9
            if(out(1,count-1)==lp)
               LBP_pool(lpc,1:77)=LBP_nsr(LC,:);
               LBP_pool(lpc,78)=lp;
               lpc=lpc+1;
            end
        end
        
    end
    NSR(:,:)=0;
    NSRsum(:)=9999;
end

end
