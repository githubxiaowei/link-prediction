function [ dis] = dis( A,B )
% distance between two matrix
%  
E = A-B;
dis = sqrt(E(:)'*E(:));
end

