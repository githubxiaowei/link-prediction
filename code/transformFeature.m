function [features] = transformFeature(features, bar_num)
    original_length = size(features,2);
    if(size(features,2)<bar_num)
        return 
    end
    bar_width = round(original_length/bar_num);
    for i = 1:size(features,1)
        for j = 1:bar_num
            features(i,j) = sum(features(i,bar_width*(j-1)+1:min(bar_width*j,original_length)));
        end
    end
    features = features(:,1:bar_num);

end

