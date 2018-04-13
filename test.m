function test(tcase)

if nargin < 1
    tcase = 0;
end
global g_out;


switch tcase
    case 1
        O = [0,1,0,0;
             1,0,0,0;
             0,0,0,0;
             0,0,0,0]
        W = [1,0,1,0;
             0,1,0,1;
             1,0,1,0;
             0,1,0,1]
        num = 2;

        P = predictEdge(O,W,num);

        Draw_Circle(O)
        Draw_Circle(P,'r')
        
    case 2
        scale_free(200,5,4);
        ld = load('adj_1');
        G = sparse(ld.adjacent_matrix);
        simi(G);
        for per = 0.1:0.1:0.9
            [ G, D, done ] = deleteEdges( G, per);
            if done == 0
                return
            end
            distribution(G)
        end
    case 3
        n = 4039;
        m = sparse(n,n);
        f = fopen('../facebook_combined.txt');
        while(~feof(f))
            line = str2num(fgetl(f));
            m(line(1)+1,line(2)+1) = 1;
        end
        degree = sum(m);
        degree = sort(degree,'descend');
        x=1:n;
        beg =100;
        loglog(x(beg:end),degree(beg:end));
    case 4
        n = 262111;
        xy = zeros(1234877,2);
        f = fopen('../Amazon0302.txt');
        lineno = 0;
        while(~feof(f))
            lineno = lineno +1
            
            line = fgetl(f);
            if lineno < 5
                continue;
            end
            cord = str2num(line);
            xy(lineno-4,:) = cord;
        end
        xy = xy+1;
        m = sparse(xy(:,1),xy(:,2),1);
        degree = sum(m);
        degree = sort(degree,'descend');
        x=1:n;
        beg =100;
        loglog(x(beg:end),degree(beg:end)); 
        
end
end
