%Subject: Image Processing & Recognition

% Ece Nur Koylan
%Exercises part I-3

img1 = imread('img.jpg');
img2 = imread('star.jpg');

%test task 1
processedImage = arithmeticFunction(img1, 3, 54, 1); %(inputImage, technique, k, mode)
figure;
subplot(1, 2, 1); imshow(img1); title('Original Image');
subplot(1, 2, 2); imshow(processedImage); title('Processed');

%test task 2
kValue = 0.3;
mixedResult = mixing(img1, img2, kValue);
figure;
imshow(mixedResult);
title(['Mixed Image with k = ', num2str(kValue)]);

%test task 3 on appdesigner

%test task 4
mirroredResult = mirror(img1);
figure('Name', 'Horizontal Mirror');
subplot(1, 2, 1); imshow(img1); title('Original Image');
subplot(1, 2, 2); imshow(mirroredResult); title('Mirrored Image');

%test task 5
scaleK = 0.5; 
scaledResult = scale(img1, scaleK);

figure('Name', 'Scaled Image');
imshow(scaledResult);

%test task 6
rotationAngle = 30; 
rotatedResult = rotateImage(img1, rotationAngle);

figure('Name', 'Rotated Image');
imshow(rotatedResult);

%test task 7
affineResult = rotateAffine(img1);

figure('Name', '90 Degree Left Rotation (Affine Rotation)');
imshow(affineResult);

%Task 1: Arithmetic Operations and Normalization
function outputImage = arithmeticFunction(inputImage, technique, k, mode)

    inputImage = double(inputImage);
    [numRows, numCols, numChannels] = size(inputImage);
    
    % temporary matrix to store intermediate results
    tempImage = zeros(numRows, numCols, numChannels);

    for r = 1:numRows
        for c = 1:numCols
            for ch = 1:numChannels
                pixelValue = inputImage(r, c, ch);
                
                % Apply the selected arithmetic technique
                if technique == 1
                    pixelValue = pixelValue + k; 
                elseif technique == 2
                    pixelValue = pixelValue * k; 
                elseif technique == 3
                    pixelValue = 20 * sqrt(pixelValue); 
                end
                
                tempImage(r, c, ch) = pixelValue;
            end
        end
    end

    % Normalization 
    if mode == 1 
        % Saturated Mode Values >= 255 become 255, values <= 0 become 0
        for r = 1:numRows
            for c = 1:numCols
                for ch = 1:numChannels
                    currentValue = tempImage(r, c, ch);
                    if currentValue > 255
                        currentValue = 255;
                    elseif currentValue < 0
                        currentValue = 0;
                    end
                    tempImage(r, c, ch) = currentValue;
                end
            end
        end

        outputImage = uint8(tempImage); 

    elseif mode == 0 
        % Scaling Mode: Normalize the range to [0, 255]
        minVal = tempImage(1,1,1);
        maxVal = tempImage(1,1,1);
        
        for r = 1:numRows
            for c = 1:numCols
                for ch = 1:numChannels
                    if tempImage(r, c, ch) < minVal, minVal = tempImage(r, c, ch); end
                    if tempImage(r, c, ch) > maxVal, maxVal = tempImage(r, c, ch); end
                end
            end
        end
        
        outputImage = zeros(numRows, numCols, numChannels, 'uint8');
        
        % stretching formula= (Value - min) * (255 / (max - min))
        rangeScale = 255 / (maxVal - minVal);
        for r = 1:numRows
            for c = 1:numCols
                for ch = 1:numChannels
                    scaledValue = (tempImage(r, c, ch) - minVal) * rangeScale;
                    outputImage(r, c, ch) = uint8(scaledValue);
                end
            end
        end
    end
end



%Task 2: Linear Combination of Two Images
function outputImage = mixing(imageOne, imageTwo, kFactor)
    imageOne = double(imageOne);
    imageTwo = double(imageTwo);
    
    [numRows, numCols, numChannels] = size(imageOne);
    
    % temporary result matrix with zeros
    tempImage = zeros(numRows, numCols, numChannels);

    for r = 1:numRows
        for c = 1:numCols
            for ch = 1:numChannels
                % linear combination formula: k*Im1 + (1-k)*Im2
                pixelValue = (kFactor * imageOne(r, c, ch)) + ((1 - kFactor) * imageTwo(r, c, ch));
                
                tempImage(r, c, ch) = pixelValue;
            end
        end
    end
    
    outputImage = uint8(tempImage);
end

% Task 4: Function to create a mirrored image
function outputImage = mirror(inputImage)
    [numRows, numCols, numChannels] = size(inputImage);
    
    outputImage = zeros(numRows, numCols, numChannels, 'uint8');

    for r = 1:numRows
        for c = 1:numCols

            mirroredCol = numCols - c + 1;
            for ch = 1:numChannels
                outputImage(r, mirroredCol, ch) = inputImage(r, c, ch);
            end
        end
    end
end

% Task 5: Function to resize the image (start:step:stop)
function outputImage = scale(inputImage, k)
    [numRows, numCols, ~] = size(inputImage);
   
    step = 1/k;

    rowIndices = round(1 : step : numRows);
    colIndices = round(1 : step : numCols);
    
    % Boundary check
    rowIndices(rowIndices > numRows) = numRows;
    colIndices(colIndices > numCols) = numCols;
    rowIndices(rowIndices < 1) = 1;
    colIndices(colIndices < 1) = 1;

    outputImage = inputImage(rowIndices, colIndices, :);
end

% Task 6: Function to rotate image by a given angle
function outputImage = rotateImage(inputImage, angle)
    radAngle = angle * (pi / 180);
    
    [numRows, numCols, ~] = size(inputImage);
    
    centerX = floor(numCols / 2 + 1);
    centerY = floor(numRows / 2 + 1);
    
    outputImage = zeros(numRows, numCols, size(inputImage, 3), 'uint8');

    cosA = cos(radAngle);
    sinA = sin(radAngle);

    for r = 1:numRows
        for c = 1:numCols
            y = r - centerY;
            x = c - centerX;
            
            origX = round(x * cosA + y * sinA) + centerX;
            origY = round(-x * sinA + y * cosA) + centerY;
            
            if (origY >= 1 && origY <= numRows && origX >= 1 && origX <= numCols)
                outputImage(r, c, :) = inputImage(origY, origX, :);
            end
        end
    end
end

% Task 7: Function to rotate 90 degrees left using affine logic
function outputImage = rotateAffine(inputImage)
    [numRows, numCols, numChannels] = size(inputImage);
    
    % New rows = old columns, new cols = old rows
    outputImage = zeros(numCols, numRows, numChannels, 'uint8');

    for r = 1:numRows
        for c = 1:numCols
            newR = numCols - c + 1;
            newC = r;
            
            outputImage(newR, newC, :) = inputImage(r, c, :);
        end
    end
end