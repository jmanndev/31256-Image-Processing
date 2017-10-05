% Calulates the Average Mean Squared Error, MSE of an output dataset
% This function uses the first image of the set as reference and then
% runs the immse() function to compare each of the following images
%
% The final score can be used as an evaluation metric for the alignment

function [AVGERROR] = evaluateTotalAccuracy(images, metric)

fixed = removeBackground(images{1});
totalerr = 0;

for ii=2:length(images)
    totalerr = totalerr + getError(fixed, removeBackground(images{ii}), metric);
end

AVGERROR = totalerr / (length(images)-1);

end

function [ERROR] = getError(fixed, moving, metric) 

if (strcmp(metric, 'mse'))
    ERROR = immse(fixed, moving);
elseif(strcmp(metric, 'rmse'))
    ERROR = RMSE(fixed, moving);
elseif(strcmp(metric, 'mae'))
    ERROR = meanAbsoluteError(fixed, moving);
elseif(strcmp(metric, 'snr'))
    ERROR = SNR(fixed, moving);
elseif(strcmp(metric, 'qi'))
    ERROR = imageQualityIndex(fixed, moving);
end

end
