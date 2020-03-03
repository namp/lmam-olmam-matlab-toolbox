function y=nndef(x,d)
%NNDEF Replace missing and NaN values with defaults.
%
%	*WARNING*: This function is undocumented as it may be altered
%	at any time in the future without warning.

% NNDEF(X,D)
%   X - Row vector of proposed values.
%   D - Row vector of default values.
% Returns X with all non-finite and missing values with
%   the corresponding values in D.
%
% EXAMPLE: x = [1 2 NaN 4 5];
%          d = [10 20 30 40 50 60];
%          y = nndef(x,d)

% Mark Beale, 12-15-93
% Copyright (c) 1992-97 by The MathWorks, Inc.
% $Revision: 1.3 $  $Date: 1997/05/14 22:06:40 $

y = d;
i = find(isfinite(x(1:min(length(x),length(y)))));
y(i) = x(i);
