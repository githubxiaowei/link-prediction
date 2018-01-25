function [ G, D, done ] = deleteEdges( G, p)
%  delete edges from a graph
%   
%   G: input graph 
%   p: percentage of edges to be delete

done = 0;
D = sparse(size(G,1),size(G,2));
totalnum = sum(G(:));
targetnum = floor(totalnum*p);
deletenum = 0;
pro = 0.3;

for loop = 1:5
    for i = 1 :size(G,1)
        for j = 1:size(G,2)
            if(G(i,j) == 1 && ...
                sum(G(i,:)) > 1 && sum(G(j,:)) > 1 && ...
                deletenum < targetnum &&...
                rand(1) < pro)
                G(i,j) = 0;
                deletenum = deletenum+1;
                D(i,j) = 1;
                if(deletenum == targetnum)
                    done = 1;
                    return;
                end
            end
        end
    end
end


end

