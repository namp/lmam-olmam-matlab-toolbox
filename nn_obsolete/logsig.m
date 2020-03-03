function a = logsig(n,b)
%LOGSIG Log sigmoid transfer function.
%
%	LOGSIG(N)
%	  N - SxQ Matrix of net input (column) vectors.
%	Returns the values of N squashed between 0 and 1.
%
%	EXAMPLE: n = -10:0.1:10;
%	         a = logsig(n);
%	         plot(n,a)
%
%	LOGSIG(Z,B) ...Used when Batching.
%	  Z - SxQ Matrix of weighted input (column) vectors.
%	  B - Sx1 Bias (column) vector.
%	Returns the squashed net input values found by adding
%	  B to each column of Z.
%
%	LOGSIG('delta') returns name of delta function.
%	LOGSIG('init') returns name of initialization function.
%	LOGSIG('name') returns full name of this transfer function.
%	LOGSIG('output') returns output range of this function.
%
%	See also NNTRANS, BACKPROP, NWTAN, LOGSIG.

% Mark Beale, 1-31-92
% Revised 12-15-93, MB
% Copyright (c) 1992-97 by The MathWorks, Inc.
% $Revision: 1.3 $  $Date: 1997/05/14 22:03:30 $

if nargin < 1, error('Note enough arguments.'); end

if isstr(n)
  if strcmp(lower(n),'delta')
    a = 'deltalog';
  elseif strcmp(lower(n),'ddelta')
    a = 'ddeltalog';
  elseif strcmp(lower(n),'init')
    a = 'nwlog';
  elseif strcmp(lower(n),'name')
    a = 'Log Sigmoid';
  elseif strcmp(lower(n),'output')
    a = [0 1];
  else
    error('Unrecognized property.')
  end
else
  if nargin==2
    [nr,nc] = size(n);
    n = n + b*ones(1,nc);
  end
  a = 1 ./ (1+exp(-n));
  i = find(~isfinite(a));
  a(i) = sign(n(i))*0.5 + 0.5;
end
