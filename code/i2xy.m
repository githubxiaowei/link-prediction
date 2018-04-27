function [ m,n ] = i2xy( i,V )
%
% 
m = floor((i+V -1)/V);
n = i-V*(m-1);
end

