%   Main entry function to program

function [originalImages, alignedImages, error] = main(dir) 
%     if nargin < 1
%         dir = './Dynamic Thermographic Images/T0004/';
%     end
    
%   Get images and matrices
    dataset = {readFiles(dir)};
    originalImages = dataset;

%   Align images according to method
    alignedImages = alignImages(dataset);
    
%   Calculate error based on the shift in images / compared to original
%   dataset.
    initial = errorFunction(dataset{1}, 1);
    error = errorFunction(alignedImages{1}, initial);
    
end
