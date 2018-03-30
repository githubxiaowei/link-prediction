
close all;
clear;
tic;

scale_free(100,4,3);

ld = load('adj_1');
G = sparse(ld.adjacent_matrix);
simi(G);

delete_per = 0.1;
total_iter = 5;
average_acc = predict_acc(G,delete_per,total_iter)

toc;













