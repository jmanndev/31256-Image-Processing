% Load and Display image
images = readFiles('all');
image = rgb2gray(images{1}{1});
subplot(3,3,1);
imshow(image);
% Maximize the figure window.
drawnow;
caption = sprintf('Original image');
title(caption);

% Display Histogram of image
[pixelCount, grayLevels] = imhist(image);
subplot(3, 3, 2);
bar(pixelCount);
title('Histogram of original image'); % Scale x axis manually.
grid on;
%

% normalizedThresh = 0.6;
% threshold = normalizedThresh * max(max(image));
% binaryImage = imbinarize(image, normalizedThresh);

% Threshold image at certain value
% Maybe the thresholding can be run until we find 3 disinct blobs smaller
% than a certain size

% 90 seems to give good enough results at T0004 images
thresholdValue = 90;
% Select dark objects
binaryImage = image < thresholdValue;
% Display binary image
subplot(3,3,3);
imshow(binaryImage);
title('Binary Image');


% Label blobs
labeledImage = bwlabel(binaryImage, 8);
subplot(3,3,4);
imshow(labeledImage, []);
title('Labeled');

% Get blob props
blobMeasurements = regionprops(logical(binaryImage), image, 'all');
numberOfBlobs = size(blobMeasurements, 1);

% Show boundaries
subplot(3,3,5);
imshow(image);
title('Outlines');
hold on;
boundaries = bwboundaries(binaryImage);
numberOfBoundaries = size(boundaries, 1);
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
	plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 2);
end
hold off;

% use better regionprops to only find designated blobs
cc = bwconncomp(binaryImage); 
stats = regionprops(cc, 'Area','Eccentricity', 'Centroid'); 
idx = find([stats.Area] > 80 & [stats.Eccentricity] < 0.8); 
BW2 = ismember(labelmatrix(cc), idx);  
subplot(3,3,6);
imshow(BW2);

centroidPts = {};
disp(idx);
for i = idx
    centroidPts = [centroidPts, stats(i).Centroid];
    disp(stats(i).Centroid);
end

subplot(3,3,7);
imshow(image);
plot(centroidPts);