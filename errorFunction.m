% Take some images and compare the average shift of keypoints from image to image
% using Harris Corner Detection
function error = errorFunction(inputImages, initalMetric)

noImages = length(inputImages);

% Check if the images are in an RGB format, if so, they are converted into
% grayscale
if ( size(inputImages{1}, 3) == 3) 
    for i=1:noImages
        inputImages{i} = rgb2gray(inputImages{i});
    end
end

total = 0;

% The area to look for the box is constraint within ROI to reduce the detection OF unwanted features
ROI = [200 150 200 330];

% Loops and compares the shift from the features of one image to the next
% one and adds that error up.
currentImageCorners = detectHarrisFeatures(inputImages{1}, 'ROI', ROI);
for i=1:noImages-1
    nextCorners = detectHarrisFeatures(inputImages{i+1}, 'ROI', ROI);
    metric = calcShift(currentImageCorners.Location, nextCorners.Location);
    total = total + metric;
    currentImageCorners = nextCorners;
end

error = total / (noImages-1);
error = error / initalMetric;

end

%Function that calculates the average shift of the corners of two images. A
%lower value means a better alignment
function averageShift = calcShift(firstImageCorners, secondImageCorners)
    totalShift = 0;
    for i=1:length(firstImageCorners)-1
        % Calculate the shift between the current corners and add it to the
        % total shift
        totalShift = totalShift + calcDistance(firstImageCorners(i,1), secondImageCorners(i,1), firstImageCorners(i,2), secondImageCorners(i,2));
    end
    
    % Average the shift
    averageShift = totalShift / length(firstImageCorners);
end

% Function that calculates the Euclidian distance between two points given
% as x1, x2, y1, y2. Where x1 and y1 belong to the first point, and x2 and
% y2 belong to the second point
function distance = calcDistance(x1, x2, y1, y2)
    distance = sqrt((x2-x1)^2+(y2-y1)^2);
end