function [average_acc,average_auc] = predict(G,per,total_iter)
% 此处显示有关此函数的摘要
%   此处显示详细说明

global g_predict_rate;
global g_debug;

V = size(G,1);
E = length(find(G))/2;

if g_debug
    fprintf('num of vertices in G: %g\n',V);
    fprintf('num of edges in fully-connected G: %g\n',V*(V-1)/2);
    fprintf('num of edges in G: %g\n',E);
    fprintf('num of elements in matrix G: %g\n',E*2);
end

average_acc = 0;
average_auc = 0;

for iter = 1:total_iter
    if g_debug
        fprintf('%g%% of edges to be deleted.......\n',100*per);
    end
    
    [O,D,done] = deleteEdges(G,per);
    if(~done)
        fprintf('ERROR: can not delete %g%% edges\n',100*per );
        return;
    end
    
    dropNum = length(find(D))/2;
    remainNum = length(find(O))/2;
    
    if g_debug
        fprintf('num of deleted edges: %g\n',dropNum);
        fprintf('num of remained edges: %g\n',remainNum);
    end
    
    O1 = O;
    predict_rate = g_predict_rate;
    predicted_num = 0;

    while predicted_num < dropNum

        to_predict_num = ...
            max(1,min(floor(predict_rate*dropNum),dropNum-predicted_num));
        [P,f] = predictEdge(O,to_predict_num);
        O = O+P;
        predicted_num = predicted_num + to_predict_num;

    end

    P = O-O1;
    if g_debug
        fprintf('num of predicted edges: %g\n',assign(sum(P(:))/2));
    end
    accuracy = assign(D(:)'*P(:)/sum(P(:)));
    auc = fastAUC(O1,D,f);
    fprintf('accuracy: %10g\tauc: %10g\n',accuracy,auc);
    average_acc = average_acc + accuracy;
    average_auc = average_auc + auc;

end

average_acc = average_acc/total_iter;
average_auc = average_auc/total_iter;
fprintf('average_acc: %10g\taverage_auc %10g\n',...
    average_acc,average_auc);

%{
Draw_Circle(G);
Draw_Circle(O1);
Draw_Circle(D);
Draw_Circle(P);
%}
global g_O;
global g_D;
g_O = O1;
g_D = D;
end

