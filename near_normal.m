clc;clear;

matname='deskY.mat';

txtname='record2_desk.txt';
fileID = fopen(txtname,'r');
formatSpec = '%f';
edgein = fscanf(fileID,formatSpec);
edge=reshape(edgein,98,length(edgein)/98);
edge=edge';
datae=length(edge);

LBP = edge;

% NSR estimation
% CQmap_dis=xlsread('CQmap.xlsx');

txtname='CQmap2_desk.txt';

fileID = fopen(txtname,'r');
formatSpec = '%f';
CQin = fscanf(fileID,formatSpec);
CQmap_dis=reshape(CQin,11,length(CQin)/11);
CQmap_dis=CQmap_dis';

datac=length(CQmap_dis);


% check data
if(datac/datae ~= 13)
    warning('data no match')
end

cnt=1;
progess_1=0;
for i=1:13:datac
    progess=int32(100*i/datac)

    pos_pool(cnt,1)=CQmap_dis(i,11);
    for j=0:8
        u=CQmap_dis(i+j,3:5);
        v=CQmap_dis(i+j,6:8);
        if((u(1)==0 && u(2)==0 && u(3)==0) || (v(1)==0 && v(2)==0 && v(3)==0))
            pos_pool(cnt,2+j*3)=CQmap_dis(i+j,9);
            pos_pool(cnt,3+j*3)=CQmap_dis(i+j,10);            
        else
            pos_pool(cnt,2+j*3)=CQmap_dis(i+j,9);
            pos_pool(cnt,3+j*3)=CQmap_dis(i+j,10);
        end
        
        if(acosd(dot(u,v)/(norm(u)*norm(v))) == acosd(dot(u,v)/(norm(u)*norm(v))))
            pos_pool(cnt,4+j*3)=acosd(dot(u,v)/(norm(u)*norm(v)));
            lastNSR=acosd(dot(u,v)/(norm(u)*norm(v)));
        else
            pos_pool(cnt,4+j*3)=nan;
            
        end
        
    end
    LBP_pool(cnt,:)=edge(cnt,:);
    cnt=cnt+1;
end
save(matname,'LBP_pool','pos_pool');