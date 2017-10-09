% Main file run this you dingo

function [alignedImages] = main(dir) 
    if nargin < 1
        dir = './Dynamic Thermographic Images/T0004/';
    end
    
    % get images and matrices
    dataset = {readFiles(dir)};
    % align images according to method
    alignedImages = alignImages(dataset);
    % animate
    % animate(alignedImages, 1, 30);
    % show error
    % Calculate error based on the shift in images / compared to original
    % dataset. 
    initial = errorFunction(dataset{1}, 1);
    disp(errorFunction(dataset{1}, initial));
    disp(errorFunction(alignedImages{1}, initial));
    
    stuff = 0;
end
