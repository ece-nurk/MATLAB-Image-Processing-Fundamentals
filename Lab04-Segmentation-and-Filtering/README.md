# Lab 04 — Image Segmentation & Spatial Filtering

  MATLAB implementations of image segmentation and spatial filtering algorithms developed with manual pixel-level operations and custom convolution logic.

  The project focuses on understanding the mathematical foundations of thresholding, filtering, and neighborhood-based image processing.

## Implemented Features

### Adaptive Image Segmentation
Custom Otsu thresholding algorithm
Global threshold optimization
Between-class variance analysis
Comparison with MATLAB imbinarize

### Spatial Filtering

Implemented multiple linear and non-linear filters:

Mean filter
Gaussian filter
Median filter
Sobel operator
Prewitt operator
Roberts operator
Laplacian of Gaussian (LoG)

### Custom Filtering Algorithms

Manual 1D filtering
Manual 2D convolution
Gaussian kernel generation
Border handling and padding logic

## Core Algorithms

### Otsu Thresholding

The custom implementation maximizes between-class variance to determine the optimal threshold:

$$\sigma_{B}^2 = \omega_0 \omega_1 (\mu_0 - \mu_1)^2$$

The implementation was benchmarked against MATLAB’s built-in imbinarize() function.

### Gaussian Kernel Generation

Custom Gaussian masks were generated dynamically using:

$$G(x,y) = \frac{1}{2\pi\sigma^2} e^{-\frac{x^2+y^2}{2\sigma^2}}$$

The generated kernels were used within a custom 2D filtering engine.

## Technical Focus

This project emphasizes:

Manual convolution operations
Neighborhood-based filtering
Pixel-wise traversal using nested loops
Zero-padding and border handling
Noise reduction techniques
Gradient-based edge detection

Built-in high-level filtering functions were avoided where possible to better understand the underlying image processing mechanics.

## Files
exercise4.m      -> Main implementation file
img.jpg    -> Input image

## Environment

MATLAB
Image Processing Toolbox
(used only for benchmarking and comparison)

## Example Operations

### Segmentation

Original grayscale image
Custom Otsu binarization
MATLAB imbinarize() comparison

### Filtering

Mean smoothing
Gaussian smoothing
Sobel edge detection
LoG filtering
Roberts gradient estimation

Notes

The filtering algorithms were intentionally implemented using manual traversal and custom convolution logic for educational purposes.

Functions such as imfilter and imbinarize were primarily used for validation and benchmarking.

Developed during the Image Processing & Recognition course at Czestochowa University of Technology.
