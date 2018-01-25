function [ s ] = score( A,B )
% accuracy
% 
s = A(:)'*B(:)/sum(A(:));
end

