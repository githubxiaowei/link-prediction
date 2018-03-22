function [ S ] =simi(M)
% nothing
S = zeros(size(M));


for i = 1:size(M,1)
    for j = 1:size(M,2)
        %S(i,j) = exp(-1*dis(M(i,:),M(j,:)));
        S(i,j) = M(i,:)*M()
    end
end

end

