function [a,b,c,d,e,f,g,h] = train_lmam(i,j,k,l,m,n,o,p,q,r,s,t)
%TRAIN_LMAM Train feed-forward network with with 0, 1 or 2 hidden layers 
%with the Levenberg Marquardt with Adaptive Momentum (LMAM) algorithm.
%The general design is much the same as the design of the 
%functions in the Neural Network (NN) Toolbox from MathWorks even though the
%calling sequences differ. See Neural Network Toolbox User's Guide from the
%MathWorks Inc.
%
%You can find more details of the algorithm in the following papers by N. Ampazis, and S. J. Perantonis:
% 1) "Levenberg-Marquardt Algorithm with Adaptive Momentum for the Efficient Training of Feedforward Networks", in Proceedings of International Joint Conference on Neural Networks IJCNN' 2000 , Como, Italy. 
% 2) "Two Highly Efficient Second Order Algorithms for Training Feedforward Networks",  IEEE Transactions on Neural Networks Vol. 13, No. 5, September 2002
%
%Calling sequence:	
%	[W1,B1,W2,B2,...,TE,TR] = TRAIN_LMAM(W1,B1,F1,W2,B2,F2,...,P,T,TP)
%	  Wi - SixR weight matrix for the ith layer.
%	  Bi - S1x1 bias vector for the ith layer.
%	  Fi - Transfer function (string) for the ith layer.
%	  P  - RxQ matrix of input vectors.
%	  T  - SxQ matrix of target vectors.
%	  TP - Training parameters (optional).
%	Returns new weights and biases and
%	  Wi - new weights.
%	  Bi - new biases.
%	  TE - the actual number of epochs trained.
%	  TR - training record: [row of errors]
%	
%	Training parameters are:
%	  TP(1) - Epochs between updating display, default = 25.
%	  TP(2) - Maximum number of epochs to train, default = 1000.
%	  TP(3) - Hyperellipse radius dP, default = 0.05.
%	  TP(4) - Constrained regulator xi, default = 0.95.
%	  TP(5) - Initial value for MU, default = 0.001.
%	  TP(6) - Multiplier for increasing MU, default = 10.
%	  TP(7) - Multiplier for decreasing MU, default = 0.1.
%	  TP(8) - Maximum value for MU, default = 1e10.
%	Missing parameters and NaN's are replaced with defaults.
%	
% Nicholas Ampazis 2002
% email: abazis@iit.demokritos.gr
% $Revision: 1.0

if all([5 6 8 9 11 12] ~= nargin),error('Wrong number of input arguments'),end

if nargin == 5
  [a,b,c,d] = tlmam1(i,j,k,l,m);
elseif nargin == 6
  [a,b,c,d] = tlmam1(i,j,k,l,m,n);
elseif nargin == 8
  [a,b,c,d,e,f] = tlmam2(i,j,k,l,m,n,o,p);
elseif nargin == 9
  [a,b,c,d,e,f] = tlmam2(i,j,k,l,m,n,o,p,q);
elseif nargin == 11
  [a,b,c,d,e,f,g,h] = tlmam3(i,j,k,l,m,n,o,p,q,r,s);
elseif nargin == 12
  [a,b,c,d,e,f,g,h] = tlmam3(i,j,k,l,m,n,o,p,q,r,s,t);
end
