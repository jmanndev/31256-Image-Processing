% Get list of all jpg files in the image directory from google drive
% The images are sorted into patient folders, the currently available 
% ones are T0004, 6, 7 & 179. Change the currentPatient to change patient

currentPatient = 'T0004';

% DONT FORGET TO ADD ALL SUBFOLDERS TO MATLAB PWD

imagefiles = dir(['./Dynamic Thermographic Images/' currentPatient '/*.jpg']);      
nfiles = length(imagefiles);  % Number of files found
images = {nfiles};
for ii=1:nfiles
   currentfilename =  imagefiles(ii).name;
   currentimage = imread(['./Dynamic Thermographic Images/' currentPatient '/' currentfilename]);
   images{ii} = currentimage;
end

% Pre-load some test sets for evaluation purposes
% It is assumed that the first two images will have more in common 
% than first and last. I.e the first set should have a better score.
goodImageTestSet = { images{1}, images{2} };
badImageTestSet = { images{1}, images{20} };

% clear files to avoid a cluttered workspace
clearvars currentfilename currentimage ii imagefiles nfiles