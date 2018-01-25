function save_adj(m,filename)
file = fopen(filename,'w');
    for i = 1:size(m,1)
        for j = 1:size(m,2)
            if (m(i,j) == 1)
                fprintf(file,'1 ');
            else
                fprintf(file,'0 ');
            end
        end
        fprintf(file,'\n');
    end
fclose(file);
end

