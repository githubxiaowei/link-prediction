% figure
% subplot(2,2,1)
% scale_free(50,5,5)
% xlabel('节点度d')
% ylabel('概率质量函数p(d)')
% title('N=50')
% subplot(2,2,2)
% scale_free(100,5,5)
% xlabel('节点度d')
% ylabel('概率质量函数p(d)')
% title('N=100')
% subplot(2,2,3)
% scale_free(200,5,5)
% xlabel('节点度d')
% ylabel('概率质量函数p(d)')
% title('N=200')
% subplot(2,2,4)
% scale_free(400,5,5)
% xlabel('节点度d')
% ylabel('概率质量函数p(d)')
% title('N=400')

% figure;
% x = [-8:0.1:8];
% y = 1./(1+exp(-x));
% plot(x,y,'k');
% xlabel('z')
% ylabel('g(z)')

figure
subplot(2,2,1)
USAir();
axis([1 1000 0.001 1])
xlabel('节点度d')
ylabel('概率质量函数p(d)')
title('USAir')
subplot(2,2,2)
FWMW();
axis([1 1000 0.001 1])
xlabel('节点度d')
ylabel('概率质量函数p(d)')
title('FWMW')
subplot(2,2,3)
Celegans();
axis([1 1000 0.001 1])
xlabel('节点度d')
ylabel('概率质量函数p(d)')
title('C.elegans')
subplot(2,2,4)
Jazz();
axis([1 1000 0.001 1])
xlabel('节点度d')
ylabel('概率质量函数p(d)')
title('Jazz')

