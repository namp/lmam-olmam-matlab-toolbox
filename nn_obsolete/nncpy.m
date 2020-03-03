function b = nncpy(m,n)
%NNCPY Make copies of a matrix.
%
%	*WARNING*: This function is undocumented as it may be altered
%	at any time in the future without warning.

%	NNCPY copies matrices directly as appossed to interleaving
%   the copies as done by COPYINT.
%
% NNCPY(M,N)
%   M - Matrix.
%   N - Number of copies to make.
% Returns:
%   Matrix = [M M ...] where M appears N times.
%
% EXAMPLE: M = [1 2; 3 4; 5 6];
%          n = 3;
%          X = nncpy(M,n)
%
% SEE ALSO: nncpyi, nncpyd

% Mark Beale, 12-15-93
% Copyright (c) 1992-97 by The MathWorks, Inc.
% $Revision: 1.3 $  $Date: 1997/05/14 22:05:46 $

[mr,mc] = size(m);
b = zeros(mr,mc*n);
ind = 1:mc;
for i=[0:(n-1)]*mc
  b(:,ind+i) = m;
end