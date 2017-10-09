% Read from directory

function [images] = readFiles(directory)
    % Expecting directory in format ./Folder/Folder/
    imagefiles = dir([directory '*.jpg']);
    nfiles = length(imagefiles);
    currentimages = {nfiles};
    
    for ii=1:nfiles
        currentfilename =  imagefiles(ii).name;
        currentimage = imread([directory currentfilename]);
        currentimages{ii} = currentimage;
    end
    
    images = currentimages;
    
end

