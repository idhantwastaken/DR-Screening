function [isPass, score] = quality_check(img, blurThreshold)
    % Validates image sharpness via Laplacian variance.
    
    if nargin < 2, blurThreshold = 100.0; end % Baseline sharpness limit
    
    % Convert RGB matrix to grayscale for variance calculation
    if size(img, 3) == 3
        grayImg = rgb2gray(img);
    else
        grayImg = img;
    end
    
    % Apply 3x3 Laplacian filter and compute matrix variance
    lapKernel = fspecial('laplacian', 0);
    filteredImg = imfilter(double(grayImg), lapKernel, 'replicate');
    score = var(filteredImg(:));
    
    isPass = (score >= blurThreshold);
end