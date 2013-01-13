function [NP,NI,NO,X,T] = bdfread(filename)
% A utility that reads training data stored in the Billnet Data Format (BDF)
% Billnet is a free neural network simulator available at 
% http://www.iit.demokritos.gr/~vasvir/billnet/billnet.html
% Details of this data format can be found at 
% http://www.iit.demokritos.gr/~vasvir/billnet/doc/progrg-6.html
%
% The function returns:
%	  NP - number of patterns.
%	  NI - number of inputs (dimensionality of the problem)
%	  NO - number of outputs
%	  X - input data vectors.
%	  T - target vectors.
%
% Nicholas Ampazis 2002
% email: n.ampazis@fme.aegean.gr
% $Revision: 1.0

fid=fopen(filename,'r');

if fid==-1
  error('Cannot open file');
end

NP=fscanf(fid,'%g',1);
NI=fscanf(fid,'%g',1);
NX=fscanf(fid,'%g',1);

Action=fscanf(fid,'%s',1);
if (strncmp(Action,'classify',length(Action)))
  class=1;
else
  class=0;
end

if (class)
  Encoding=fscanf(fid,'%s',1);
  Expand=fscanf(fid,'%s',1);
  if (strncmp(Expand,'expand',length(Expand)))
    expand=1;
    error('This is a classification problem which needs to be expanded');
    fclose(fid);
   else 		%Data Allready expanded
     NO=NX;
   end
else
  NO=NX;
end

[BDFDATA,COUNT] = fscanf(fid,'%g',[NI+NO,NP]);

fclose(fid);

X=BDFDATA([1:NI],:);
T=BDFDATA([NI+1:NI+NO],:);



