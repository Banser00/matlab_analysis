count=1;
for k=1:330
   if(speed_cnt(k)<0.013995 && speed_cnt(k)>0.013993) 
       check(1,count)=k;
       check(2,count)=mean_cnt(k);
       count=count+1;
   end
end

%  scatter(speed_cnt,mean_cnt)
%  ylim([60 140]);
%  xlim([0 0.02]);

% figure;
% bar([40:8:192],all_CQ);
% ylim([0 3000])
% xlim([40 200]);
% title('Near edge histogram');
% xlabel('distance (cm)');
% ylabel('count');
% figure;
% bar([40:8:192],good_CQ);
% ylim([0 3000])
% title('Top 10% CQ histogram');
% xlabel('distance (cm)');
% ylabel('count');
% 
% for i=1:20
%    prob(i)=good_CQ(i)/all_CQ(i); 
%    if(all_CQ(i)==0)
%       prob(i)=0; 
%    end
% end
% figure;
% bar([40:8:192],prob);
% title('X/Y');
% xlabel('distance (cm)');
% ylabel('probability (%)');
% 
% figure;
% bar([40:8:192],prob/sum(prob));
% title('Normalize X/Y curve');
% xlabel('distance (cm)');
% ylabel('probability (%)');
% 
% 
% figure;
% plot([40:8:192],prob/(8*sum(prob)));
% title('Probability Density');
% xlabel('distance (cm)');
% ylabel('probability density(%)');
% hold on
% 
% s_cnt=1;
% for z=0.4:0.08:1.92
%    sigma(s_cnt)=1/(0.0012+0.0019*((z-0.4)^2)); 
%    s_cnt=s_cnt+1;
% end
% 
% plot([40:8:192],sigma/(8*sum(sigma)));
% hold on
% mean_l=dot([40:8:192],prob/sum(prob));
%  pd = makedist('Normal','mu',mean_l,'sigma',(var_cnt(1))^0.5);
%  t = truncate(pd,40,200)
%  x = 40:1:200;
%  plot(x,pdf(t,x),'Color','red','LineWidth',2)
% hold off
% legend('Top 10% CQ','Noise model','truncated normal distribution');

% scatter(speed_cnt,mean_cnt);
% xlabel('speed (m/s)');
% ylabel('mean (cm)');
% title('modified xyz');
% ylim([40 150]);
% xlim([0 0.04]);