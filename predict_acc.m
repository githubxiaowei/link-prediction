function [average_acc,average_auc] = predict_acc(G,per,total_iter)
% �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

global g_predict_rate;

V = size(G,1);
E = length(find(G))/2;
fprintf('num of vertices in G: %g\n',V);
fprintf('num of edges in G: %g\n',E);
fprintf('num of elements in matrix G: %g\n',E*2);

average_acc = 0;
average_auc = 0;
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
    predict_rate = g_predict_rate;
    predicted_num = 0;

    while predicted_num < dropNum

    to_predict_num = ...
        max(1,min(floor(predict_rate*dropNum),dropNum-predicted_num));
    [P,f] = predictEdge(O,to_predict_num,'similarity_only');
    O = O+P;
    predicted_num = predicted_num + to_predict_num;

    end

    P = O-O1;
    fprintf('num of predicted edges: %g\n',assign(sum(P(:))/2));
    accuracy = assign(D(:)'*P(:)/sum(P(:)));
    auc = AUC(O1,D,f);
    fprintf('accuracy: %g\tauc: %g\n',accuracy,auc);
    average_acc = average_acc + accuracy;
    average_auc = average_auc + auc;

end

average_acc = average_acc/total_iter;
average_auc = average_auc/total_iter;
fprintf('average_acc: %g\taverage_auc %g\n',...
    average_acc,average_auc);

%{
Draw_Circle(G);
Draw_Circle(O1);
Draw_Circle(D);
Draw_Circle(P);
%}
end

