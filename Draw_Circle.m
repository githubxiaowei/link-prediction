function Draw_Circle( note_of_information , color )
% �������ͼ��
% 2006-12-20

% ���룺
%     note_of_information --- �ڵ����Ϣ
%     x0,y0 --- Բ������
%     R ---- �뾶
% �����
%     �����������ͼ��

if nargin < 2; color = 'b'; end;
R = 4 ;  % �뾶R=4
x0 = 5 ; y0 = 5 ;% Բ������(5,5)

[ M , N ] = size( note_of_information ) ;

t = 1 : N ;
t = t * 2 * pi / N ;

x = x0 + R * sin(t) ;
y = y0 + R * cos(t) ;
figure ; title('�������ͼ��') ;
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