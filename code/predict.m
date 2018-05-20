function [average_acc,average_auc] = predict()
% 此处显示有关此函数的摘要
%   此处显示详细说明

global g_predict_rate;
global g_debug;
global g_G;
global g_kFold;
global g_folds;

G = g_G;
V = size(G,1);
E = length(find(G))/2;



average_acc = 0;
average_auc = 0;

for iter = 1:g_kFold
    
    D = g_folds(:,:,iter);
    O = double(G&~D);
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

average_acc = average_acc/g_kFold;
average_auc = average_auc/g_kFold;
fprintf('average_acc: %10g\taverage_auc %10g\n',...
    average_acc,average_auc);


end

