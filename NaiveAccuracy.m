% Calulates the Average Mean Squared Error, MSE of an output dataset
% This function uses the first image of the set as reference and then
% runs the immse() function to compare each of the following images
%
% The final score can be used as an evaluation metric for the alignment

function [AVGERROR] = NaiveAccuracy(images)

fixed = images{1};
totalerr = 0;

for ii=2:length(images)
    totalerr = immse(fixed, images{ii});
end

AVGERROR = totalerr / (length(images)-1);

end
