
images = readFiles('all');

% Get the MSE of initial images, 1:1 then avg and total at end of set
initialMSE = {length(images)+2};
for i=1:length(images)
    [metrics, avg, total] = accuracy(images{i});
    initialMSE{i} = metrics;
    initialMSE{i}{length(images{i})+1} = avg;
    initialMSE{i}{length(images{i})+2} = total;
end

% Iterate all 80 images and run the mask function on them
masked_images = {length(images)};
for i=1:length(images)
    temp_masked = {length(images{i})};
    for j=1:length(images{i})
        temp_masked{j} = removeBackground(images{i}{j});
    end
    masked_images{i} = temp_masked;
end

% Get the MSE of masked images, 1:1 then avg and total at end of set
maskedMSE = {length(masked_images)+2};
for i=1:length(masked_images)
    [metrics, avg, total] = accuracy(masked_images{i});
    maskedMSE{i} = metrics;
    maskedMSE{i}{length(masked_images{i})+1} = avg;
    maskedMSE{i}{length(masked_images{i})+2} = total;
end

% Iterate all 80 images and run the crop function on them
cropped_images = {length(images)};
for i=1:length(images)
    temp_cropped = {length(images{i})};
    for j=1:length(images{i})
        temp_cropped{j} = cropImage(images{i}{j}, [60, 153, 570-60, 445-153]);
    end
    cropped_images{i} = temp_cropped;
end

% Get the MSE of initial images, 1:1 then avg and total at end of set
croppedMSE = {length(cropped_images)+2};
for i=1:length(cropped_images)
    [metrics, avg, total] = accuracy(cropped_images{i});
    croppedMSE{i} = metrics;
    croppedMSE{i}{length(cropped_images{i})+1} = avg;
    croppedMSE{i}{length(cropped_images{i})+2} = total;
end