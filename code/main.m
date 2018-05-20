
close all;
clear;


%define global variables
global g_debug;
global g_vertice_num;
global g_similarity_type;
global g_similarity_only;
global g_combine_similar_node_and_pair;
global g_predict_rate;
global g_delete_percent;
global g_total_iteration;
global g_score;
global g_G;
global g_O;
global g_D;
global g_intrinsic_features;
global g_intrinsic_similarity;
global g_use_bayes;
global g_use_logistic_regression;
global g_combine_bayes_logistic;
global g_folds;
global g_kFold;

%initiate global variables
g_debug = false;
g_vertice_num = 400;
g_similarity_only = true;
g_combine_similar_node_and_pair = false;
g_similarity_type = '';
g_predict_rate = 1;
g_score = [];
g_O = [];
g_D = [];
g_use_bayes = false;
g_use_logistic_regression = false;
g_combine_bayes_logistic = false;

g_intrinsic_features = rand(g_vertice_num,10);
for i =1:g_vertice_num
    len = sqrt(sum(g_intrinsic_features(i,:).^2));
    g_intrinsic_features(i,:) = g_intrinsic_features(i,:)./len;
end
g_intrinsic_similarity = g_intrinsic_features*g_intrinsic_features';

% % generate scarefree network and save it
% scale_free(g_vertice_num,5,5);
% ld = load('adj_1');
% 
% % simpleNetwork(g_vertice_num,10);
% % ld = load('simpleNetwork');
% 
% %customerNum = floor(g_vertice_num*0.7);
% %shoppingNetwork(customerNum,g_vertice_num-customerNum,4);
% %ld = load('shoppingNetwork');
% 
% %load adjacent_matrix from file
% G = sparse(ld.adjacent_matrix);
G = sparse(Jazz());
g_G = G;
g_kFold = 10;
g_folds = zeros(size(G,1),size(G,2),g_kFold);
O=G;
for i = 1:g_kFold
    [O,g_folds(:,:,i),done] = deleteEdges(O,1/(g_kFold-i+1));
     if(~done)
        fprintf('ERROR: can not delete edges\n');
        return;
     end
     %Draw_Circle(g_folds(:,:,i))
end



simi_type = {'CN','Salton','Jaccard','Sorensen','HPI','LHN','PA','AA','RA',...
    'LS'};
simi_type_num = length(simi_type);

acc_list = zeros(simi_type_num+2,3);
auc_list = zeros(simi_type_num+2,3);


for idx = 1:simi_type_num
    g_similarity_type = string(simi_type(idx))
       
    % use node similarity to predict new edge
    g_similarity_only=true;
    [acc_list(idx,1),auc_list(idx,1)] = ...
        predict();
    
%     g_similarity_only = false;
%         % use node-pair similarity to predict new edge   
%         g_combine_similar_node_and_pair = false;
%         [acc_list(idx,2),auc_list(idx,2)] = ...
%             predict();


end
g_use_bayes = true
[acc_list(simi_type_num+1,1),auc_list(simi_type_num+1,1)] =...
    predict();

g_use_bayes = false;
g_use_logistic_regression = true
[acc_list(simi_type_num+2,1),auc_list(simi_type_num+2,1)] =...
    predict();



 save('acc_list','acc_list');
 save('auc_list','auc_list');









