%Subject: Image Processing & Recognition

% Ece Nur Koylan
%Exercises part I-4


% Task 1: gray scale binarization

img = imread('img.jpg');

% check if the image is RGB if yes, convert to grayscale.
if size(img, 3) == 3
    im = rgb2gray(img);
else
    im = img; 
end

figure;
imshow(im);
title('Original Grayscale Image');

builtin_bw = imbinarize(im);

figure;
imshow(builtin_bw);
title('imbinarize() Result');


% Task 2: Custom Otsu Binarization Algorithm

% call func.
[custom_bw, optimal_level] = my_otsu(im);

builtin_bw = imbinarize(im);

figure;
subplot(1,3,1); 
imshow(im); 
title('Original Image');

subplot(1,3,2); 
imshow(custom_bw); 
title(['Custom Otsu (Level: ', num2str(optimal_level), ')']);

subplot(1,3,3); 
imshow(builtin_bw); 
title('imbinarize()');


function [bw_img, best_level] = my_otsu(im)
    img_double = double(im);
    [rows, cols] = size(img_double);
    
    step_val = 50;
    levels = 50:step_val:250;
    
    variances = zeros(1, length(levels));
    
    level_idx = 1;
    for level = levels
        whites = 0; 
        blacks = 0; 
        mean_bl = 0; 
        mean_wh = 0;
        
        for x = 1:rows
            for y = 1:cols
                pixel = img_double(x, y);
                
                if pixel > level
                    whites = whites + 1;
                    mean_wh = mean_wh + pixel;
                else
                    blacks = blacks + 1;
                    mean_bl = mean_bl + pixel;
                end
            end
        end
        
        % avoiding division by zero
        if whites > 0
            avg_wh = mean_wh / whites;
        else
            avg_wh = 0;
        end
        
        if blacks > 0
            avg_bl = mean_bl / blacks;
        else
            avg_bl = 0;
        end
        
        variance = whites * blacks * (avg_wh - avg_bl)^2;
        variances(level_idx) = variance;
        
        level_idx = level_idx + 1;
    end
    plot(variances)
    variance
    % Find the optimal level 
    max_var = max(variances);
    
    best_idx = find(variances == max_var, 1) 
    best_level = levels(best_idx);
    
    bw_img = false(rows, cols); 
    
    for x = 1:rows
        for y = 1:cols
            if img_double(x, y) > best_level
                bw_img(x, y) = true;  
            else
                bw_img(x, y) = false; 
            end
        end
    end
end

% Task 3: Filtering with fspecial and imfilter

% filter masks
mask_mean    = fspecial('average', [3 3]);       % mean filter
mask_gauss   = fspecial('gaussian', [3 3], 0.5); % gaussian filter 
mask_prewitt = fspecial('prewitt');              % prewitt filter
mask_sobel   = fspecial('sobel');                % sobel filter
mask_log     = fspecial('log', [9 9], 0.5);      % laplacian of gaussian filter

roberts_x = [1 0; 0 -1];
roberts_y = [0 1; -1 0];

fx = imfilter(im, roberts_x);
fy = imfilter(im, roberts_y);

% apply masks
filtered_mean    = imfilter(im, mask_mean);
filtered_gauss   = imfilter(im, mask_gauss);
filtered_prewitt = imfilter(im, mask_prewitt);
filtered_sobel   = imfilter(im, mask_sobel);
filtered_log     = imfilter(im, mask_log);
filtered_roberts = sqrt(double(fx).^2 + double(fy).^2);

figure;

subplot(2, 4, 1); 
imshow(im); 
title('Original Image');

subplot(2, 4, 2); 
imshow(filtered_mean); 
title('Mean Filter');

subplot(2, 4, 3); 
imshow(filtered_gauss); 
title('Gauss Filter');

subplot(2, 4, 4); 
imshow(filtered_prewitt); 
title('Prewitt Filter');

subplot(2, 4, 5); 
imshow(filtered_sobel); 
title('Sobel Filter');

subplot(2, 4, 6); 
imshow(filtered_log); 
title('LoG Filter');

subplot(2, 4, 7); 
imshow(filtered_roberts); 
title('Roberts Filter');


% Task 4: 1D Custom Filtering (Mean and Median)
im_double = double(im); % to avoid overflow
mean_row = my_filter(im, 'mean', 'row');
mean_col = my_filter(im, 'mean', 'col');

median_row = my_filter(im, 'median', 'row');
median_col = my_filter(im, 'median', 'col');

figure;
subplot(2, 3, 1); 
imshow(uint8(im)); 
title('Original Image');

subplot(2, 3, 2); 
imshow(uint8(mean_row)); 
title('1D Mean Filter (Row)');

subplot(2, 3, 3); 
imshow(uint8(mean_col)); 
title('1D Mean Filter (Col)');

subplot(2, 3, 5); 
imshow(uint8(median_row)); 
title('1D Median Filter (Row)');

subplot(2, 3, 6); 
imshow(uint8(median_col)); 
title('1D Median Filter (Col)');


function out_img = my_filter(im, mask_type, direction)
    [rows, cols] = size(im);
    
    % copy the original image
    out_img = im; 
    
    % avoid out of bounds error at borders by using rows-1 and start from 2
    for i = 2:rows-1
        for j = 2:cols-1
            
            if strcmp(direction, 'row')

                neighbors = [im(i, j-1), im(i, j), im(i, j+1)];

            elseif strcmp(direction, 'col')

                neighbors = [im(i-1, j), im(i, j), im(i+1, j)];
            end
            
            if strcmp(mask_type, 'mean')
                out_img(i, j) = sum(neighbors) / 3;
                
            elseif strcmp(mask_type, 'median')
                out_img(i, j) = median(neighbors);
            end
            
        end
    end
end

% to see what is difference
%difference = abs(im - mean_col);
%figure;
%imshow(difference, []); 


% Task 5: 2D gaussian mask and custom 2D filtering

B = 5; 
my_gauss_mask = gauss2(B);

filtered_gauss_custom = my_filter2D(im, my_gauss_mask);

figure;
subplot(1, 2, 1);
imshow(uint8(im));
title('Original Image');

subplot(1, 2, 2);
imshow(uint8(filtered_gauss_custom));
title(['Custom 2D Gauss Filter (', num2str(B), 'x', num2str(B), ')']);


function mask = gauss2(B)
    sigma = 1.0; 
    
    half_size = floor(B / 2);
    [X, Y] = meshgrid(-half_size:half_size, -half_size:half_size);
    
    % 2D Gaussian formula
    mask = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
    
    % Normalize
    mask = mask / sum(mask(:));
end

function out_img = my_filter2D(im, mask)
    [rows, cols] = size(im);
    [m_rows, m_cols] = size(mask);
    
    % calculate padding based on mask size to avoid border issues
    pad_r = floor(m_rows / 2);
    pad_c = floor(m_cols / 2);
    
    % copy original 
    out_img = im; 
    
    for i = (1 + pad_r) : (rows - pad_r)
        for j = (1 + pad_c) : (cols - pad_c)
            
            neighborhood = double(im(i-pad_r : i+pad_r, j-pad_c : j+pad_c));
            
            out_img(i, j) = sum(sum(neighborhood .* mask));
            
        end
    end
end