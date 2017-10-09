% Take some images and compare the average shift of keypoints from image to image
% Currently only uses Harris corner detection
function error = errorFunction(inputImages, initalMetric)

noImages = length(inputImages);

if ( size(inputImages{1}, 3) == 3) 
    for i=1:noImages
        inputImages{i} = rgb2gray(inputImages{i});
    end
end

total = 0;
ROI = [200 150 200 330];
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

function averageShift = calcShift(firstImageCorners, secondImageCorners)
    totalShift = 0;
    for i=1:length(firstImageCorners)-1
        totalShift = totalShift + calcDistance(firstImageCorners(i), secondImageCorners(i), firstImageCorners(i+4), secondImageCorners(i+4));
    end
    averageShift = totalShift / length(firstImageCorners);
end

function distance = calcDistance(x1, x2, y1, y2)

    distance = sqrt((x2-x1)^2+(y2-y1)^2);

end


%im1
% get harris corners
%im2
% get harris corners

%compare harris arrays
% for i=1:4
%     plot([im1_corners.Location(i) im2_corners.Location(i)], [im1_corners.Location(i+4) im2_corners.Location(i+4)], 'r' )
% end