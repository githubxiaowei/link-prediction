function [ S ] = salton( M )
%calculate the similarity of the nodes in M
%   

S = zeros(size(M));
len = zeros(size(M,1));
for i = 1:size(M,1)
    len(i) = sum(M(i,:));
end
for i = 1:size(M,1)
    for j = 1:size(M,2)
        S(i,j) = M(i,:)*M(j,:)'/sqrt(len(i)*len(j));
    end
end

end

