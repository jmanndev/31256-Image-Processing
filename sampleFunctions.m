function sampleFunctions(images, code)
    img1 = images{1,1}{1,19};
    img2 = images{1,1}{1,20};
    
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
    image = makeGray(img1);
    threshold = 90;
    img = image < threshold;
    imshow(img);
end

function hcd_demo(img1)
    img = img1;
    ROI = [200 150 200 330];
    features = detectHarrisFeatures(makeGray(img), 'ROI', ROI);
    corners = features.selectStrongest(4);
    imshow(img);
    hold on;
    plot(corners);
end

function corresponding_demo(img1, img2)
    I1 = makeGray(img1);
    I2 = makeGray(img2);
    points1 = detectHarrisFeatures(I1);
    points2 = detectHarrisFeatures(I2);
    [f1, vpts1] = extractFeatures(I1, points1);
    [f2, vpts2] = extractFeatures(I2, points2);
    indexPairs = matchFeatures(f1, f2) ;
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));
    
    [tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(matchedPoints1, matchedPoints2, 'similarity');
    figure;
    showMatchedFeatures(I1,I2, inlierOriginal, inlierDistorted);
    title('Matching points (inliers only)');
    legend('ptsOriginal','ptsDistorted');
    
    Tinv  = tform.invert.T;

    ss = Tinv(2,1);
    sc = Tinv(1,1);
    scale_recovered = sqrt(ss*ss + sc*sc);
    theta_recovered = atan2(ss,sc)*180/pi;
    
    outputView = imref2d(size(I1));
    recovered  = imwarp(I2,tform,'OutputView',outputView);
    figure, imshowpair(I1,recovered,'montage');
    showMatchedFeatures(I1,recovered, inlierOriginal, inlierDistorted);

%       figure;
%     ax = axes;
%     showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
%     title(ax, 'Candidate HCD point matches');
%     legend(ax, 'Matched points 1','Matched points 2');
end

function [grayImage] = makeGray(image)
% Helper Function, 
% If the image is not grayscale convert it
    grayImage = image;
    if (size(image, 3) == 3) 
        grayImage = rgb2gray(image);
    end
end