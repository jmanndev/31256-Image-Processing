function [ final_align_batch ] = alignImages(images)
    % Optimise threshold level for specific patient
    % For each images get keypoints from HCD and centroids from
    % Thresholding + RegionProps
    % Create transform object based on the shift in keypoints from current
    % and following image.
    % Transform image and matrix accordign to a transform object. 
    
    for cell =  1:length(images)
        noImages = length(cell);
        threshold = getThreshold(images{cell});
        align_batch = {noImages};
        align_batch{1} = makeGray(images{cell}{1});
        
        % For each image in the 'cell' call the alignment function
        for image = 2:length(images{cell})
            align_batch{image} = translate_on_box_center(images{cell}{image - 1}, images{cell}{image}, threshold);
        end
        
        final_align_batch{cell} = align_batch;
    end

end

function new_img = translate_on_box_center(im1,im2,threshold)
% misc returned as List(Vector(x,y))
% corners returned as List(Vector(x,y))

    % Harris CD
    ROI = [200 150 200 330];
    corners1 = get_center_box_corners(im1, ROI);
    corners2 = get_center_box_corners(im2, ROI);
   
    % Blob Detection MSER
    misc1 = get_misc_points(im1, threshold);
    misc2 = get_misc_points(im2, threshold);
    
    % Eigen Corner Detection
%     eigen1 = get_eigen_corners(im1);
%     eigen2 = get_eigen_corners(im2);
    
%     disp(length(corners1));
%     disp(length(corners2));
    corner_diff = (corners1 - corners2);
    
    % Get x and y translation metrics
    % Only use misc points if found or have 1:1 ratio
    if (~isempty(misc1) && ~isempty(misc2) && length(misc1) == length(misc2))
        misc_diff = (cell2mat(misc1) - cell2mat(misc2));
    
        x_translate = mean([corner_diff(1), misc_diff(1)]);
 
        y_translate = mean([corner_diff(2), misc_diff(2)]);
    else
        x_translate = mean(corner_diff(1));
 
        y_translate = mean(corner_diff(2));
    end
        
    % Transformation Matrix
    M = [1, 0, 0; 0, 1, 0; x_translate, y_translate, 1];
    transform_object = affine2d(M);
   
    Rout = imref2d(size(im1));
    new_img = imwarp(makeGray(im2), transform_object, 'OutputView', Rout);
   
end

function corners = get_center_box_corners(img, ROI)
    % Get the corners using harris features
    
    features = detectHarrisFeatures(makeGray(img), 'ROI', ROI);
    corners = features.selectStrongest(4).Location;
    
    %imshow(img); hold on;
    %plot(corners.selectStrongest(4));
end

function eigen_corners = get_eigen_corners(img)
    ROI = [200, 150, 200, 330];
    points = detectMinEigenFeatures(img, 'ROI', ROI);
    eigen_corners = points.selectStrongest(4);
end

function keypoints = get_misc_points(image, threshold)

    image = makeGray(image);
    % 90 seems to give good enough results at T0004 images
    thresholdValue = threshold;
    % Select dark objects
    binaryImage = image < thresholdValue;

    cc = bwconncomp(binaryImage); 
    stats = regionprops(cc, 'Area','Eccentricity', 'Centroid'); 
    % Find the circular areaola in as blobs in the image, usually has areas
    % of < 150px
    circleIndex = find([stats.Area] < 215 & [stats.Area] > 30 & [stats.Eccentricity] < 0.8); 
    % Find the square in the image, this usually has an area of
    % ~3000-4000px
    squareIndex = find([stats.Area] > 2800 & [stats.Area] < 4000 & [stats.Eccentricity] < 0.8);
    % Combine the two index arrays
    idx = [circleIndex, squareIndex];
    
    centroidPts = {};
    for i = idx
        centroidPts = [centroidPts, stats(i).Centroid];
    end
    
    keypoints = centroidPts;
    
end

function [grayImage] = makeGray(image)
% Helper Function, 
% If the image is not grayscale convert it
    grayImage = image;
    if (size(image, 3) == 3) 
        grayImage = rgb2gray(image);
    end
end
