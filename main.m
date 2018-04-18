
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
global g_O;
global g_D;
global g_intrinsic_features;
global g_intrinsic_similarity;
global g_use_bayes;
global g_use_logistic_regression;
global g_combine_bayes_logistic;

%initiate global variables
g_debug = false;
g_vertice_num = 1000;
g_similarity_only = true;
g_combine_similar_node_and_pair = false;
g_similarity_type = "";
g_predict_rate = 0.3;
g_delete_percent = 0.1;
g_total_iteration = 10;
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

% generate scarefree network and save it
scale_free(g_vertice_num,7,5);
ld = load('adj_1');

% simpleNetwork(g_vertice_num,10);
% ld = load('simpleNetwork');

%customerNum = floor(g_vertice_num*0.7);
%shoppingNetwork(customerNum,g_vertice_num-customerNum,4);
%ld = load('shoppingNetwork');

%load adjacent_matrix from file
G = sparse(ld.adjacent_matrix);

simi_type = {"CN","Salton","LHN","Jaccard","AA","RA",...
    "Karz","alpha","global","degree_feature"};
simi_type_num = length(simi_type);

acc_list = zeros(simi_type_num+2,3);
auc_list = zeros(simi_type_num+2,3);

delete_per = g_delete_percent;
total_iter = g_total_iteration;

% for idx = 1:simi_type_num   
%     g_similarity_type = string(simi_type(idx))
%     
%     
%     % use node similarity to predict new edge
%     g_similarity_only=true;
%     [acc_list(idx,1),auc_list(idx,1)] = ...
%         predict(G,delete_per,total_iter);
%     
% 
%     g_similarity_only = false;
%         % use node-pair similarity to predict new edge   
%         g_combine_similar_node_and_pair = false;
%         [acc_list(idx,2),auc_list(idx,2)] = ...
%             predict(G,delete_per,total_iter);
% 
%         % use both node and node-pair similarity to predict new edge
% 
%         g_combine_similar_node_and_pair = true;
%         [acc_list(idx,3),auc_list(idx,3)] = ...
%             predict(G,delete_per,total_iter);
% 
% end
g_use_bayes = true
[acc_list(simi_type_num+1,1),auc_list(simi_type_num+1,1)] =...
    predict(G,delete_per,total_iter);

% g_use_bayes = false;
% g_use_logistic_regression = true
% [acc_list(simi_type_num+2,1),auc_list(simi_type_num+2,1)] =...
%     predict(G,delete_per,total_iter);
% 
% g_use_bayes = false;
% g_use_logistic_regression = false;
% g_combine_bayes_logistic = true
% [acc_list(simi_type_num+3,1),auc_list(simi_type_num+3,1)] =...
%     predict(G,delete_per,total_iter);
% 








