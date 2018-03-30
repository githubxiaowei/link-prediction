function test(tcase)

if nargin < 1
    tcase = 0;
end
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
        
    otherwise
        scale_free(100,5,4);
        ld = load('adj_1');
        G = sparse(ld.adjacent_matrix);
        simi(G);
        for per = 0.1:0.1:0.9
            [ G, D, done ] = deleteEdges( G, per);
            [per,done]
            simi(G);
        end

end
