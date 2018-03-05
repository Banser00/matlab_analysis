clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

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
    elseif(edge_pool(i,2)>edge_pool(i+1,2))
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
    edge_pool(i,3)=min(ind_pool);
    ind_pool(:)=0;
end