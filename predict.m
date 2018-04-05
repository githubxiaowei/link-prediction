
close all;
clear;
tic;

%define global variables
global g_similarity_type;
global g_similarity_only;
global g_predict_rate;
global g_delete_percent;
global g_total_iteration;
global g_score;

%initiate global variables
g_similarity_only = false;
g_similarity_type = "";
g_predict_rate = 0.5;
g_delete_percent = 0.1;
g_total_iteration = 10;
g_score = [];

% generate scarefree network and save it
scale_free(100,4,4);

%load adjacent_matrix from file
ld = load('adj_1');
G = sparse(ld.adjacent_matrix);

simi_type = {"CN","Salton","LHN","Jaccard","AA","RA","Karz","test"};
simi_type_num = 8;
acc_list = zeros(simi_type_num,2);
auc_list = zeros(simi_type_num,2);
delete_per = g_delete_percent;
total_iter = g_total_iteration;

for idx = 1:simi_type_num
    g_similarity_type = string(simi_type(idx))
    g_similarity_only = true
    [acc_list(idx,1),auc_list(idx,1)] = predict_acc(G,delete_per,total_iter);
    g_similarity_only = false
    [acc_list(idx,2),auc_list(idx,2)] = predict_acc(G,delete_per,total_iter);
end

toc;













