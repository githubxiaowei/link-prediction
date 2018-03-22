function [S] = Jaccard(M)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
S = zeros(size(M));
for i = 1:size(M,1)
    for j = i:size(M,2)
        S(i,j) = sum(M(i,:) & M(j,:))/sum(M(i,:) | M(j,:));
        S(j,i) = S(i,j);
    end
end

end

