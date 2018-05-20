function [G] = Celegans()
USAirData = textread('E:\Download\celegansneural\celegansneural.txt');
N = 297;
G = zeros(N);
for row =1:size(USAirData,1)
    G(USAirData(row,1)+1,USAirData(row,2)+1)=1;
    G(USAirData(row,2)+1,USAirData(row,1)+1)=1;
end
degree = sum(G);
number_of_nodes_with_equal_degree = zeros( 1 , N ) ;   

for i = 1 : N
    number_of_nodes_with_equal_degree(i) = length( find( degree == i ) ) ;  
end
average = number_of_nodes_with_equal_degree/N ;
loglog( 1:N , average , '.k' ) 
end