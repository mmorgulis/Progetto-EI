    function [ValVector] = compute_leaf_val(foglia_rgb)
    foglia_hsv = rgb2hsv(foglia_rgb);
    gray_img = im2gray(foglia_rgb);
    
    % Media di Hue (resistente a illuminazione variabile) e Saturation 
    h_mean = mean(foglia_hsv(:,:,1), 'all', 'omitnan'); 
    s_mean = mean(foglia_hsv(:,:,2), 'all', 'omitnan');
    
    % Rapporto tra canali verde/rosso 
    gr_ratio = mean(double(foglia_rgb(:,:,2)), 'all') / ...
               mean(double(foglia_rgb(:,:,1)), 'all');
    
    % Gabor con orientazioni principali per texture
    gaborFeatures = [];
    wavelength = 8; 
    orientations = [0 90];  % Solo orientazioni principali
    for theta = orientations
        g = gabor(wavelength, theta);
        gaborMag = imgaborfilt(gray_img, g);
        gaborFeatures = [gaborFeatures, median(gaborMag(:))];
    end
    
    % GLCM
    glcm = graycomatrix(gray_img, 'Offset', [0 1; -1 0]);  % Solo orizzontale e verticale
    stats = graycoprops(glcm, {'Contrast', 'Correlation'});
    % Media delle direzioni per robustezza
    contrast = mean([stats.Contrast]);
    correlation = mean([stats.Correlation]);

    % LBP
    lbp = extractLBPFeatures(gray_img, 'CellSize', [64 64], ...  
                            'NumNeighbors', 8, 'Radius', 1);
    % Prendo solo media
    lbp_mean = mean(lbp);
    
    % Entropia globale
    entropy_val = entropy(gray_img);
    
    % Deviazione standard locale
    local_std = std2(entropyfilt(gray_img));
    
    % Concatenazione delle features 
    ValVector = [h_mean, s_mean, gr_ratio, ...        % 3 features di colore
                gaborFeatures, ...                     % 2 features gabor
                contrast, correlation, ...             % 2 features GLCM
                lbp_mean, ...                           % 1 features LBP
                entropy_val, local_std];              % 2 features di omogeneità
    
end