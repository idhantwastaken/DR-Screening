function [enhancedImg, greenChannel] = img_enhancement(rawImg, targetSize)
    % Downscales, extracts green channel, and applies CLAHE.
    
    if nargin < 2, targetSize = [512, 512]; end
    
    % 1. Downscaling to minimize RAM consumption
    resizedImg = imresize(rawImg, targetSize);
    
    % 2. Green channel extraction
    greenChannel = resizedImg(:, :, 2);
    
    % 3. Contrast Limited Adaptive Histogram Equalization (CLAHE)
    claheImg = adapthistelem(greenChannel, ...
        'ClipLimit', 0.02, ...
        'Distribution', 'rayleigh', ...
        'NumTiles', [8 8]);
    
    % 4. Denoise using multi-threaded 3x3 median filtering
    enhancedImg = medfilt2(claheImg, [3 3]);
end