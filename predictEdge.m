
function [P] = predictEdge(O,W,dropNum)

Diag = sum(W);
V = size(O,1);
f1 = assign(O)+rand(size(O))/100;
f2 = zeros(size(O))+rand(size(O))/100;
err = dis(f1,f2);

lambda = 1;

while(err > 0.0001)

    for i = 1:V
        f2(:,i) = (...
            V*V*eye(V) + ...
            2*lambda*sum(W(:,i))*diag(Diag) -...
            2*lambda*W(i,i)*W...
            )\(...
            V*V*O(:,i) +...
             2*lambda*W*(f1*W(:,i)-f1(:,i)*W(i,i))...
            );
        %f2(i,:) = f2(:,i)';
    end
    for i = 1:V
        f1(:,i) = (...
            V*V*eye(V) + ...
            2*lambda*sum(W(:,i))*diag(Diag) -...
            2*lambda*W(i,i)*W...
            )\(...
            V*V*O(:,i) +...
             2*lambda*W*(f2*W(:,i)-f2(:,i)*W(i,i))...
            );
        %f1(i,:) = f1(:,i)';
    end
    err = dis(f1,f2);
end

global f01;
global f02;
f01 = f1;
f02 = f2;

err

P = sparse(size(O,1),size(O,2));
[~,SortedIdx] = sort(f1(:),'descend');

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

