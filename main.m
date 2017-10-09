% Main file run this you dingo

function [alignedImages] = main() 
    
    % get images and matrices
    dataset = readFiles('all');
    % align images according to method
    alignedImages = alignImages(dataset);
    % animate
    % animate(alignedImages, 1, 30);
    % show error
    % Calculate error based on the shift in images / compared to original
    % dataset. 
    stuff = 0;
end
