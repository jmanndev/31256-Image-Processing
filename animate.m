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
        

        frames(i) = im2frame(uint8(images{i}));
    end
    
    movie(frames, times2play, fps);
    test = true;
end

