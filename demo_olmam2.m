%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEMO_OLMAM2 Optimized Levenberg-Marquardt with Adaptive Momentum (OLMAM).
% Trains a neural network with one hidden layer on the 2-Spirals data benchmark 
% Note: This type of network setting is the most common for problem solving 
% since most training tasks can be learned with a single hidden layer
%	
% Nicholas Ampazis 2002
% email: abazis@iit.demokritos.gr
% $Revision: 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Use the following so that newer Matlab versions do not display warnings 
%that some neural network functions are obsolete
nntwarn off 

%Set number of hidden units
nohid=30;

%Range of weights initialization
n1=-0.1;
n2=0.1;

%Read training data
[Patterns,noin,nout,P,T]=bdfread('./data/two_spirals.bdf');

%Initialize weights and biases
rs1=rand('seed');
w1 =((n2-n1)*rand(nohid,noin)+n1);
b1 =((n2-n1)*rand(nohid,1)+n1);
w2=((n2-n1)*rand(nout,nohid)+n1);
b2=((n2-n1)*rand(nout,1)+n1);

%%%%%%%%%%%%%%%%%% LMAM CALLING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

df = 1;   % Frequency of progress displays (in epochs).
me = 500; % Maximum number of epochs to train.
dP_div = 64; % Hyperellipse radius divisor
initmiu=0.001; % Initial mu value
tp = [df me dP_div NaN initmiu NaN NaN NaN];
[w1,b1,w2,b2,ep,tr] = train_olmam(w1,b1,'logsig',w2,b2,'logsig',P,T,tp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
