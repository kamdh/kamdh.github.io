clear all

set(0,'defaultTextFontSize',14)
set(0,'DefaultAxesFontSize',14)

Ntrials=10000;

h=0.001;
numsteps=round(1/h);

alpha=1/2;

xlist=[];

for N=1:Ntrials
    x=0;
    
    for j=1:numsteps
    x=x+randn*h^alpha;
    end
    
    xlist=[xlist x];
    
end


figure
hist(xlist,100);
title(sprintf('Stepsize=%g',h))