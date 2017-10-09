function test = animate( images , times2play, fps)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    if (nargin < 2)
        times2play = 3;
        fps = 3;
    elseif (nargin < 3)
        fps = 3;
    end
    
    frames = {};
    for i = 1:length(images)
%         rgbImage = cat(3, images{i}, images{i}, images{i});
        map = uint8( 256 * gray(256) );
        rgbImage = ind2rgb(images{i}, map);
        frames{i} = im2frame(rgbImage);
    end
    
    movie(frames, times2play, fps);
    test = true;
end

