function test = animate( images , times2play, fps)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    if (nargin < 2)
        times2play = 3;
        fps = 3;
    elseif (nargin < 3)
        fps = 3;
    end
    
    images = images{1};
    
    for i = 1:length(images)
        img = cat(3, images{i}, images{i}, images{i});
        frames(i) = im2frame(img);
    end
    
    movie(frames, times2play, fps);
    test = true;
end

% function test = animate( images , times2play, fps)
% %UNTITLED3 Summary of this function goes here
% %   Detailed explanation goes here
%     if (nargin < 2)
%         times2play = 3;
%         fps = 3;
%     elseif (nargin < 3)
%         fps = 3;
%     end
%     pics = images{1};
%     for i = 1:length(pics)
% %         map = uint8( 256 * gray(256) );
% %         rgbImage = ind2rgb(images{i}, map);
% %         frames(i) = im2frame(pics{i});
%         img = pics{i};
%         frames(i) = im2frame(img);
%     end
%     
%     movie(frames, times2play, fps);
%     test = true;
% end