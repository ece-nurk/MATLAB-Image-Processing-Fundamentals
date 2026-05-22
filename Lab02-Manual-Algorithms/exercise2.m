% Subject: Image Processing & Data Recognition
% Student: Ece Nur Koylan
% Exercises part I-2

% Task 1 : 3x2 Matrix creating

img = uint8(zeros(3, 2, 3));
img(1,1,:) = [255, 0, 0];% (1,1) Red
img(1,2,:) = [0, 255, 0]; % (1,2) Green
img(2,1,:) = [255, 255, 255];% (2,1) White
img(2,2,:) = [0, 0, 0]; % (2,2) Black
img(3,1,:) = [255, 255, 0]; % (3,1) Yellow
img(3,2,:) = [128, 128, 128]; % (3,2) Gray

imshow(img); 

% Task 2 : Gray Scale

img = imread('butterfly.jpg');

[rows, cols, ~] = size(img);

gray_mean = uint8(zeros(rows, cols));
gray_weighted = uint8(zeros(rows, cols));

for i = 1:rows
    for j = 1:cols
        
        R = double(img(i,j,1));
        G = double(img(i,j,2));
        B = double(img(i,j,3));
        
        % 1) Arithmetic mean
        gray_mean(i,j) = uint8((R + G + B) / 3);
        
        % 2) Weighted method (PAL and NTSC television standards: 0.2989*R + 0.5870*G+0.1140*B)
        gray_weighted(i,j) = uint8(0.2989*R + 0.5870*G + 0.1140*B);
        
    end
end

figure;
subplot(1,3,1); imshow(img); title('Original');
subplot(1,3,2); imshow(gray_mean); title('Mean Gray');
subplot(1,3,3); imshow(gray_weighted); title('Weighted Gray');

% Task 3 : Histogram comparison

hist_manual = zeros(256,1);

for i = 1:rows
    for j = 1:cols
        
        value = double(gray_weighted(i,j)); 
        hist_manual(value + 1) = hist_manual(value + 1) + 1;
        
    end
end

hist_builtin = imhist(gray_weighted);

figure;

subplot(1,2,1);
bar(0:255, hist_manual);
title('Manual Histogram');

subplot(1,2,2);
bar(0:255, hist_builtin);
title('Built-in imhist()');

difference = sum(abs(hist_manual - hist_builtin));

disp(['Difference = ', num2str(difference)]);

% Task 4 : Histogram Streching

img = imread('overexposed.jpg');
[rows, cols, ~] = size(img);

gray = uint8(zeros(rows, cols));

for i = 1:rows
    for j = 1:cols
        
        R = double(img(i,j,1));
        G = double(img(i,j,2));
        B = double(img(i,j,3));
        
        gray(i,j) = uint8(0.2989*R + 0.5870*G + 0.1140*B);
        
    end
end

min_val = double(gray(1,1));
max_val = double(gray(1,1));

for i = 1:rows
    for j = 1:cols
        
        if gray(i,j) < min_val
            min_val = double(gray(i,j));
        end
        
        if gray(i,j) > max_val
            max_val = double(gray(i,j));
        end
        
    end
end

stretched = uint8(zeros(rows, cols));

for i = 1:rows
    for j = 1:cols
        
        stretched(i,j) = uint8( (double(gray(i,j)) - min_val) * 255 / (max_val - min_val) );
        
    end
end

figure;
subplot(1,2,1); imshow(gray); title('Original Gray');
subplot(1,2,2); imshow(stretched); title('Stretched');

% Task 5 : Histogram Equalization

[h, w] = size(gray);
N = h * w;

% 1. Histogram
hist = zeros(256,1);

for i = 1:h
    for j = 1:w
        hist(gray(i,j) + 1) = hist(gray(i,j) + 1) + 1;
    end
end

% 2. PDF
pdf = hist / N;

% 3. CDF
cdf = zeros(256,1);
cdf(1) = pdf(1);

for i = 2:256
    cdf(i) = cdf(i-1) + pdf(i);
end

% 4. Equalization
eq_img = uint8(zeros(h,w));

for i = 1:h
    for j = 1:w
        
        eq_img(i,j) = uint8(cdf(gray(i,j) + 1) * 255);
        
    end
end

% 5. Histogram of equalized image
hist_eq = zeros(256,1);

for i = 1:h
    for j = 1:w
        hist_eq(eq_img(i,j) + 1) = hist_eq(eq_img(i,j) + 1) + 1;
    end
end

figure;
subplot(2,2,1);
imshow(gray);
title('Original Grayscale');
subplot(2,2,2);
bar(hist);
title('Original Histogram');
subplot(2,2,3);
imshow(eq_img);
title('Equalized Image');
subplot(2,2,4);
bar(hist_eq);
title('Equalized Histogram');