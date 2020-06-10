numsteps = 100; %number of timesteps simulated

A = [0.90, 0.07 ; 
     0.10, 0.93];
 
%list of states on this realization. xlist(k)=1 means in state 1 at
%timestep k, etc
states = zeros(1,numsteps);  

%initial state
states(1) = 1;

for k = 1:numsteps - 1
    % uniformly distributed random number between 0 and 1
    % We will use it for transitions from timesteps k to k+1
    rd = rand();
    
    if rd < A(1,states(k))  %for transition FROM states(k) to state 1
        states(k+1)=1;
    else
        states(k+1)=2;
    end

end

%----
figure
set(gca,'FontSize',18)
plot(1:numsteps,states,'.-','MarkerSize',20)
xlabel('timestep','FontSize',16)
ylabel('state','FontSize',16)

%% Exercise
% 0) What do you notice about the columns of A?
%    Does the same thing hold for the rows?
% 1) Simulate the chain for a long time (10,000 steps should be good).
%    Plot a histogram of the number of steps in state 1 or 2.
% 2) Compute the eigenvalues & eigenvectors. What do you notice about them?
% 3) Take the first eigenvector. Rescale it so that both entries are 
%    positive and it sums to 1. Multiply it by the number of time steps.
%    Compare this vector to the amount of time it spends in each state.
% 4) Modify the code to keep track of how long you are in state 1 before
%    changing to state 2. Plot the distribution of "dwell times",
%    the time it spends in that state before switching.