clear;
ld = load('adj_1');
G = sparse(ld.adjacent_matrix);
V = size(G,1);
E = length(find(G))/2;
fprintf('num of vertices in G: %g\n',V);
fprintf('num of edges in G: %g\n',E);
fprintf('num of elements in matrix G: %g\n',E*2);

per = 0.2;
[O,D,done] = deleteEdges(G,per);
if(~done)
    fprintf('ERROR: can not delete %g%% edges\n',100*per );
    return;
end
fprintf('%g%% of edges to be deleted.......\n',100*per);
fprintf('num of deleted edges: %g\n',length(find(D)));
fprintf('num of remained edges: %g\n',length(find(O)));

W = salton(O);
lambda = 0.5;
D = sum(W);

f1 = assign(O);
f2 = zeros(size(G));
err = dis(f1,f2);

while(err > 0.1)

    for i = 1:V
        f2(:,i) = (...
            V*V*diag(O(:,i)) + ...
            2*lambda*sum(W(:,i))*diag(D) -...
            2*lambda*W(i,i)*W...
            )\(...
            V*V*diag(O(:,i))*O(:,i) +...
             2*lambda*(sum(W(:,i))-W(i,i))*W*f1(:,i)...
            );
    end
    for i = 1:V
          f1(:,i) = (...
            V*V*diag(O(:,i)) + ...
            2*lambda*sum(W(:,i))*diag(D) -...
            2*lambda*W(i,i)*W...
            )\(...
            V*V*diag(O(:,i))*O(:,i) +...
             2*lambda*(sum(W(:,i))-W(i,i))*W*f2(:,i)...
            );
    end
    err = dis(f1,f2)
end
















