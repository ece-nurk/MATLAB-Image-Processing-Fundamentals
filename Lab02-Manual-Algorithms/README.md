# Lab 02: Histogram Processing & Grayscale Transformation

  This laboratory study focuses on fundamental grayscale conversion techniques, histogram analysis, and contrast enhancement methods implemented manually in MATLAB.

The objective is to understand low-level image processing operations without relying entirely on built-in functions.

## Technical Concepts

### 1. RGB Matrix Construction

Manual creation of a 3x2 RGB image matrix
Pixel-level RGB value assignment
Basic understanding of image tensor structure

### 2. Grayscale Conversion

 Two different grayscale transformation methods were implemented:

Arithmetic Mean Method
Weighted Luminance Method (NTSC/PAL standard)

 The weighted method uses:

Gray=0.2989R+0.5870G+0.1140B

to better represent human brightness perception.

### 3. Manual Histogram Computation

Pixel intensity histogram calculated manually using nested loops
Comparison against MATLAB built-in imhist() implementation
Verification through absolute histogram difference analysis

### 4. Contrast Enhancement

Histogram Stretching

Dynamic range expansion using min-max normalization:

Inew = ((I - Imin) / (Imax - Imin)) * 255

Histogram Equalization

Implemented manually using:

Histogram generation
Probability Density Function (PDF)
Cumulative Distribution Function (CDF)
Intensity remapping

This process improves global image contrast distribution.

## Environment & Tools

MATLAB
Image Processing Toolbox

## MATLAB Functions Used

imread, imshow, imhist, subplot

## File Structure

exercise2.m → Main MATLAB implementation
butterfly.jpg → Grayscale conversion source image
overexposed.jpg → Contrast enhancement test image

Developed as part of the Image Processing & Recognition course at Czestochowa University of Technology.
