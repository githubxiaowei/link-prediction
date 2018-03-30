function [average_acc] = predict_acc(G,per,total_iter)
% 此处显示有关此函数的摘要
%   此处显示详细说明

V = size(G,1);
E = length(find(G))/2;
fprintf('num of vertices in G: %g\n',V);
fprintf('num of edges in G: %g\n',E);
fprintf('num of elements in matrix G: %g\n',E*2);

average_acc = 0;
for iter = 1:total_iter
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

    O1 = O;
    predict_rate = 0.2;
    predicted_num = 0;

    while predicted_num < dropNum

    to_predict_num = min(floor(predict_rate*dropNum),dropNum-predicted_num);
    W = simi(O);
    P = predictEdge(O,W,to_predict_num);
    O = O+P;
    predicted_num = predicted_num + to_predict_num;

    end

    P = O-O1;
    fprintf('num of predicted edges: %g\n',assign(sum(P(:))/2));
    accuracy = assign(D(:)'*P(:)/sum(P(:)));
    fprintf('accuracy: %g\n',accuracy);
    average_acc = average_acc + accuracy;

end

average_acc = average_acc/total_iter;
fprintf('average accuracy: %g\n',average_acc);


Draw_Circle(G);
Draw_Circle(O);
Draw_Circle(D);
Draw_Circle(P);
end

