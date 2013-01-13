%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEMO_LMAM3 Levenberg-Marquardt with Adaptive Momentum (LMAM).
% Trains a neural network with two hidden layers on the 4-Parity data benchmark 
%
% Note: This network is redundant since this problem can be solved with a 
% network which has only one hidden layer with 4 nodes. 
% This demo just shows the use of the routines with a network with more than 
% one hidden layer
%
%	
% Nicholas Ampazis 2002
% email: abazis@iit.demokritos.gr
% $Revision: 1.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Use the following so that newer Matlab versions do not display warnings 
%that some neural network functions are obsolete
nntwarn off 
warning off

%Set number of hidden units
nohid1=4; %Hidden units of first layer
nohid2=4; %Hidden units of second layer

%Range of weights initialization
n1=-0.1;
n2=0.1;

%Read training data
[Patterns,noin,nout,P,T]=bdfread('./data/parity4.bdf');

%Initialize weights and biases
rs1=rand('seed');
w1 =((n2-n1)*rand(nohid1,noin)+n1);
b1 =((n2-n1)*rand(nohid1,1)+n1);
w2=((n2-n1)*rand(nohid2,nohid1)+n1);
b2=((n2-n1)*rand(nohid2,1)+n1);
w3=((n2-n1)*rand(nout,nohid2)+n1);
b3=((n2-n1)*rand(nout,1)+n1);

%%%%%%%%%%%%%%%%%% LMAM CALLING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

df = 1;   % Frequency of progress displays (in epochs).
me = 500; % Maximum number of epochs to train.
dP = 0.01; % Hyperellipse radius
xi = 0.95; % Constrained regulator 
initmiu=0.001; % Initial mu value
tp = [df me dP xi initmiu NaN NaN NaN];
[w1,b1,w2,b2,w3,b3,ep,tr] = train_lmam(w1,b1,'logsig',w2,b2,'logsig',w3,b3,'logsig',P,T,tp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
