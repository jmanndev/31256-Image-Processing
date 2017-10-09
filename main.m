%   Main entry function to program

function [originalImages, alignedImages, error] = main(dir) 
%     if nargin < 1
%         dir = './Dynamic Thermographic Images/T0004/';
%     end
    
%   Get images and matrices
    dataset = {readFiles(dir)};
    originalImages = dataset;
%   animate(originalImages);

%   Align images according to method
    alignedImages = alignImages(dataset);
%   animate(alignedImages);
%   Calculate error based on the shift in images / compared to original
%   dataset.
    initial = errorFunction(dataset{1}, 1);
    disp(errorFunction(dataset{1}, initial));
    error = errorFunction(alignedImages{1}, initial)
    disp(error);
end
