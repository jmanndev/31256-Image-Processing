% Get list of all jpg files in the image directory from google drive
% The images are sorted into patient folders, the currently available 
% ones are T0004, 6, 7 & 179. Change the currentPatient to change patient

% Pass in either 'all' or a patient id to define what to load

function [images] = readFiles(option)

patients = {'T0004', 'T0006', 'T0007', 'T0179'};

if (strcmp(option, 'all')) 
    load = patients;
else 
    load = {option};
end

images = {length(load)};

for i=1:length(load)
    imagefiles = dir(['./Dynamic Thermographic Images/' load{i} '/*.jpg']);      
    nfiles = length(imagefiles);  % Number of files found
    currentimages = {nfiles};
    
    for ii=1:nfiles
        currentfilename =  imagefiles(ii).name;
        currentimage = imread(['./Dynamic Thermographic Images/' load{i} '/' currentfilename]);
        currentimages{ii} = currentimage;
    end
    
    images{i} = currentimages;
end

% Pre-load some test sets for evaluation purposes
% It is assumed that the first two images will have more in common 
% than first and last. I.e the first set should have a better score.
% goodImageTestSet = { images{1}, images{2} };
% badImageTestSet = { images{1}, images{20} };

end
