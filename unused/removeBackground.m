% Uses maskBackground to get the surrounding area of an image and 
% black it all out in order to provide less noise for an accuracy evaluator

% should take a rgb image as input, however the bsxfun method can handle
% grayscale too

function [maskedImage] = removeBackground(image)

% Use generated maskBackground function to extract an approximaged mask
mask = maskSides(image);
% Call the inverse of the mask since it was easier to mask the background 
% than the foreground
maskedImage = bsxfun(@times, image, cast(imcomplement(mask), 'like', image));

end