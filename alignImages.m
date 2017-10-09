function [ finale_align_batch ] = alignImages( patient )
%BOX Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 1
        patient = 'all';
    end
    
    [images] = readFiles(patient);
    
    length(images)
    
    
    for cell =  1:length(images)
        align_batch{1} = images{cell}{1};
        
        for image = 2:length(images{cell})
            align_batch{image} = translate_on_box_center(images{cell}{image - 1}, images{cell}{image});
        end
        
        finale_align_batch{cell} = align_batch;
    end

end

function new_img = translate_on_box_center(im1,im2)
 
% misc returned as List(Vector(x,y))
% corners returned as List(Vector(x,y))
    corners1 = get_center_box_corners(im1);
    corners2 = get_center_box_corners(im2);
   
    misc1 = get_misc_corners(im1);
    misc2 = get_misc_corners(im2);
   
    corner_diff = corners1 - corners2;
    misc_diff = misc1 - misc2;
    
    x_translate = mean([corner_diff(1), misc_diff(1)]);
 
    y_translate = mean([corner_diff(2), misc_diff(2)]);
 
    M = [1, 0, 0; 0, 1, 0; x_translate, y_translate, 1];
   
    transform_object = affine2d(M);
   
    new_img = imwarp(im2, transform_object);
   
end

function corners = get_center_box_corners(img)
    corners = detectHarrisFeatures(img, 'ROI', [200, 150, 200, 300]);
    %imshow(img); hold on;
    %plot(corners.selectStrongest(4));
end
