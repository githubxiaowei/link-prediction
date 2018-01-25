function [ O ] = assign( I )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

O = zeros(size(I));
for i = 1:size(I,1)
    for j = 1: size(I,2)
        O(i,j) = I(i,j);
    end
end

end

