function [disn, a] = distribution(adjacent_matrix)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

node_num = size(adjacent_matrix,1);
node_degree = sum( adjacent_matrix);
disn = zeros( 1 , node_num ) ;   
for i = 1 : node_num
    disn(i) = length( find( node_degree == i ) ) ;  
end

disn = disn/node_num;
x = 1:node_num;
%loglog( x , disn , '*' )  
%axis([1 node_num 0.0000001 0.9]);
%hold on;

begx = find(disn~=0,1);
endx = node_num+1-find(disn(end:-1:1) ~= 0, 1);
zzz = 0.001;
disn = disn + zzz;

[a,~] = polyfit(log(x(begx:endx)),log(disn(begx:endx)),1);

%y = exp(a(2))* x.^(a(1)) ;
%loglog(x,y,'r');


end

