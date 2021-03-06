function [ G, D, done ] = deleteEdges( G, p)
%  delete edges from a graph
%   
%   G: input graph 
%   p: percentage of edges to be delete

done = 0;
D = sparse(size(G,1),size(G,2));
totalnum = sum(G(:))/2;
targetnum = floor(totalnum*p);
deletenum = 0;
edge_num = length(find(G))/2;

degree = sum(G);
max_degree = max(degree);
%degree_percent = sum(G)/edge_num;

for loop = 1:targetnum
    for i = randperm(size(G,1))
        for j = randperm(size(G,2))
            if(G(i,j) == 1 && ...
                deletenum < targetnum && ...
                rand(1)<=p) 
                %sum(G(i,:)) > 1 && sum(G(j,:)) > 1 && ...
                %rand(1) < (degree(i)+degree(j))/(2*max_degree))
                
                %delete edge in G
                G(i,j) = 0;
                G(j,i) = 0;
                deletenum = deletenum+1;
                %add edge in D
                D(i,j) = 1;
                D(j,i) = 1;
                if(deletenum == targetnum)
                    done = 1;
                    return;
                end
                break;
            end
        end
    end
end


end

