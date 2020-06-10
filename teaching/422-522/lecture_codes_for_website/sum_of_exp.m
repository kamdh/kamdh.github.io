klist=1:2:100;

r1=1/5;
r2=1/100;

explist1=exp(-r1*klist);
explist2=exp(-r2*klist);

% for sum you could also do:
f = @(k) exp(-r1*k) + exp(-r2*k);

figure
bar(klist,(explist1))
xlabel('k','FontSize',18)
title('exponential')
set(gca,'Fontsize',18)

figure
bar(klist,log(explist1))
xlabel('k')
title('log of exponential -- well fit by line')
set(gca,'Fontsize',18)


figure
bar(klist,(explist1+explist2))
xlabel('k')
title('sum of exponentials')
set(gca,'Fontsize',18)


figure
bar(klist,log(explist1+explist2))
xlabel('k')
title('log of sum of exponentials -- not well fit by line')
set(gca,'Fontsize',18)


% figure
% subplot(121)
% set(gca,'Fontsize',18)
% bar(klist,(explist1+explist2))
% xlabel('k')
% title('split into two ranges')
% axis([0 15 -Inf Inf])
% subplot(122)
% set(gca,'Fontsize',18)
% bar(klist,(explist1+explist2))
% xlabel('k')
% axis([15 100 -Inf Inf])
