
close all;
clear;
tic;

scale_free(100,4,4);

ld = load('adj_1');
G = sparse(ld.adjacent_matrix);

delete_per = 0.1;
total_iter = 5;
predict_acc(G,delete_per,total_iter)

toc;













