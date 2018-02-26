clc;clear;

% LBP
edge=xlsread('record.xlsx');
datae=length(edge);

for i=1:datae
   for j=1:9
       sb=[edge(i,1+mod(j-1,3)+5*floor((j-1)/3)) edge(i,2+mod(j-1,3)+5*floor((j-1)/3))*2 edge(i,3+mod(j-1,3)+5*floor((j-1)/3)) ...
           edge(i,6+mod(j-1,3)+5*floor((j-1)/3))*2 edge(i,7+mod(j-1,3)+5*floor((j-1)/3))*4 edge(i,8+mod(j-1,3)+5*floor((j-1)/3))*2 ...
           edge(i,11+mod(j-1,3)+5*floor((j-1)/3)) edge(i,12+mod(j-1,3)+5*floor((j-1)/3))*2 edge(i,13+mod(j-1,3)+5*floor((j-1)/3))];
%        sb(find(sb==0))=[];
       total=0;
       if (sb(1)>0)
           total = total + 1;
       end
       if (sb(2)>0)
           total = total + 2; 
       end
       if (sb(3)>0)
           total = total + 1; 
       end
       if (sb(4)>0)
           total = total + 2;
       end
       if (sb(5)>0)
           total = total + 4;
       end
       if (sb(6)>0)
           total = total + 2;
       end
       if (sb(7)>0)
           total = total + 1;
       end
       if (sb(8)>0)
           total = total + 2;
       end
       if (sb(9)>0)
           total = total + 1;
       end
       if(total>0)
           edge_avg(i,j)=sum(sb)/total;
       else
           edge_avg(i,j)=0;
       end
   end
   % LBP encode
   for k=1:8
       if(k<5)
           k_ind=k;
       else
           k_ind=k+1;
       end
       if(edge_avg(i,k_ind)<=edge_avg(i,5))
           LBP_code(i,k)=1;
       else
           LBP_code(i,k)=0;
       end
   end   
end
LBP_code_ori=LBP_code;

% LBP rotation invarint
for i=1:length(LBP_code)
   for j=1:8
       if(LBP_code(i,1)==0) 
           LBP_temp=LBP_code(i,1);
           LBP_code(i,1)=LBP_code(i,2);
           LBP_code(i,2)=LBP_code(i,3);
           LBP_code(i,3)=LBP_code(i,4);
           LBP_code(i,4)=LBP_code(i,5);
           LBP_code(i,5)=LBP_code(i,6);
           LBP_code(i,6)=LBP_code(i,7);
           LBP_code(i,7)=LBP_code(i,8);
           LBP_code(i,8)=LBP_temp;
       else
           break;
       end
   end
    LBP_ten(i) = LBP_code(i,1)*(2^7) + LBP_code(i,2)*(2^6) + LBP_code(i,3)*(2^5) + ...
       LBP_code(i,4)*(2^4) + LBP_code(i,5)*(2^3) + LBP_code(i,6)*(2^2) + ...
       LBP_code(i,7)*(2^1) + LBP_code(i,8)*(2^0);
end

% NSR estimation
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

scale=0.01;
frame_cnt=1;
lastNSR=0;
h_count=1;

% Preprocessing
for frame = 0:0.05:0.95
    k_c(1:101)=1;
    NSR(1:9,1)=0;
    count=1;
    LBP_count=1;
    for i=int32(frame*datac+1):int32((frame+0.05)*datac)
        for k=1.15:scale:1.2
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
    if(k_c(i)>20)
        nice_layer(nl)=i;
        nl=nl+1;
    end
end

for p_l=1:nl-1
% cluster
p_layer=nice_layer(p_l);


for i=1:k_c(p_layer)-1
    x_group(i,1)=CQmap_dis(CQ_index(p_layer,i),9);
    x_group(i,2)=CQmap_dis(CQ_index(p_layer,i),10);
end

cluster_num=int32(k_c(p_layer)/15);
[idx,C]= kmeans(x_group,cluster_num);
% Pick up one cluster per layer

for num=1:cluster_num

fix_in=1;
search_x=0;
search_y=0;
s_range=100;
s_count=1;
LBPc=1;

NSRc(1:13)=1;
for i=1:(k_c(p_layer)-1)

    if(CQ_index(p_layer,i)~=0 && idx(i)==num)
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
        LBP_nsr(LBPc)=LBP_ten(LBP_index);
        LBPc = LBPc + 1;
    end
end
    
    LBP_out(LBP_count)=mode(LBP_nsr);
    LBP_count = LBP_count + 1;
%     figure();
%     plot([1:9],[sum(NSR(1,:)')/NSRc(1) sum(NSR(2,:)')/NSRc(2) sum(NSR(3,:)')/NSRc(3) sum(NSR(4,:)')/NSRc(4)...
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
    NSR(:,:)=0;
    NSRsum(:)=9999;
end
end
  for h_c=1:length(out)
      h_data(h_count,1)=(out(2,h_c)-1)*0.01+0.9;
      h_data(h_count,2)=out(1,h_c);
      L_data(h_count,1)=LBP_out(h_c);
      L_data(h_count,2)=out(1,h_c);
      h_count=h_count+1;
  end
% scatter((out(2,:)-1)*0.01+0.9,out(1,:));
% xlim([1.19 1.22])
% ylim([0 9])
% hold on

end
figure();
hist3(h_data);

figure();
hist3(L_data);

% relation between LBP and NSR
re_Lc(1:10)=1;

for i=1:length(L_data)
    if(L_data(i,2)==0)
        re_L_data1(re_Lc(1))=L_data(i,1);
        re_Lc(1) = re_Lc(1) + 1;
    elseif(L_data(i,2)==1)
        re_L_data2(re_Lc(2))=L_data(i,1);
        re_Lc(2) = re_Lc(2) + 1;
    elseif(L_data(i,2)==2)
        re_L_data3(re_Lc(3))=L_data(i,1);
        re_Lc(3) = re_Lc(3) + 1;
    elseif(L_data(i,2)==3)
        re_L_data4(re_Lc(4))=L_data(i,1);
        re_Lc(4) = re_Lc(4) + 1;
    elseif(L_data(i,2)==4)
        re_L_data5(re_Lc(5))=L_data(i,1);
        re_Lc(5) = re_Lc(5) + 1;
    elseif(L_data(i,2)==5)
        re_L_data6(re_Lc(6))=L_data(i,1);
        re_Lc(6) = re_Lc(6) + 1;
    elseif(L_data(i,2)==6)
        re_L_data7(re_Lc(7))=L_data(i,1);
        re_Lc(7) = re_Lc(7) + 1;
    elseif(L_data(i,2)==7)
        re_L_data8(re_Lc(8))=L_data(i,1);
        re_Lc(8) = re_Lc(8) + 1;
    elseif(L_data(i,2)==8)
        re_L_data9(re_Lc(9))=L_data(i,1);
        re_Lc(9) = re_Lc(9) + 1;
    elseif(L_data(i,2)==9)
        re_L_data10(re_Lc(10))=L_data(i,1);
        re_Lc(10) = re_Lc(10) + 1;
    end
end
figure();
hist(re_L_data3);
figure();
hist(re_L_data4);
figure();
hist(re_L_data5);
figure();
hist(re_L_data6);
figure();
hist(re_L_data7);
figure();
hist(re_L_data8);
figure();
hist(re_L_data9);
figure();
hist(re_L_data10);

