clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
CQ_count=1;
jump = 0;
for i = 1:int32(0.6*datac)
    for j=5:44
       if(mod(j,4)==1  &&  CQmap_dis(i,j+3)<=2)
           All_CQ(CQ_count,1)= CQmap_dis(i,j);   % CQ 
           All_CQ(CQ_count,2)= CQmap_dis(i,j+3); % depth
           All_CQ(CQ_count,3)= floor(j/4+1);     % width
           CQ_count = CQ_count + 1;
          
       end      
    end
end

% sorting

for i=1:(length(All_CQ)-1)
   for  j=1:(length(All_CQ)-1)
      if(All_CQ(j,1)<All_CQ(j+1,1))
         temp1 = All_CQ(j,1);
         temp2 = All_CQ(j,2);
         temp3 = All_CQ(j,3);
         All_CQ(j,1) = All_CQ(j+1,1);
         All_CQ(j,2) = All_CQ(j+1,2);
         All_CQ(j,3) = All_CQ(j+1,3);
         All_CQ(j+1,1) = temp1;
         All_CQ(j+1,2) = temp2;
         All_CQ(j+1,3) = temp3;
      end     
   end  
end

figure();
hist3([x_all' D_all']);
ylim([0.005 0.02])

figure();
plot([1:length(All_CQ)],All_CQ(:,1));
figure();
scatter([1:length(All_CQ)],All_CQ(:,2));
figure();
hist(All_CQ(1:floor(0.01*length(All_CQ)),3));
xlabel('Width')
figure();
hist3([All_CQ(1:floor(0.1*length(All_CQ)),3) All_CQ(1:floor(0.1*length(All_CQ)),2)],[10 12]);
xlabel('Width'); ylabel('depth');
figure();
[Xf bins] = hist3([All_CQ(1:floor(0.1*length(All_CQ)),3) All_CQ(1:floor(0.1*length(All_CQ)),2)],[10 12]);
bar3([[Xf(:,1)/sum(Xf(:,1))] [Xf(:,2)/sum(Xf(:,2))] [Xf(:,3)/sum(Xf(:,3))] [Xf(:,4)/sum(Xf(:,4))] [Xf(:,5)/sum(Xf(:,5))] ...
    [Xf(:,6)/sum(Xf(:,6))] [Xf(:,7)/sum(Xf(:,7))] [Xf(:,8)/sum(Xf(:,8))] [Xf(:,9)/sum(Xf(:,9))] [Xf(:,10)/sum(Xf(:,10))]...
    [Xf(:,11)/sum(Xf(:,11))] [Xf(:,12)/sum(Xf(:,12))]]);