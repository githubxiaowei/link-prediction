function shoppingNetwork(customerNum,goodsNum,k)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

global g_intrinsic_similarity;
S = g_intrinsic_similarity(1:goodsNum,end-customerNum+1:end);

adjacent_matrix = zeros(goodsNum,customerNum);
degree = sum(adjacent_matrix);

pro = 0.2;

for iter =1: customerNum
    indices = find(degree<k);
    if isempty(indices)
        break;
    end
    fromNode = indices(randperm(length(indices),1));
    toNodeNum = k-degree(fromNode);

    [~,rank] = sort(S(:,fromNode),'descend');
    
    for i = 1:toNodeNum
        
        if rand(1)<pro
            notchoosed = find(adjacent_matrix(:,fromNode)==0);
            toNode = notchoosed(randperm(length(notchoosed),1));
        else
            for j = 1:goodsNum
                toPick = rank(j);
                if adjacent_matrix(toPick,fromNode) == 0 
                    toNode = toPick;
                    break;
                end
            end
            
        end

        adjacent_matrix(toNode,fromNode) = 1;
    end
    degree = sum(adjacent_matrix);

end

adjacent_matrix = ...
    [zeros(goodsNum) adjacent_matrix;...
    adjacent_matrix' zeros(customerNum)];


x = 1:customerNum+goodsNum;
degree = sum(adjacent_matrix);
plot(x,degree);
Draw_Circle(adjacent_matrix);
%}

save('shoppingNetwork','adjacent_matrix');

end

