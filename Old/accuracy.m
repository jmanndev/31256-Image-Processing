% Calulates the Average Mean Squared Error, MSE of an output dataset
% This function uses the first image of the set as reference and then
% runs the immse() function to compare each of the following images
%
% The final score can be used as an evaluation metric for the alignment

function [metrics, avg, total] = accuracy(images)

fixed = images{1};
total = 0;
metrics = {length(images)};

for i=1:length(images)
    metrics{i} = immse(fixed, images{i});
    total = total + metrics{i};
end

avg = total / (length(images)-1);

end

