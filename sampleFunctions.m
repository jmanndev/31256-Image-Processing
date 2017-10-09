function sampleFunctions(images, code)
    img1 = images{1,1}{1,1};
    img2 = images{1,1}{1,2};
    
    switch code
        case 'mask'
            masking_demo(img1);
        case 'hcd'
            hcd_demo(img1);
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

function [grayImage] = makeGray(image)
% Helper Function, 
% If the image is not grayscale convert it
    grayImage = image;
    if (size(image, 3) == 3) 
        grayImage = rgb2gray(image);
    end
end