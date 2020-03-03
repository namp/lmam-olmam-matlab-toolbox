function d = deltalog(a,d,w)
%DELTALOG Delta function for LOGSIG neurons.
%
%	DELATLIN(A)
%	  A - S1xQ matrix of output vectors.
%	Returns the S1xQ matrix of derivatives of the output vectors
%	  with respect to the net input of the PURELIN transfer function.
%
%	DELTALOG(A,E)
%	  E - S1xQ matrix of associated errors
%	Returns an S1xQ matrix of derivatives of error for an output layer.
%
%	DELTALOG(A,D,W)
%	  D - S2xQ matrix of next layer delta vectors
%	  W - S2xS1 weight matrix between layers.
%	Returns an S1xQ matrix of derivatives of error for a hidden layer.
%
%	See also NNTRANS, BACKPROP, LOGSIG, DELTALIN, DELTATAN

% Mark Beale, 1-31-92
% Revised 12-15-93, MB
% Copyright (c) 1992-97 by The MathWorks, Inc.
% $Revision: 1.3 $  $Date: 1997/05/14 21:56:04 $

if nargin < 1,error('Not enough input arguments'),end

if nargin == 1
  d = a.*(1-a);
elseif nargin == 2
  d = a.*(1-a).*d;
else
  d = a.*(1-a).*(w'*d);
end
