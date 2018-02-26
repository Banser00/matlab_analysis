clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);
count=1;
src_count=1;
test=4;
for i=1:datac
   if(count==test)
      src_tran(src_count,1) = CQmap_dis(i,3);
      src_tran(src_count,2) = CQmap_dis(i,4);
      src_tran(src_count,3) = CQmap_dis(i,5);
      src_count = src_count + 1 ;
   end
   if(count== (test+1))
      src0(src_count,1) =   CQmap_dis(i,1);
      src0(src_count,2) =   CQmap_dis(i,2);
      src0(src_count,3) =   CQmap_dis(i,5);
      src1(src_count,1) =   CQmap_dis(i,1);
      src1(src_count,2) =   CQmap_dis(i,2);
      src1(src_count,3) =   CQmap_dis(i,5);
      src2(src_count,1) =   CQmap_dis(i,1);
      src2(src_count,2) =   CQmap_dis(i,2);
      src2(src_count,3) =   CQmap_dis(i,5);
      src_count = src_count + 1 ;
   end
   if(count == (test+2))
       break;
   end 
   if( CQmap_dis(i,1)==999)
      src_count = 1;
      count =count + 1 ; 
   end
end

edgec_t=length(src_tran);
edgec=length(src0);
find0=0;
find1=0;
find2=0;
unfind0=0;
unfind1=0;
unfind2=0;
for i=1:edgec_t
    pair0=0;
    pair1=0;
    pair2=0;

    for j = 1:edgec
        if(abs(src_tran(i,1)-src0(j,1))<=0 && abs(src_tran(i,2)-src0(j,2))<=0)
            pair0 = 1;
            src0(j,1)=0;
            src0(j,2)=0;
            error0(i)=src_tran(i,3)-src0(j,3);
            break;
        end
    end
    for j = 1:edgec
        if(abs(src_tran(i,1)-src1(j,1))<=1 && abs(src_tran(i,2)-src1(j,2))<=1)
            pair1 = 1;
            src1(j,1)=0;
            src1(j,2)=0;
            error1(i)=src_tran(i,3)-src1(j,3);
            break;
        end
    end
    for j = 1:edgec
        if(abs(src_tran(i,1)-src2(j,1))<=2 && abs(src_tran(i,2)-src2(j,2))<=2)
            pair2 = 1;
            src2(j,1)=0;
            src2(j,2)=0;
            error2(i)=src_tran(i,3)-src2(j,3);
            break;
        end
    end
    if(pair0)
        find0 = find0 + 1 ;
    else
        unfind0 = unfind0 + 1;
    end
    
    if(pair1)
        find1 = find1 + 1 ;
    else
        unfind1 = unfind1 + 1;
        end
    
    if(pair2)
        find2 = find2 + 1 ;
    else
        unfind2 = unfind2 + 1;
    end
end

 src_p0=find0/edgec_t;
 src_p1=find1/edgec_t;
 src_p2=find2/edgec_t;
 
 OF0=mean(error0)
 OF1=mean(error1)
 OF2=mean(error2)
 
 