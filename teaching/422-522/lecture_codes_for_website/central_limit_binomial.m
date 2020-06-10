clear all 
close all

i = 1.;
p = 0.2;
num_pts = 2000;

% Exercise:
% Simulate 100 coin tosses where the probability of heads
% is p. Do this num_pts many times and plot the histogram
% of the number of heads.

% Now compare to binomial distribution
for N = 100
    % R = binord(N, p, num_pts); % newer matlab
    R = random('bino', N, p, [num_pts, 1]);
    figure
    I = R*i;
    hist(I)
    m = N*p; % mean
    s = sqrt(N*p*(1-p)); % standard dev.
    vline([m, m+3*s, m-3*s])
end
