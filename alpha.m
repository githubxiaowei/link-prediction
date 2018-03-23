function [alpha] = alpha(adjacent_matrix)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

node_num = size(adjacent_matrix,1);
node_degree = sum( adjacent_matrix);
deg_min = assign(min(node_degree));

alpha = 0;
for i = 1:node_num
    alpha = alpha+log(node_degree(i)/(deg_min-0.5));
end
alpha = 1+node_num/alpha;
end

