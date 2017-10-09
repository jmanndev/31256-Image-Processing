% Function that selects the best threshold level for the image set given.
% The best threshold is said to be the one that minimises bad blobs
% detections.
function thresholdLevel = getThreshold(images) 

% Looking at histograms of the images we see that few pixels have values
% less than 100. We try to place the threshold in such a way that maximises
% the wanted size blobs of the image. 
thresholdLevels = 90:120;
badDetectionsPerLevel = {30};

for level = 1:length(thresholdLevels)
    badDetects = 0; % Bad detections find less than or more than 3 blobs
    for i = 1:length(images)
        pts = getMaskingPoints(images{i}, thresholdLevels(level));
        if (pts ~= 3)
            badDetects = badDetects + 1;
        end
    end
    badDetectionsPerLevel{level} = badDetects;
end
% Get the threshold with the least amount of bad detections
[minEl, minInd] = min(cell2mat(badDetectionsPerLevel));
thresholdLevel = thresholdLevels(minInd(1));

end

% Function that calculates the number of key points for image using
% threshold as the value to clear or set a pixel when converting to a
% binary image.
function noKeypoints = getMaskingPoints(image, threshold)

    % Convert into binary image
    image = makeGray(image);
    thresholdValue = threshold;
    binaryImage = image < thresholdValue;
    
    % Calculate the number of keys points
    cc = bwconncomp(binaryImage); 
    stats = regionprops(cc, 'Area','Eccentricity'); 
    % Find the circular areaola in as blobs in the image, usually has areas
    % of < 150px
    circleIndex = find([stats.Area] < 215 & [stats.Area] > 30 & [stats.Eccentricity] < 0.8); 
    % Find the square in the image, this usually has an area of
    % ~3000-4000px
    squareIndex = find([stats.Area] > 2800 & [stats.Area] < 4000 & [stats.Eccentricity] < 0.8);
    % Combine the indexes
    idx = [circleIndex, squareIndex];
    noKeypoints = length(idx);
end

% Helper Function, 
% If the image is not grayscale convert it to grayscale
function [grayImage] = makeGray(image)
    grayImage = image;
    if (size(image, 3) == 3) 
        grayImage = rgb2gray(image);
    end
end