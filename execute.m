% Run script, uses the readFiles and HarrisFunction to iterate over the
% thermograms and show the resultant alignment of the images 

% load files into memory
run('readFiles.m');

fixed = images{1};
figure;
processedImages = {length(images)};
processedImages{1} = rgb2gray(fixed);

for ii=2:length(images)
    % show initial difference before processing
    moving = images{ii};
    imshowpair(fixed, moving); title('Initial Difference');
    h = getframe;
    before = h.cdata;

    % run images through function
    out = HarrisFunction(moving, fixed);
    imshowpair(fixed, out.RegisteredImage); title('After Processing');
    h = getframe;
    after = h.cdata;
    
    % add to output set
    processedImages{ii} = out.RegisteredImage;

    % display before and after processing images together
    imshowpair(before, after, 'montage'); title('Before / After Processing');
end





