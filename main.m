% Run script, uses the readFiles and HarrisFunction to iterate over the
% thermograms and show the resultant alignment of the images 

% Should be the main entrypoint for the program which is run to 
% do all processing and alignment of demo image set

% DONT FORGET TO ADD ALL SUBFOLDERS TO MATLAB PWD

function [PROCESSEDIMAGES] = main(functionName)
run('readFiles.m');

fixed = images{1};
figure;
PROCESSEDIMAGES = {length(images)};
PROCESSEDIMAGES{1} = rgb2gray(fixed);

for ii=2:length(images)
    % show initial difference before processing
    moving = images{ii};
    imshowpair(fixed, moving); title('Initial Difference');
    h = getframe;
    before = h.cdata;

    % run images through function
    out = callFunction(functionName, moving, fixed);
    imshowpair(fixed, out.RegisteredImage); title('After Processing');
    h = getframe;
    after = h.cdata;
    
    % add to output set
    PROCESSEDIMAGES{ii} = out.RegisteredImage;

    % display before and after processing images together
    imshowpair(before, after, 'montage'); title('Before / After Processing');
end
end

function [IMAGE] = callFunction(functionName, fixed, moving)

if (strcmp(functionName,'Harris'))
    IMAGE = harrisFunctionOne(moving, fixed);
elseif (strcmp(functionName, 'SURF'))
    IMAGE = surfFunctionOne(moving, fixed);
end 

end





