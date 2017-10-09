function [ animation ] = animate( images , times2play, fps)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2:
        times2play = 3;
        fps = 3;
    elseif nargin < 3:
        fps = 3;
    end
    
    for i = 1:length(images{1})
        frames(i) = im2frame(images{1}{i});
    end
    
    movie(frames, times2play, fps);
end

