% Get list of all jpg files in the image directory from google drive
% DIR returns as a structure array.  You will need to use () and . to get
% the file names.
imagefiles = dir('./Dynamic Thermographic Images/*.jpg');      
nfiles = length(imagefiles);  % Number of files found
images = {nfiles};
for ii=1:nfiles
   currentfilename =  imagefiles(ii).name;
   currentimage = imread(['./Dynamic Thermographic Images/' currentfilename]);
   images{ii} = currentimage;
end
clearvars currentfilename currentimage ii imagefiles nfiles