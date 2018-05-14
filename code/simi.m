function [ S ] =simi(adjacent_matrix)
% calculate similarity matrix

global g_similarity_type;
global g_intrinsic_similarity;
type = g_similarity_type;
    
S = zeros(size(adjacent_matrix));

    switch type
        
        case 'CN'
            S = adjacent_matrix^2;
            
        case 'LHN'
            degree = sum(adjacent_matrix);
            for i = 1:size(adjacent_matrix,1)
                for j = i:size(adjacent_matrix,2)
                    S(i,j) = adjacent_matrix(i,:)*adjacent_matrix(j,:)'...
                        /(degree(i)*degree(j));
                    S(j,i) = S(i,j);
                end
            end          
        
        case 'Jaccard'
            for i = 1:size(adjacent_matrix,1)
                for j = i:size(adjacent_matrix,2)
                    S(i,j) = sum(adjacent_matrix(i,:) & adjacent_matrix(j,:))...
                        /sum(adjacent_matrix(i,:) | adjacent_matrix(j,:));
                    S(j,i) = S(i,j);
                end
            end

        case 'Salton'
            degree = sum(adjacent_matrix);
            for i = 1:size(adjacent_matrix,1)
                for j = i:size(adjacent_matrix,2)
                    S(i,j) = adjacent_matrix(i,:)*adjacent_matrix(j,:)'...
                        /sqrt(degree(i)*degree(j));
                    S(j,i) = S(i,j);
                end
            end
            
        case 'AA'
            degree = sum(adjacent_matrix);
            for i = 1:size(adjacent_matrix,1)
                for j = i:size(adjacent_matrix,2)
                    mask = adjacent_matrix(i,:) & adjacent_matrix(j,:);
                    S(i,j) = sum(1./degree(logical(mask)));
                end
            end
            
        case 'RA'
            degree = sum(adjacent_matrix);
            for i = 1:size(adjacent_matrix,1)
                for j = i:size(adjacent_matrix,2)
                    mask = adjacent_matrix(i,:) & adjacent_matrix(j,:);
                    S(i,j) = sum(1./log(degree(logical(mask))+0.1));
                end
            end
  
        case 'Karz'
            belta = 0.9/max(eig(adjacent_matrix));
            S = inv(eye(size(adjacent_matrix))-belta*adjacent_matrix)...
                -eye(size(adjacent_matrix));

        case 'alpha'
            degree = sum(adjacent_matrix);
            alpha_global = alpha(adjacent_matrix);

            for i = 1:size(adjacent_matrix,1)
                for j = i+1:size(adjacent_matrix,2)
                    mask = adjacent_matrix(i,:) | adjacent_matrix(j,:);
                    mask(i) = 1;
                    mask(j) = 1;
                    neibors = find(mask==1);
                    N = adjacent_matrix(neibors,neibors);
                    alpha_local = alpha(N);
                    pow = -alpha_local/alpha_global;
                    for k = 1:length(neibors)
                        S(i,j) = S(i,j)+power(degree(neibors(k)),pow);
                    end
                    S(j,i) = S(i,j);
                    
                end
            end
            
            case 'alpha2'
            degree = sum(adjacent_matrix);
            alpha_global = alpha(adjacent_matrix);
            for i = 1:size(adjacent_matrix,1)
                for j = i+1:size(adjacent_matrix,2)
                    mask = adjacent_matrix(i,:) | adjacent_matrix(j,:);
                    mask(i) = 1;
                    mask(j) = 1;
                    neibors = find(mask==1);
                    N = adjacent_matrix(neibors,neibors);
                    S(i,j) =  alpha(N);
                    S(j,i) = S(i,j);
                end
            end     
            
        case 'global'
            S = g_intrinsic_similarity;
            
        case 'degree_feature'
            features = degree_feature(adjacent_matrix);
            S = features*features';
         
        case 'PA'
            degree = sum(adjacent_matrix);
            max_degree = max(degree);
            max_degree2 = max_degree*max_degree;
            for i = 1:size(adjacent_matrix,1)
                for j = i+1:size(adjacent_matrix,2)
                    S(i,j) = degree(i)*degree(j)/max_degree2;
                    S(j,i) = S(i,j);
                end
            end
         
        case 'max_degree'
            degree = sum(adjacent_matrix);
            max_degree = max(degree);
            for i = 1:size(adjacent_matrix,1)
                for j = i+1:size(adjacent_matrix,2)
                    S(i,j) = max(degree(i),degree(j))/max_degree;
                    S(j,i) = S(i,j);
                end
            end
            
        otherwise
            fprintf('ERROR: unknown similarity type.\n');
    end
end

