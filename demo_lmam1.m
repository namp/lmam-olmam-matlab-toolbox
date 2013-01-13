%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEMO_LMAM1 Levenberg-Marquardt with Adaptive Momentum (LMAM).
% Trains a neural network with no hidden units on the Sonar Data benchmark 
%	
% Nicholas Ampazis 2002
% email: abazis@iit.demokritos.gr
% $Revision: 1.0							  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Use the following so that newer Matlab versions do not display warnings 
%that some neural network functions are obsolete
nntwarn off 

%Range of weights initialization
n1=-0.1;
n2=0.1;

%Read training data
[Patterns,noin,nout,P,T]=bdfread('./data/sonar.bdf');

%Initialize weights and biases
rs1=rand('seed');
w1 =((n2-n1)*rand(nout,noin)+n1);
b1 =((n2-n1)*rand(nout,1)+n1);

%%%%%%%%%%%%%%%%%% LMAM CALLING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

df = 1;   % Frequency of progress displays (in epochs).
me = 500; % Maximum number of epochs to train.
dP = 0.6; % Hyperellipse radius
xi = 0.95; % Constrained regulator 
initmiu=0.001; % Initial mu value
tp = [df me dP xi initmiu NaN NaN NaN];
[w1,b1,ep,tr] = train_lmam(w1,b1,'logsig',P,T,tp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
