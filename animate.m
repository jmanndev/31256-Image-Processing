function test = animate( images , times2play, fps)
%Function that given a cell wrapper of grayscale cell images animates them as a GIF image
%   The GIF is repeated a times2play number of times, displaying fps
%   imagess every second
    
    % If any of times2play or fps variable are not passed, this code
    % initializes them
    if (nargin < 2)
        times2play = 3;
        fps = 3;
    elseif (nargin < 3)
        fps = 3;
    end
    
    % Extract the images from the cell
    images = images{1};
    
    % Creates the frame array for the animation movie
    for i = 1:length(images)
        % Checks if the images is grayscale, if it is the image this converts 
        % the images from a grayscale image format to rbg image
        if (size(images{i}, 3) == 1)
            img = cat(3, images{i}, images{i}, images{i});
        else
            img = images{i};
        end
        
        frames(i) = im2frame(img);
    end
    
    % Plays the animation
    movie(frames, times2play, fps);
    
    test = true;
end