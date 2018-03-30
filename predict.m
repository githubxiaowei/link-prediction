
close all;
clear;
tic;

scale_free(10,4,4);

ld = load('adj_1');
G = sparse(ld.adjacent_matrix);
%G = sparse(ScalefreeGen(20));
simi(G);

delete_per = 0.3;
total_iter = 10;
average_acc = predict_acc(G,delete_per,total_iter)


global f01;
global f02;
toc;













