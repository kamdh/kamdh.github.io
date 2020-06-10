clear all
close all

p=.4; %fraction of cells that survive each reproduction

%Define vector n(t):  number of cells per generation
n(1)=1000; %initial number of cells (generation 0)
generation_end=20;  %predict up to this generation in the future

for t=1:generation_end-1
    n(t+1)=4*n(t)*p ;
end

figure
plot(n,'.','MarkerSize',24)
ylabel('n(t)','FontSize',20)
xlabel('t','FontSize',20)
set(gca,'FontSize',20)

ts = 1:generation_end;
hold all
plot(ts, (4*p).^(ts-1)*n(1),'r-')