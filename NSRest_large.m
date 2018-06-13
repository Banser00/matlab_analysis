clc;clear;
% edge=xlsread('record.xlsx');

matname='tranxyzY_1~600.mat';

txtname='record2_TX_1~600.txt';
fileID = fopen(txtname,'r');
formatSpec = '%f';
edgein = fscanf(fileID,formatSpec);
edge=reshape(edgein,98,length(edgein)/98);
edge=edge';
datae=length(edge);

LBP = edge;

% NSR estimation
% CQmap_dis=xlsread('CQmap.xlsx');

txtname='CQmap2_TX_1~600.txt';

fileID = fopen(txtname,'r');
formatSpec = '%f';
CQin = fscanf(fileID,formatSpec);
CQmap_dis=reshape(CQin,11,length(CQin)/11);
CQmap_dis=CQmap_dis';

datac=length(CQmap_dis);

scale=0.01;
frame_cnt=1;
lastNSR=0;
h_count=1;
count=1;
lpc=1;
lpc2=1;
% check data
if(datac/datae ~= 13)
    warning('data no match')
end
%closet edge
e_c=1;
for i=1:datac
    if(CQmap_dis(i,1)==0)
        edge_pool(e_c,1:2)=CQmap_dis(i,9:10);
        e_c=e_c+1;
    end
end

upper(1)=1;
upper_c=2;
lower_c=1;

% find out location of each frame
for i=1:(e_c-1)    
    if(i==e_c-1)
       lower(lower_c)=i;
       lower_c=lower_c+1;        
    elseif(edge_pool(i,1)>edge_pool(i+1,1)) % check!!! x or y
       lower(lower_c)=i;
       lower_c=lower_c+1;
       
       upper(upper_c)=i+1;
       upper_c=upper_c+1;
    end
end

% calculate min distance from neaest edge of each edge
current_state=1;
for i=1:(e_c-1)
    if(i>lower(current_state))
       current_state=current_state+1; 
    end
    ind_len=lower(current_state)-upper(current_state)+1;
    ind_pool(1:ind_len) = abs(edge_pool(i,1)-edge_pool(upper(current_state):lower(current_state),1))+ ...
        abs(edge_pool(i,2)-edge_pool(upper(current_state):lower(current_state),2));
    ind_pool(find(ind_pool==0))=[];
    LBP(i,99)=min(ind_pool);
    ind_pool(:)=0;
end

% Preprocessing

    k_c(1:361)=1;
    NSR(1:9,1)=0;
 
    LBP_count=1;
    for i=1:datac
        for k=0.4:scale:4
            if(CQmap_dis(i,2)>k &&  CQmap_dis(i,2)<=k+scale && CQmap_dis(i,1)==0)
               index=int32((k-0.4)/0.01 + 1);
               CQ_index(index,k_c(index))= i;
               k_c(index)=k_c(index)+1;
            end
        end
    end


% check number of layers
nl=1;
for i=1:361
    if(k_c(i)>1)
        nice_layer(nl)=i;
        nl=nl+1;
    end
end

for p_l=1:nl-1
    
progess=int32(100*p_l/(nl-1))
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
        time(LBPc,1)=CQmap_dis(CQ_index(p_layer,i),11);
        for j=0:8
            u=CQmap_dis(CQ_index(p_layer,i)+j,3:5);
            v=CQmap_dis(CQ_index(p_layer,i)+j,6:8);
            time(LBPc,2+j*2)=CQmap_dis(CQ_index(p_layer,i)+j,9);
            time(LBPc,3+j*2)=CQmap_dis(CQ_index(p_layer,i)+j,10);
            % check direction of normal
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
%         if(NSR(1,LC)<20)
%            continue; 
%         end

    
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
               CQ_pool(lpc)=LBP_cq(LC);
                
               LBP_pool(lpc,1:99)=LBP_nsr(LC,:);
               LBP_pool(lpc,100)=lp;
               lpc=lpc+1;
               
               NSR_pool(lpc2,1:9)=NSRsum(:);
               NSR_pool(lpc2,10)=lp;
               
               pos_pool(lpc2,1)=time(LC,1);
               for pos=1:9
                  pos_pool(lpc2,2+(pos-1)*3)=time(LC,2+(pos-1)*2); 
                  pos_pool(lpc2,3+(pos-1)*3)=time(LC,3+(pos-1)*2); 
                  pos_pool(lpc2,4+(pos-1)*3)=NSRsum(pos); 
               end
               lpc2=lpc2+1;
               
            
            end
        end
        
    end
    NSR(:,:)=0;
    NSRsum(:)=9999;
end


save(matname,'LBP_pool','NSR_pool','pos_pool');

