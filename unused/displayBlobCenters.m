% Displays the center of relevant sized blobs in image
% use better regionprops to only find designated blobs
function [Centroids] = displayBlobCenters(image, threshold)

% Ensure grayscale format of image
if ( size(image, 3) == 3) 
    image = rgb2gray(image);
end

% 90 seems to give good enough results at T0004 images
thresholdValue = threshold;
% Select dark objects
binaryImage = image < thresholdValue;
imshow(binaryImage);

cc = bwconncomp(binaryImage); 
stats = regionprops(cc, 'Area','Eccentricity', 'Centroid'); 
idx = find([stats.Area] > 80 & [stats.Eccentricity] < 0.8); 
% BW = ismember(labelmatrix(cc), idx);  

figure; imshow(image); hold on;
centroidPts = {};
for i = idx
    centroidPts = [centroidPts, stats(i).Centroid];
    plot(stats(i).Centroid(1), stats(i).Centroid(2), 'r.');
end

Centroids = centroidPts;

end
