
clear;
tic;

I = 3 ;    %
N = 100 ;   % num of nodes in graph
m0 = 10 ;   % initial num of nodes
m = 6 ;    % num of nodes a new node will connect

realization_of_distribution = sparse( I , N ) ;  
for J = 1 : I   
    format long;

    adjacent_matrix = sparse( m0 , m0 ) ;  
    for i = 1 : m0
        for j = 1 : m0
            if j ~= i
                adjacent_matrix( i , j ) = 1 ;
            end
        end
    end
    adjacent_matrix = sparse( adjacent_matrix ) ;  


    node_degree = sparse( 1 , m0 ) ; 
    for p = 1 : m0
        node_degree( p ) = sum( adjacent_matrix( 1 : m0 , p ) ) ;
    end
    J
    for iteration = m0 + 1 : N
        total_degree = 2 * m * ( iteration - m0 -1 ) + m0*(m0-1) ; %�?次�?��? m*2
        degree_frequency = node_degree / total_degree ;  
        cum_distribution = cumsum( degree_frequency ) ;  

        choose = zeros( 1 , m ) ;  
        for new_edge = 1:m
            r = rand(1) ;   
            choose_edge = find( cum_distribution >= r ,1) ;
            while any(choose == choose_edge)
                r = rand(1) ;
                choose_edge = find(  cum_distribution >= r,1) ;
            end
            choose(new_edge) = choose_edge;
        end

        for k = 1 : m
            adjacent_matrix( iteration , choose(k) ) = 1 ;
            adjacent_matrix( choose(k) , iteration ) = 1 ;
        end

        for p = 1 : iteration
            node_degree(p) = sum( adjacent_matrix( 1 : iteration , p ) ) ;  
        end
    end  

    number_of_nodes_with_equal_degree = zeros( 1 , N ) ;   

    for i = 1 : N
        number_of_nodes_with_equal_degree(i) = length( find( node_degree == i ) ) ;  
    end
    realization_of_distribution( J , : ) = number_of_nodes_with_equal_degree ;

    save(['adj_',num2str(J)],'adjacent_matrix');
end  

aaa = cumsum( realization_of_distribution ) ;
bb1 = aaa( I , : ) ;  
bb2 = bb1( m : N ) ;
bbb = bb2 / ( I * N ) ;  
K = m : N ;
loglog( K , bbb , '*' )  
axis([1 N 0.0000001 0.9])
hold on;
y1 = 2 * m^2 * K .^ ( -3 ) ;
loglog( K , y1 , 'r' ) ;  %  p(k)=2*m^2*k^(-3)
  
toc;  

