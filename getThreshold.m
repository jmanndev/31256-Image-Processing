function thresholdLevel = getThreshold(images) 

% Looking at histograms of the images we see that few pixels have values
% less than 100. We try to place the threshold in such a way that maximises
% the wanted size blobs of the image. 
thresholdLevels = 90:120;
badDetectionsPerLevel = {30};

for level = 1:length(thresholdLevels)
    badDetects = 0; % Bad detections find less than or more than 3 blobs
    for i = 1:length(images)
        if (getMaskingPoints(images{i}, thresholdLevels(level)) ~= 3)
            badDetects = badDetects + 1;
        end
    end
    badDetectionsPerLevel{level} = badDetects;
end
[minEl, minInd] = min(cell2mat(badDetectionsPerLevel));
% disp(['Minimum bad detections at ' num2str(thresholdLevels(minInd(1)))]);

thresholdLevel = thresholdLevels(minInd(1));

end

function noKeypoints = getMaskingPoints(image, threshold)

    image = makeGray(image);
    thresholdValue = threshold;
    binaryImage = image < thresholdValue;

    cc = bwconncomp(binaryImage); 
    stats = regionprops(cc, 'Area','Eccentricity'); 
    idx = find([stats.Area] > 40 & [stats.Eccentricity] < 0.8); 
%     BW2 = ismember(labelmatrix(cc), idx); 
%     figure;
%     imshowpair(image, BW2, 'montage');
    
    noKeypoints = length(idx);
end

function [grayImage] = makeGray(image)
% Helper Function, 
% If the image is not grayscale convert it
    grayImage = image;
    if (size(image, 3) == 3) 
        grayImage = rgb2gray(image);
    end
end