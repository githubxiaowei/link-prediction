
function [P,score] = predictEdge(O,dropNum,~)

W = simi(O);
V = size(O,1);
global g_similarity_only;

if g_similarity_only
    score = W;
else
    Diag = sum(W);
    score = assign(O)+rand(size(O))/100;
    score1 = zeros(size(O))+rand(size(O))/100;
    err = dis(score,score1);

    lambda = 1;

    while(err > 0.0001)

        for i = 1:V
            score1(:,i) = (...
                V*V*eye(V) + ...
                2*lambda*sum(W(:,i))*diag(Diag) -...
                2*lambda*W(i,i)*W...
                )\(...
                V*V*O(:,i) +...
                 2*lambda*W*(score*W(:,i)-score(:,i)*W(i,i))...
                );
            %f2(i,:) = f2(:,i)';
        end
        for i = 1:V
            score(:,i) = (...
                V*V*eye(V) + ...
                2*lambda*sum(W(:,i))*diag(Diag) -...
                2*lambda*W(i,i)*W...
                )\(...
                V*V*O(:,i) +...
                 2*lambda*W*(score1*W(:,i)-score1(:,i)*W(i,i))...
                );
            %f1(i,:) = f1(:,i)';
        end
        err = dis(score,score1);
    end
end

global g_score;
g_score = score;


P = sparse(size(O,1),size(O,2));
[~,SortedIdx] = sort(score(:),'descend');

count = 0;
for i = 1:size(O(:))
    [m,n] = i2xy(SortedIdx(i),V);
    if(O(m,n)==0 && P(m,n)==0 && m~=n)
        P(m,n) = 1;
        P(n,m) = 1;
        count = count + 1;
        if(count == dropNum)
            break;
        end
    end
end

end

