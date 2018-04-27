
function [P,score] = predictEdge(O,predictNum)

global g_debug;
global g_score;
global g_similarity_only;
global g_combine_similar_node_and_pair;
global g_use_bayes;
global g_use_logistic_regression;
global g_combine_bayes_logistic

if g_debug
    tic;
    fprintf('Predicting %d edge...',predictNum);
end

V = size(O,1);



if g_use_bayes 
    score = bayes_score(O);
elseif g_use_logistic_regression
    score = logistic_regression_score(O);
elseif g_combine_bayes_logistic
    score = (bayes_score(O)+logistic_regression_score(O))/2;
else
    W = simi(O);
    if g_similarity_only
        score = W;
    else
        if g_combine_similar_node_and_pair
            BaseScore = W; % combine node and pair similarity
        else
            BaseScore = O; % use pair similarity only
        end
        Diag = diag(sum(W));
        score = BaseScore+rand(V)/100;
        err = 1; % initial error above threshold

        lambda = 1;

        VVBaseScore = V*V*BaseScore;
        lambda2 = 2*lambda;
        up = zeros(V,V,V);
        parfor i = 1:V
            up(:,:,i) = inv(V*V*eye(V) + lambda2*(sum(W(:,i))*Diag - W(i,i)*W));
        end

        while(err > 0.1)
            score1 = score;
            parfor i = 1:V
                score(:,i) = (...
                    up(:,:,i)...
                    )*(...
                    VVBaseScore(:,i) +...
                     lambda2*W*(score1*W(:,i)-score1(:,i)*W(i,i))...
                    );
            end
            err = dis(score,score1);
        end
    end


end


if g_debug
    g_score = score;
end

P = sparse(size(O,1),size(O,2)); %warning: cannot use sparse(size(O))
[~,SortedIdx] = sort(score(:),'descend');

count = 0;
for i = 1:size(O(:))
    [m,n] = i2xy(SortedIdx(i),V);
    if(O(m,n)==0 && P(m,n)==0 && m~=n)
        P(m,n) = 1;
        P(n,m) = 1;
        count = count + 1;
        if(count == predictNum)
            break;
        end
    end
end

if g_debug
    toc;
end

end

