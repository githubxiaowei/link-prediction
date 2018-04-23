function [score] = logistic_regression_score(O)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
V = size(O,1);
degree = sum(O);
max_degree = max(degree);

num_of_edge_total = V*(V-1)/2;
num_of_edge_observed = sum(degree)/2;
prob_observed = num_of_edge_observed/num_of_edge_total;
rate = prob_observed/(1-prob_observed);


features = degree_feature(O);
features = features(:,1:max_degree);

global g_tmp;
g_tmp = features;

weights = rand(2,1);
aver_weights = zeros(size(weights));

alpha = 0.1;
for iteration = 1:10
    weights = aver_weights;
    for i = randperm(V)
        for j = i+1:V
            if O(i,j) == 0 && rand(1)>rate
                continue
            end
        x = [min(degree(j),degree(i))/max_degree max(degree(j),degree(i))/max_degree];
        h = 1/(1+exp(-x*weights));
        weights = weights + alpha*(O(i,j)-h)*x';
        end
    end
    aver_weights = (aver_weights*(iteration-1)+weights)/(iteration);
end

score = zeros(V);
for i = 1:V
    for j = i+1:V
        x = [min(degree(j),degree(i))/max_degree max(degree(j),degree(i))/max_degree];
        score(i,j) = 1/(1+exp(-x*aver_weights));
        score(j,i) = score(i,j);
    end
end
g_tmp = aver_weights;

end

