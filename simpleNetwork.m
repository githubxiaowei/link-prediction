function simpleNetwork(N,k)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

global g_intrinsic_similarity;
S = g_intrinsic_similarity;

adjacent_matrix = zeros(N);
degree = sum(adjacent_matrix);

pro = 0.2;

for iter =1: N
    indices = find(degree<k);
    if isempty(indices)
        break;
    end
    fromNode = indices(randperm(length(indices),1));
    toNodeNum = k-degree(fromNode);

    [~,rank] = sort(S(fromNode,indices),'descend');
    
    for i = 1:toNodeNum
        
        if rand(1)<pro
            mask = adjacent_matrix(fromNode,:);
            mask(fromNode) = 1;  
            randpick = find(mask==0);
            toNode = randpick(randperm(length(randpick),1));
        else
            for j = 1:length(rank)
                toPick = indices(rank(j));
                if toPick ~= fromNode && ...
                        adjacent_matrix(fromNode,toPick) == 0 
                    toNode = toPick;
                    break;
                end
            end
            
        end
        
        adjacent_matrix(fromNode, toNode) = 1;
        adjacent_matrix(toNode,fromNode) = 1;
    end
    degree = sum(adjacent_matrix);

end

%{

x = 1:N;
plot(x,degree);

%}
save('adj_1','adjacent_matrix');

end