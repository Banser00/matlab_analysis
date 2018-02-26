clc;clear;
CQmap_dis=xlsread('CQmap.xlsx');
datac=length(CQmap_dis);

for i=1:datac
   for j=1:24
       if (CQmap_dis(i,j)==CQmap_dis(i,j))
           if(j==1)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==3)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==5)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==7)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==9)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==11)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==13)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==15)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==17)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==19)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==21)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           elseif(j==23)
             NER(floor(j/2+1),i,1)=CQmap_dis(i,j);
             NER(floor(j/2+1),i,2)= CQmap_dis(i,j+1);
           end
       end
   end
end
count(1:20,1:12)=1;
 for i=1:12
     for j=1:length(NER)
        if(NER(i,j,2)>=0.4 && NER(i,j,2)< 0.5)
            if(NER(i,j,1)>0)
               final_NER1(i,count(1,i))=NER(i,j,1);
               count(1,i)=count(1,i)+1;
            end
        elseif(NER(i,j,2)>=0.5 && NER(i,j,2)< 0.6)
            if(NER(i,j,1)>0)
               final_NER2(i,count(2,i))=NER(i,j,1);
               count(2,i)=count(2,i)+1;
            end
        elseif(NER(i,j,2)>=0.6 && NER(i,j,2)< 0.7)
            if(NER(i,j,1)>0)
               final_NER3(i,count(3,i))=NER(i,j,1);
               count(3,i)=count(3,i)+1;
            end
        elseif(NER(i,j,2)>=0.7 && NER(i,j,2)< 0.8)
            if(NER(i,j,1)>0)
               final_NER4(i,count(4,i))=NER(i,j,1);
               count(4,i)=count(4,i)+1;
            end
        elseif(NER(i,j,2)>=0.8 && NER(i,j,2)< 0.9)
            if(NER(i,j,1)>0)
               final_NER5(i,count(5,i))=NER(i,j,1);
               count(5,i)=count(5,i)+1;
            end
        elseif(NER(i,j,2)>=0.9 && NER(i,j,2)< 1)
            if(NER(i,j,1)>0)
               final_NER6(i,count(6,i))=NER(i,j,1);
               count(6,i)=count(6,i)+1;
            end
        elseif(NER(i,j,2)>=1 && NER(i,j,2)< 1.1)
            if(NER(i,j,1)>0)
               final_NER7(i,count(7,i))=NER(i,j,1);
               count(7,i)=count(7,i)+1;
            end
        elseif(NER(i,j,2)>=1.1 && NER(i,j,2)< 1.2)
            if(NER(i,j,1)>0)
               final_NER8(i,count(8,i))=NER(i,j,1);
               count(8,i)=count(8,i)+1;
            end
        elseif(NER(i,j,2)>=1.2 && NER(i,j,2)< 1.3)
            if(NER(i,j,1)>0)
               final_NER9(i,count(9,i))=NER(i,j,1);
               count(9,i)=count(9,i)+1;
            end
        elseif(NER(i,j,2) >=1.3 && NER(i,j,2)< 1.4)
            if(NER(i,j,1)>0)
               final_NER10(i,count(10,i))=NER(i,j,1);
               count(10,i)=count(10,i)+1;
            end
        elseif(NER(i,j,2) >=1.4 && NER(i,j,2)< 1.5)
            if(NER(i,j,1)>0)
               final_NER11(i,count(11,i))=NER(i,j,1);
               count(11,i)=count(11,i)+1;
            end
        elseif(NER(i,j,2) >=1.5 && NER(i,j,2)< 1.6)
            if(NER(i,j,1)>0)
               final_NER12(i,count(12,i))=NER(i,j,1);
               count(12,i)=count(12,i)+1;
            end
        elseif(NER(i,j,2) >=1.6 && NER(i,j,2)< 1.7)
            if(NER(i,j,1)>0)
               final_NER13(i,count(13,i))=NER(i,j,1);
               count(13,i)=count(13,i)+1;
            end
        elseif(NER(i,j,2) >=1.7 && NER(i,j,2)< 1.8)
            if(NER(i,j,1)>0)
               final_NER14(i,count(14,i))=NER(i,j,1);
               count(14,i)=count(14,i)+1;
            end
        elseif(NER(i,j,2) >=1.8 && NER(i,j,2)< 1.9)
            if(NER(i,j,1)>0)
               final_NER15(i,count(15,i))=NER(i,j,1);
               count(15,i)=count(15,i)+1;
            end
        elseif(NER(i,j,2) >=1.9 && NER(i,j,2)< 2)
            if(NER(i,j,1)>0)
               final_NER16(i,count(16,i))=NER(i,j,1);
               count(16,i)=count(16,i)+1;
            end
        end
     end
 end
 s_count(1:12)=1;
for i=1:length(final_NER11)
    if(final_NER11(1,i)>0)
      sep1(s_count(1))=final_NER11(1,i);  
      s_count(1)= s_count(1)+1;
    end
    if(final_NER11(2,i)>0)
      sep2(s_count(2))=final_NER11(2,i);  
      s_count(2)= s_count(2)+1;
    end
    if(final_NER11(3,i)>0)
      sep3(s_count(3))=final_NER11(3,i);  
      s_count(3)= s_count(3)+1;
    end 
     if(final_NER11(4,i)>0)
      sep4(s_count(4))=final_NER11(4,i); 
      s_count(4)= s_count(4)+1;
     end
    if(final_NER11(5,i)>0)
      sep5(s_count(5))=final_NER11(5,i); 
      s_count(5)= s_count(5)+1;
    end
    if(final_NER11(6,i)>0)
      sep6(s_count(6))=final_NER11(6,i); 
      s_count(6)= s_count(6)+1;
    end
    if(final_NER11(7,i)>0)
      sep7(s_count(7))=final_NER11(7,i); 
      s_count(7)= s_count(7)+1;
    end
    if(final_NER11(8,i)>0)
      sep8(s_count(8))=final_NER11(8,i); 
      s_count(8)= s_count(8)+1;
    end
    if(final_NER11(9,i)>0)
      sep9(s_count(9))=final_NER11(9,i);
      s_count(9)= s_count(9)+1;
    end
    if(final_NER11(10,i)>0)
      sep10(s_count(10))=final_NER11(10,i);  
      s_count(10)= s_count(10)+1;
    end
    if(final_NER11(11,i)>0)
      sep11(s_count(11))=final_NER11(11,i);  
      s_count(11)= s_count(11)+1;
    end
    if(final_NER11(12,i)>0)
      sep12(s_count(12))=final_NER11(12,i) ; 
      s_count(12)= s_count(12)+1;
    end
end

v(1)=var(sep1)^0.5;
v(2)=var(sep2)^0.5;
v(3)=var(sep3)^0.5;
v(4)=var(sep4)^0.5;
v(5)=var(sep5)^0.5;
v(6)=var(sep6)^0.5;
v(7)=var(sep7)^0.5;
v(8)=var(sep8)^0.5;
v(9)=var(sep9)^0.5;
v(10)=var(sep10)^0.5;
v(11)=var(sep11)^0.5;
v(12)=var(sep12)^0.5;

m(1)=mean(sep1);
m(2)=mean(sep2);
m(3)=mean(sep3);
m(4)=mean(sep4);
m(5)=mean(sep5);
m(6)=mean(sep6);
m(7)=mean(sep7);
m(8)=mean(sep8);
m(9)=mean(sep9);
m(10)=mean(sep10);
m(11)=mean(sep11);
m(12)=mean(sep12);
figure()
plot(1:12,v);
figure()
plot(1:12,m);
