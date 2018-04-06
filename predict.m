
close all;
clear;


%define global variables
global g_vertice_num;
global g_similarity_type;
global g_similarity_only;
global g_predict_rate;
global g_delete_percent;
global g_total_iteration;
global g_score;
global g_O;
global g_D;
global g_intrinsic_features;
global g_intrinsic_similarity;


%initiate global variables
g_vertice_num = 500;
g_similarity_only = false;
g_similarity_type = "";
g_predict_rate = 1;
g_delete_percent = 0.1;
g_total_iteration = 10;
g_score = [];
g_O = [];
g_D = [];
g_intrinsic_features = rand(g_vertice_num,10);
for i =1:g_vertice_num
    len = sqrt(sum(g_intrinsic_features(i,:).^2));
    g_intrinsic_features(i,:) = g_intrinsic_features(i,:)./len;
end
g_intrinsic_similarity = g_intrinsic_features*g_intrinsic_features';

% generate scarefree network and save it
%scale_free(100,4,4);
simpleNetwork(g_vertice_num,10);

%load adjacent_matrix from file
ld = load('adj_1');
G = sparse(ld.adjacent_matrix);

simi_type = {"CN","Salton","LHN","Jaccard","AA","RA",...
    "Karz","alpha","global"};
simi_type_num = length(simi_type);
acc_list = zeros(simi_type_num,2);
auc_list = zeros(simi_type_num,2);
delete_per = g_delete_percent;
total_iter = g_total_iteration;

for idx = simi_type_num
    g_similarity_type = string(simi_type(idx))
    g_similarity_only = true
    [acc_list(idx,1),auc_list(idx,1)] = ...
        predict_acc(G,delete_per,total_iter);
    g_similarity_only = false
    [acc_list(idx,2),auc_list(idx,2)] = ...
        predict_acc(G,delete_per,total_iter);
end














