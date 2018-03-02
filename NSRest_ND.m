clc;clear;
edge=xlsread('record.xlsx');
datae=length(edge);

for i=1:datae
    for j=1:11
       if(j>1 && edge(i,j)==0)
          edge(i,j)=edge(i,j-1); 
       end
       if(j>1)
           if(abs(edge(i,j)-edge(i,j-1))>0.01)
               LBP_ND(i,j-1) = 1;
           else
               LBP_ND(i,j-1) = 0;
           end
       end
    end
    for j=12:33
       if(edge(i,j)==0)
          edge(i,j)=edge(i,j-1); 
       end        
    end
    NE(i,:)=edge(i,1:11);
    NE1(i,:)=edge(i,12:22);
    NE2(i,:)=edge(i,23:33);
    for j=1:11
        if(abs(NE1(i,j)-NE(i,j))>0.01)
            LBP_NE1(i,j)= 1;
        else
            LBP_NE1(i,j)= 0;
        end
        if(abs(NE2(i,j)-NE(i,j))>0.01)
            LBP_NE2(i,j)= 1;
        else
            LBP_NE2(i,j)= 0;
        end
    end
    
    LBP_ten(i) = LBP_ND(i,1)*(2^9) + LBP_ND(i,2)*(2^8) + ...
       LBP_ND(i,3)*(2^7) + LBP_ND(i,4)*(2^6) + LBP_ND(i,5)*(2^5) + ...
       LBP_ND(i,6)*(2^4) + LBP_ND(i,7)*(2^3) + LBP_ND(i,8)*(2^2) + ...
       LBP_ND(i,9)*(2^1) + LBP_ND(i,10)*(2^0);
 
    LBP_ten1(i) = LBP_NE1(i,1)*(2^9) + LBP_NE1(i,2)*(2^8) + ...
       LBP_NE1(i,3)*(2^7) + LBP_NE1(i,4)*(2^6) + LBP_NE1(i,5)*(2^5) + ...
       LBP_NE1(i,6)*(2^4) + LBP_NE1(i,7)*(2^3) + LBP_NE1(i,8)*(2^2) + ...
       LBP_NE1(i,9)*(2^1) + LBP_NE1(i,10)*(2^0);
   
    LBP_ten2(i) = LBP_NE2(i,1)*(2^9) + LBP_NE2(i,2)*(2^8) + ...
       LBP_NE2(i,3)*(2^7) + LBP_NE2(i,4)*(2^6) + LBP_NE2(i,5)*(2^5) + ...
       LBP_NE2(i,6)*(2^4) + LBP_NE2(i,7)*(2^3) + LBP_NE2(i,8)*(2^2) + ...
       LBP_NE2(i,9)*(2^1) + LBP_NE2(i,10)*(2^0);
end

% NSR estimation
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

scale=0.01;
frame_cnt=1;
lastNSR=0;
h_count=1;
count=1;
% Preprocessing
for frame = 0:0.05:0.1
    k_c(1:101)=1;
    NSR(1:9,1)=0;
 
    LBP_count=1;
    for i=int32(frame*datac+1):int32((frame+0.05)*datac)
        for k=1.2:scale:1.2
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
        LBP_nsr(LBPc)=LBP_ten(LBP_index);
        LBP_nsr1(LBPc)=LBP_ten1(LBP_index);
        LBP_nsr2(LBPc)=LBP_ten2(LBP_index);
        LBP_cq(LBPc)=CQ_index(p_layer,i);
        LBPc = LBPc + 1;
    end
end
    
    LBP_out(LBP_count)=mode(LBP_nsr);
    LBP_count = LBP_count + 1;
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
        str = sprintf('%d | %d | %d | %d | %d',LBP_cq(LC),LBP_nsr(LC) ,LBP_nsr1(LC),LBP_nsr2(LC),out(1,count-1));
        figure();
        plot([1:9],NSR(:,LC));
        title(str);
    end
    NSR(:,:)=0;
    NSRsum(:)=9999;
end
%   for h_c=1:length(out)
%       h_data(h_count,1)=(out(2,h_c)-1)*0.01+0.9;
%       h_data(h_count,2)=out(1,h_c);
%       L_data(h_count,1)=LBP_out(h_c);
%       L_data(h_count,2)=out(1,h_c);
%       h_count=h_count+1;
%   end
% scatter((out(2,:)-1)*0.01+0.9,out(1,:));
% xlim([1.19 1.22])
% ylim([0 9])
% hold on

end
% figure();
% hist3(h_data);
% 
% figure();
% hist3(L_data);
% 
% % relation between LBP and NSR
% re_Lc(1:10)=1;
% 
% for i=1:length(L_data)
%     if(L_data(i,2)==0)
%         re_L_data1(re_Lc(1))=L_data(i,1);
%         re_Lc(1) = re_Lc(1) + 1;
%     elseif(L_data(i,2)==1)
%         re_L_data2(re_Lc(2))=L_data(i,1);
%         re_Lc(2) = re_Lc(2) + 1;
%     elseif(L_data(i,2)==2)
%         re_L_data3(re_Lc(3))=L_data(i,1);
%         re_Lc(3) = re_Lc(3) + 1;
%     elseif(L_data(i,2)==3)
%         re_L_data4(re_Lc(4))=L_data(i,1);
%         re_Lc(4) = re_Lc(4) + 1;
%     elseif(L_data(i,2)==4)
%         re_L_data5(re_Lc(5))=L_data(i,1);
%         re_Lc(5) = re_Lc(5) + 1;
%     elseif(L_data(i,2)==5)
%         re_L_data6(re_Lc(6))=L_data(i,1);
%         re_Lc(6) = re_Lc(6) + 1;
%     elseif(L_data(i,2)==6)
%         re_L_data7(re_Lc(7))=L_data(i,1);
%         re_Lc(7) = re_Lc(7) + 1;
%     elseif(L_data(i,2)==7)
%         re_L_data8(re_Lc(8))=L_data(i,1);
%         re_Lc(8) = re_Lc(8) + 1;
%     elseif(L_data(i,2)==8)
%         re_L_data9(re_Lc(9))=L_data(i,1);
%         re_Lc(9) = re_Lc(9) + 1;
%     elseif(L_data(i,2)==9)
%         re_L_data10(re_Lc(10))=L_data(i,1);
%         re_Lc(10) = re_Lc(10) + 1;
%     end
% end
% figure();
% hist(re_L_data3);
% figure();
% hist(re_L_data4);
% figure();
% hist(re_L_data5);
% figure();
% hist(re_L_data6);
% figure();
% hist(re_L_data7);
% figure();
% hist(re_L_data8);
% figure();
% hist(re_L_data9);
% figure();
% hist(re_L_data10);

