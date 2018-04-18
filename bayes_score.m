function [score] = bayes_score(O)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
V = size(O,1);
degree = sum(O);

mat = deg_deg_conditional_pro(O,1);
mat2 = deg_deg_conditional_pro(O,0);

for i = 1:size(mat,1)
    for j = i:size(mat,2)  
        mat(i,j) = mat(i,j)/(mat(i,j)+mat2(i,j));
        mat(j,i) = mat(i,j);
    end
end

global g_mat;
g_mat = mat;
myfilter = [2, 1,1;
            1,20,1;
            1, 1,2];
myfilter = myfilter/sum(myfilter(:));
mat = imfilter(mat,myfilter,'symmetric','same');

score = zeros(V);
for i = 1:V
    for j = i+1:V
        if (degree(i) < degree(j))
            score(i,j) = mat(degree(i),degree(j));
        else
            score(i,j) = mat(degree(j),degree(i));
        end   
        score(j,i) = score(i,j);
    end
end

end

function [pro] = deg_deg_conditional_pro(O,mask)
degree = assign(sum(O));
V = size(O,1);

num_of_edge_total = V*(V-1)/2;
num_of_edge_observed = sum(degree)/2;
num_of_edge_unobserved = num_of_edge_total-num_of_edge_observed;

max_deg = max(degree);
count = zeros(max_deg);

pro_exist_edge = num_of_edge_observed/num_of_edge_total;
pro_unexist_edge = 1-pro_exist_edge;

for i = 1:V
    for j = i+1:V
        if(O(i,j) == mask)
            % make sure count is UpRight matrix
            if (degree(i) < degree(j))
                count(degree(i),degree(j)) = count(degree(i),degree(j))+1;
            else
                count(degree(j),degree(i)) = count(degree(j),degree(i))+1;
            end
        end
    end
end

if mask
    pro = (count+1)*pro_exist_edge/(num_of_edge_observed+2); % smoothing 
else
    pro = (count+1)*pro_unexist_edge/(num_of_edge_unobserved+2);
end

end
