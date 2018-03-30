function [ S ] =simi(adjacent_matrix)
% nothing
S = zeros(size(adjacent_matrix));

alpha_global = alpha(adjacent_matrix)

for i = 1:size(adjacent_matrix,1)
    for j = i:size(adjacent_matrix,2)
        mask = adjacent_matrix(i,:) | adjacent_matrix(j,:);
        mask(i) = 1;
        mask(j) = 1;
        neibors = find(mask==1);
        N = adjacent_matrix(neibors,neibors);
        alpha_local = alpha(N);
        pow = -alpha_local/alpha_global;
        for k = 1:length(neibors)
            S(i,j) = S(i,j)+power(neibors(k),pow);
        end
        S(j,i) = S(i,j);
    end
end

end

