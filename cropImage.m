% Crop image according to specified dimesions and show in subplot
% cropSpecification in format [x1, y1, x2-x1, y2-y1]
% Naive measured approach was a crop of [60, 153, 570-60, 445-153]

% Patient T0004 - crop works well for all images, box and full breasts are
% still within frame after crop

% Patient T0006 - crop works but missing a lot of detail downwards, need to
% increase height to include box etc 425-153

% Patient T0007 - Fine

% Patient T0179 - Add 20 to width and height to accomodate 570-60 and
% 445-153 respectively

function [cropped] = cropImage(image, spec)

% figure;
% title('original'); subplot(1,2,1); imshow(image); axis on;
cropped = imcrop(image, spec);
% title('cropped'); subplot(1,2,2); imshow(cropped); axis on;

end
