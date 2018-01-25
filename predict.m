%lambda = 100;

close all;
clear;
tic;

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
dropNum = length(find(D))/2;
remainNum = length(find(O))/2;
fprintf('%g%% of edges to be deleted.......\n',100*per);
fprintf('num of deleted edges: %g\n',dropNum);
fprintf('num of remained edges: %g\n',remainNum);

W = sim(O);
W = W.^2;
Diag = sum(W);

f1 = assign(O);
f2 = zeros(size(G));
err = dis(f1,f2);

lambda = 0.5;

while(err > 0.001)

    for i = 1:V
        f2(:,i) = (...
            V*V*diag(O(:,i)) + ...
            2*lambda*sum(W(:,i))*diag(Diag) -...
            2*lambda*W(i,i)*W...
            )\(...
            V*V*diag(O(:,i))*O(:,i) +...
             2*lambda*(sum(W(:,i))-W(i,i))*W*f1(:,i)...
            );
    end
    for i = 1:V
        f1(:,i) = (...
            V*V*diag(O(:,i)) + ...
            2*lambda*sum(W(:,i))*diag(Diag) -...
            2*lambda*W(i,i)*W...
            )\(...
            V*V*diag(O(:,i))*O(:,i) +...
             2*lambda*(sum(W(:,i))-W(i,i))*W*f2(:,i)...
            );
    end
    err = dis(f1,f2);
end

P = sparse(size(G,1),size(G,2));
[~,SortedIdx] = sort(f1(:),'descend');

count = 0;
for i = 1:size(G(:))
    [m,n] = i2xy(SortedIdx(i),V);
    if(O(m,n)==0 && P(m,n)==0)
        P(m,n) = 1;
        P(n,m) = 1;
        count = count + 1;
        if(count == dropNum)
            break;
        end
    end
end

fprintf('num of predicted edges: %g\n',assign(sum(P(:))/2));
fprintf('accuracy: %g\n',assign(D(:)'*P(:)/sum(P(:))));

Draw_Circle(G);
Draw_Circle(O);
Draw_Circle(D);
Draw_Circle(P);


toc;













