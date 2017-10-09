%   A collection of demonstrations and samples for the presentation and
%   proof of concepts.

function sampleFunctions(images, code)
%   Use final 2 images of dataset as these were usually the most distorted
    img1 = images{1,1}{1,1};
    img2 = images{1,1}{1,2};
    
    switch code
        case 'mask'
            masking_demo(img1);
        case 'hcd'
            hcd_demo(img1);
        case 'corresponding'
            corresponding_demo(img1, img2);
        otherwise
    end
end

function masking_demo(img1)
%   Demonstrate the masking by threshold feature of MatLab
    image = makeGray(img1);
    threshold = 90;
    img = image < threshold;
    imshow(img);
end

function hcd_demo(img1)
%   Demonstrate basic Harris Corner Detection used in the program
    img = img1;
    ROI = [200 150 200 330];
    features = detectHarrisFeatures(makeGray(img), 'ROI', ROI);
    corners = features.selectStrongest(4);
    imshow(img);
    hold on;
    plot(corners);
end

function corresponding_demo(img1, img2)
%   Demonstrate how using corresponding points does not allow for easy
%   transformation of the image without skewing.
    I1 = makeGray(img1);
    I2 = makeGray(img2);
    points1 = detectHarrisFeatures(I1);
    points2 = detectHarrisFeatures(I2);
    [f1, vpts1] = extractFeatures(I1, points1);
    [f2, vpts2] = extractFeatures(I2, points2);
    indexPairs = matchFeatures(f1, f2) ;
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));
    
    [tform, ~, ~] = estimateGeometricTransform(matchedPoints2, matchedPoints1, 'similarity');
    outputView = imref2d(size(I1));
    recovered  = imwarp(I2,tform,'OutputView',outputView);
    figure, imshowpair(I1,recovered);
end

function [grayImage] = makeGray(image)
% Helper Function, 
% If the image is not grayscale convert it
    grayImage = image;
    if (size(image, 3) == 3) 
        grayImage = rgb2gray(image);
    end
end