% centroid detection test

imageSet = readFiles('T0004');
images = imageSet{1};

detectionRates = {};
for i = 90:120
    detections = runOnImages(images, i); % Find the total number of detections      
    detectionPercentage = detections / (length(images)*3); % We want to find 3 blobs in each image
    detectionRates = [detectionRates, detectionPercentage];
    % disp(['Thresh ' , num2str(i) , ' : ' , num2str(detectionPercentage)]);
end
disp(['Best threshold for image set: ', num2str(max(detectionRates))]);

function totalDetections = runOnImages(images, threshold)
    totalDetections = 0;
    for i = 1:length(images)
        totalDetections = totalDetections + length(displayBlobCenters(images{i}, threshold));
    end
end