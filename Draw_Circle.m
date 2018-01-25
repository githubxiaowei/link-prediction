function Draw_Circle( note_of_information , color )
% 网络仿真图形
% 2006-12-20

% 输入：
%     note_of_information --- 节点的信息
%     x0,y0 --- 圆心坐标
%     R ---- 半径
% 输出：
%     作出网络仿真图形

if nargin < 2; color = 'b'; end;
R = 4 ;  % 半径R=4
x0 = 5 ; y0 = 5 ;% 圆心坐标(5,5)

[ M , N ] = size( note_of_information ) ;

t = 1 : N ;
t = t * 2 * pi / N ;

x = x0 + R * sin(t) ;
y = y0 + R * cos(t) ;
figure ; title('网络仿真图形') ;
for i = 1 : N
    plot( x(i) ,y(i) , 'r' ) ; axis( [ x0-R-1 x0+R+1 x0-R-1 x0+R+1 ] ) ; axis equal ;
    hold on;
end
for i = 1 : N
    for j = 1 : N
        if  note_of_information(i,j) == 1 
            line([x(i),x(j)],[y(i),y(j)],'LineWidth',0.1,'color',color);
            hold on ;
        end
    end
end
hold off;