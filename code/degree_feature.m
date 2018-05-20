function [features] = degree_feature(O)

V = size(O,1);
degree = sum(O);

features = zeros(V);
for i = 1:V
    for j = 1:V
        if(O(i,j) == 1)
            features(i,j) = degree(j);
        end
    end
    features(i,i) = degree(i);
end

for i = 1:V
    tmp = zeros(1,V);
    for j = 1:V
       if features(i,j) > 0
           tmp(features(i,j)) = tmp(features(i,j))+1;
       end
    end
    tmp = tmp/sum(tmp);
    features(i,:) = tmp;
end

for i =1:V
    len = sqrt(sum(features(i,:).^2));
    features(i,:) = features(i,:)./len;
end


end