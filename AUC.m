function [auc] = AUC(O,D,f)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

fprintf("Calculating GUC...");
tic;

node_num = size(f,1);
n1 = 0;
n2 = 0;
total = 0;

for i = 1:node_num
    for j = i+1:node_num
        if D(i,j) == 1
            for m = 1:node_num
                for n = m+1:node_num
                    if O(m,n) == 0 && D(m,n) == 0
                        if f(i,j)>f(m,n)
                            n1 = n1+1;
                        elseif f(i,j) == f(m,n)
                            n2 = n2+1;
                        end
                        total = total+1;
                    end
                end
            end
        end
    end
end
auc = (n1 + n2/2)/total;

toc;
end

