function [auc] = fastAUC(O,D,f)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
global g_debug

if g_debug
    fprintf("Calculating AUC...");
    tic;
end

upTriangle = triu(ones(size(O)),1);;
O = O & upTriangle;
D = D & upTriangle;
U = ~(O|D) & upTriangle;
unwanted = f(U);
wanted = f(logical(D));

part1 = ones(size(wanted,1),2);  % 1 represent wanted
part1(:,1) = wanted(:);
part2 = ones(size(unwanted,1),2)*2; % 2 represent unwanted
part2(:,1) = unwanted(:);

whole = [part1;part2];

whole = sortrows(whole,1,'ascend');

n1 = 0;
n2 = 0;
total = length(wanted)*length(unwanted);

count_wanted = 0;
successive_wanted = 0;
max_wanted = 0;
successive_unwanted = 0;
max_unwanted = 0;

% init
if whole(1,2) == 1
    count_wanted = 1;
    max_wanted = whole(1,1);
    successive_wanted = 1;
else
    max_unwanted = whole(1,1);
    successive_unwanted = 1;
end

% scan
for i = 2:length(whole)
    %update count
    %update successive num
    if(whole(i,2) == 1) % if current is wanted
        count_wanted = count_wanted+1;
        if whole(i,1) == max_wanted
            successive_wanted = successive_wanted+1;
        else
            successive_wanted = 1;
            max_wanted = whole(i,1);
        end
    else % if current is unwanted
        if whole(i,1) == max_unwanted
            successive_unwanted = successive_unwanted+1;
        else
            successive_unwanted = 1;
            max_unwanted = whole(i,1);
        end       
    end
   
    %calculate
    if(whole(i,2) == 1) % if current is wanted
        if whole(i,1) == max_unwanted % if equal
            n2 = n2 + successive_unwanted;
        end
        n1 = n1 + i - count_wanted;    
        
    else % if current is unwanted
        if whole(i,1) == max_wanted
            n2 = n2 + successive_wanted;
        end        
    end 
    
 
end

auc = (n1 + n2/2)/total;

if g_debug
    toc;
end

end

