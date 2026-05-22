%Subject: Image Processing & Recognition

% Ece Nur Koylan
%Exercises part I-1

%Task 1) Load and Display Image
img = imread('image.png'); 
figure, imshow(img);
title('Original Image');

%Task 2) Image Properties
info = imfinfo('image.png');

%imtool(img);

Width = info.Width
Height = info.Height
BitDepth = info.BitDepth
ColorType = info.ColorType

%Task 3) Save as BMP and JPG
imwrite(img, 'bmpImg.bmp');
imwrite(img, 'jpgImg.jpg');

%Task 4) Resize Image
img200 = imresize(img, 2.0);
img75 = imresize(img, 0.75);

%figure, imshow(img200), title('img200');
%figure, imshow(img75), title('img75');


%Task 5) Rotate and Flip
rotateRight = imrotate(img, -90);
rotate180 = imrotate(img, 180);
flip_img = fliplr(img);

%figure, imshow(rotateRight), title('Rotate Right');
%figure, imshow(rotate180), title('Rotate 180');
%figure, imshow(flip_img), title('Flip Horizontal');

%Task 6) Copy Center Part to Another Image
[rows, cols, ~] = size(img);
center_y = round(rows/2);
center_x = round(cols/2);
patch = img(center_y-50 : center_y+50, center_x-50 : center_x+50, 1:3);
another_image = imread('Tr.jpg'); 
another_image(1:101, 1:101, 1:3) = patch;

%figure; imshow(another_image); title('Pasted Central Part');

%Task 7) Invert Red Channel
img_red = img;
img_red(:,:,1) = 255 - img_red(:,:,1);

%figure, imshow(img_red), title('Red Inverted');

%Task 8) Exchange Blue and Green Channels
img_change = img;
temp = img_change(:,:,2); 
img_change(:,:,2) = img_change(:,:,3);
img_change(:,:,3) = temp;

%figure, imshow(img_change), title('Blue-Green Exchanged');

%Task 9) Negative and Grayscale
negative = 255 - img;
gray = rgb2gray(negative);

%figure, imshow(negative), title('Negative');
%figure, imshow(gray), title('Grayscale');

%Task 10) Apply Colormaps
%figure, imshow(gray), colormap(summer), colorbar, title('Summer');
%figure, imshow(gray), colormap(hot), colorbar, title('Hot');
%figure, imshow(gray), colormap(parula), colorbar, title('Parula');

%Task 11) Binary Images 
binary10 = imbinarize(gray, 0.1);
binary80 = imbinarize(gray, 0.8);

%figure, imshow(binary10), title('Binary 10%');
%figure, imshow(binary80), title('Binary 80%');

%Task 12) Add Gaussian Noise (Left Half)
img_noise = img;
left_half = img(:, 1:center_x, :);
noise_left = imnoise(left_half, 'gaussian');
img_noise(:, 1:center_x, :) = noise_left;

%figure; imshow(img_noise); title('Gaussian Noise on Left Half');

%Task 13) Histogram
%figure, imhist(gray, 2), title('Histogram 2 bins');
%figure, imhist(gray, 100), title('Histogram 100 bins');