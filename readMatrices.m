% Loads all the heat matrices into memory. The matrices are formatted as
% 640x480 numbers which correspond to the intensity of the thermal images.

matrixFiles = dir('./Dynamic Heat Matrices/*T0004*.txt');      
nfiles = length(matrixFiles);  % Number of files found
matrices = {nfiles};
for ii=1:nfiles
   currentFilename =  matrixFiles(ii).name;
   currentMatrixId = fopen(['./Dynamic Heat Matrices/' currentFilename], 'r');
   formatspec = '%f';
   currentMatrix = fscanf(currentMatrixId, formatspec);
   %Change image to proper format and take the inverse e.g. flip col to
   %row 
   matrices{ii} = reshape(currentMatrix, 640, [])'; 
end
clearvars currentFilename currentMatrixId formatspec ii currentMatrix nfiles matrixFiles