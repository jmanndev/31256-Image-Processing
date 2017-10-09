% Main file run this you dingo

function [stuff] = main(dataset) 
    
    % get images
    images = readFiles('all');
    % align images according to method
    alignedImages = align(images);
    % animate
    animate(alignedImages, 1, 30);
    % show error
    stuff = 0;

end
