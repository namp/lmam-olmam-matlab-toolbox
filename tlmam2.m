function [w1,b1,w2,b2,i,tr] = tlmam2(w1,b1,f1,w2,b2,f2,p,t,tp)
% TLMAM2 Train a feed-forward network with one hidden layer 
% with the Levenberg-Marquardt with Adaptive Momentum algorithm (LMAM).
%
%       [W1,B1,W2,B2,TE,TR] = TLMAM2(W1,B1,'F1',W2,B2,'F2',P,T)
%         Wi - Weight matrix of ith layer.
%         Bi - Bias vector of ith layer.
%         F  - Transfer function (string) of ith layer.
%         P  - RxQ matrix of input vectors.
%         T  - S2xQ matrix of target vectors.
%         TP - Training parameters (optional).
%       Returns:
%         Wi - new weights.
%         Bi - new biases.
%         TE - the actual number of epochs trained.
%         TR - training record: [row of errors]
%
%	Training parameters are:
%	  TP(1) - Epochs between updating display, default = 10.
%	  TP(2) - Maximum number of epochs to train, default = 1000.
%	  TP(3) - Hyperellipse radius dP, default = 0.05.
%	  TP(4) - Constrained regulator xi, default = 0.95.
%	  TP(5) - Initial value for MU, default = 0.001.
%	  TP(6) - Multiplier for increasing MU, default = 10.
%	  TP(7) - Multiplier for decreasing MU, default = 0.1.
%	  TP(8) - Maximum value for MU, default = 1e10.
%	Missing parameters and NaN's are replaced with defaults.
%
% (adapted from original code of the Matlab Neural Network Toolbox,
% Mark Beale, 12-15-93,
% Copyright (c) 1992-97 by The MathWorks, Inc.)
%
% Nicholas Ampazis 2002
% email: n.ampazis@fme.aegean.gr
% $Revision: 1.0
 
if nargin < 8,error('Not enough arguments.'),end
 
% TRAINING PARAMETERS
if nargin == 8, tp = []; end
tp = nndef(tp,[10 1000 0.05 0.95 0.001 10 0.1 1e10]);
df = tp(1);
me = tp(2);
dP = tp(3);
xi = tp(4);
mu_init = tp(5);
mu_inc = tp(6);
mu_dec = tp(7);
mu_max = tp(8);
df1 = feval(f1,'delta');
df2 = feval(f2,'delta');

margin=0.4999; %Classification margin
sigma1=0.1; %sigma1 of 1st Wolfe condition
eg=0; % error goal for graph display purposes
 
% DEFINE SIZES
[s1,r] = size(w1);
[s2,s1] = size(w2);
w1_ind = [1:(s1*r)];
b1_ind = [1:s1] + w1_ind(length(w1_ind));
w2_ind = [1:(s1*s2)] + b1_ind(length(b1_ind));
b2_ind = [1:s2] + w2_ind(length(w2_ind));
ii = eye(b2_ind(length(b2_ind)));
dw1 = w1; db1 = b1;
dw2 = w2; db2 = b2;
ext_p = nncpyi(p,s2);

% PRESENTATION PHASE
[a1,a2] = simuff(p,w1,b1,f1,w2,b2,f2);
e = t-a2;
new_e=e;
SSE = sumsqr(e);

% TRAINING RECORD
tr = zeros(1,me+1);
tr(1) = SSE;

% PLOTTING FLAG
plottype = (r==1) & (s2==1);

% PLOTTING
newplot;
message = sprintf('TRAIN_LMAM: %%g/%g epochs, mu = %%g, SSE = %%g.\n',me);
fprintf(message,0,mu_init,SSE)
if plottype
  h = plotfa(p,t,p,a2);
else
  h = ploterr(tr(1),eg);
end

mu = mu_init;

dxold=[w1(:); b1(:); w2(:); b2(:)];

for i=1:me
 
  % CHECK PHASE
  if abs(new_e) < margin, i=i-1; break, end
 
  % FIND JACOBIAN
 
  ext_a1 = nncpyi(a1,s2);
  d2 = feval(df2,a2);
  ext_d2 = -nncpyd(d2);
  ext_d1 = feval(df1,ext_a1,ext_d2,w2);
  j1 = learnlm(ext_p,ext_d1);
  j2 = learnlm(ext_a1,ext_d2);
  j = [j1, ext_d1', j2, ext_d2'];
  
  % CALCULATE GRADIENT
  je = j' * e(:);
 
  % INNER LOOP, INCREASE MU UNTIL THE ERRORS ARE REDUCED
  jj = j'*j;
  
  while (mu <= mu_max)
		      H=(jj+ii*mu);  
		      GJ=H\je;	     
                      IJJ=je'*GJ;       
                      IJF=je'*dxold;   
                      IFF=dxold'*H*dxold; 
		      DQ=-xi*dP*sqrt(IJJ);		      
		      miu1=0.5*(((IJJ*dP^2)-DQ^2)/(IFF*IJJ-IJF^2))^(-0.5);
		      lambda=(IJF-(2*miu1*DQ))/IJJ;
		      dx=-((lambda/(2*miu1))*GJ)+((1/(2*miu1))*dxold);
    dw1(:) = dx(w1_ind); db1 = dx(b1_ind);
    dw2(:) = dx(w2_ind); db2 = dx(b2_ind);
    new_w1 = w1 + dw1; new_b1 = b1 + db1;
    new_w2 = w2 + dw2; new_b2 = b2 + db2;
 
    % EVALUATE NEW NETWORK
    [a1,a2] = simuff(p,new_w1,new_b1,f1,new_w2,new_b2,f2);
    new_e = t-a2;
    new_SSE = sumsqr(new_e);
 
     if ( new_SSE < SSE + sigma1*(je'*dx) ), break, end
    mu = mu * mu_inc;
  end
  if (mu > mu_max), i = i-1; break, end
  mu = mu * mu_dec;
 
  % UPDATE NETWORK
  w1 = new_w1; b1 = new_b1;
  w2 = new_w2; b2 = new_b2;
  e = new_e; SSE = new_SSE;
 
  % TRAINING RECORD
  tr(i+1) = SSE;
 
  % PLOTTING
  if rem(i,df) == 0
    fprintf(message,i,mu,SSE)
    if plottype
      delete(h); h = plot(p,a2,'m'); drawnow;
    else
      h = ploterr(tr(1:(i+1)),eg,h);
    end
  end

dxold=dx;

end
 
% TRAINING RECORD
tr = tr(1:(i+1));
 
% PLOTTING
if rem(i,df) ~= 0
  fprintf(message,i,mu,SSE)
  if plottype
    delete(h);
    plot(p,a2,'m');
    drawnow;
  else
    ploterr(tr,eg,h);
  end
end
 
% WARNINGS
ccc= abs(new_e) > margin;

iccc=any(any(ccc));

if (iccc)
    disp(' ') 
    if (mu > mu_max)    
    disp('TRAIN_LMAM: Error gradient is too small to continue learning.')
    else
    disp('TRAIN_LMAM: Network error did not reach the error goal.')
    end  
    disp('  Further training may be necessary, or try different')
    disp('  initial weights and biases and/or more hidden neurons.')
    disp(' ')
tr=ones(1,me);
else
 disp(' ')   
 disp('TRAIN_LMAM: Success!')
 end
