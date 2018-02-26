
% p=[[5,8,8,8,8,4,7,6,6,6,2]
% [6,6,5,5,6,6,6,5,6,6,5]
% [8,8,4,5,7,5,7,6,5,6,5]
% [9,8,6,5,5,7,5,6,5,3,5]
% [6,6,5,6,6,5,6,6,6,3,5]
% [5,5,6,4,6,7,5,4,6,6,4]
% [5,5,6,5,8,7,5,6,5,6,4]];
p=out;
count=1;
[height width]=size(p)
scale=0.01
for i=0.9:0.01:1.9
   for j=1:height
     d(j,count)=p(j,count)*i/517;
   end
   count = count + 1;
end

figure();

for i=1:height
  scatter([0.9:0.01:1.9],d(i,:));
  if i == 1
    D_all=d(i,:)
    x_all = [0.9:0.01:1.9];
  else
    D_all=[ D_all d(i,:)];
    x_all = [x_all [0.9:0.01:1.9]];
  end
  hold on;
end

% get rid of zero
t_count=1;
for i = 1:length(D_all)
    if(D_all(i)~=0)
        Dt_all(t_count)=D_all(i);
        xt_all(t_count)=x_all(i);
        t_count=t_count+1;
    end
end

xdata=xt_all';
ydata=Dt_all';
figure();
f=fittype('a*x+b');
[fit1,gof,fitinfo] = fit(xdata,ydata,f);
residuals = fitinfo.residuals;
I = abs( residuals) > 1.5 * std( residuals );
outliers = excludedata(xdata,ydata,'indices',I);
fit2 = fit(xdata,ydata,f,'Exclude',outliers);
plot(fit1,'r-',xdata,ydata,'k.',outliers,'m*')
hold on
plot(fit2,'b--')
xlabel('depth (m)');
ylabel('width (m)');
title('tran xyz');
 ylim([0 0.05]);

%  hold on
%  ylim([0 0.04]);
%  plot([0.9:0.1:1.9],d2);
%  hold on
%  plot([0.9:0.1:1.9],d3);
%  hold on
%  plot([0.9:0.1:1.9],d4);
%  hold on
%  plot([0.9:0.1:1.9],d5);
%  hold on
%  plot([0.9:0.1:1.9],[0.0131 0.0131 0.0131 0.0131 0.0131 0.0131 0.0131...
%      0.0131 0.0131 0.0131 0.0131]);
%  xlabel('depth (m)');
%  ylabel('NSR (m)');
%  legend('SEQ1','SEQ2','SEQ3','SEQ4','SEQ5','average');