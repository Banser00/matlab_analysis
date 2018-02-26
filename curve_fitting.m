xdata=speed_cnt';
ydata=mean_cnt';

f=fittype('a*x+b');
[fit1,gof,fitinfo] = fit(xdata,ydata,f);
residuals = fitinfo.residuals;
I = abs( residuals) > 1.5 * std( residuals );
outliers = excludedata(xdata,ydata,'indices',I);
fit2 = fit(xdata,ydata,f,'Exclude',outliers);
plot(fit1,'r-',xdata,ydata,'k.',outliers,'m*')
hold on
plot(fit2,'b--')
xlabel('speed (m/s)');
ylabel('mean (cm)');
title('tran xyz');
 ylim([0 12]);
 xlim([0 0.02]);