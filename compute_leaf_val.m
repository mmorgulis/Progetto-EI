function [ValVector] = compute_leaf_val(foglia_rgb)
    % Converti in HSV e gray una volta sola
    foglia_hsv = rgb2hsv(foglia_rgb);
    gray_img = im2gray(foglia_rgb);
    
    % Media di Hue e Saturation 
    h_mean = mean(foglia_hsv(:,:,1), 'all', 'omitnan');
    s_mean = mean(foglia_hsv(:,:,2), 'all', 'omitnan');
    
    % Rapporto tra canali verde/rosso 
    gr_ratio = mean(double(foglia_rgb(:,:,2)), 'all') / ...
               mean(double(foglia_rgb(:,:,1)), 'all');
    
    % Gabor con orientazioni principali per texture
    gaborFeatures = [];
    wavelength = 8;  % Una scala più grande per catturare pattern globali
    orientations = [0 90];  % Solo orientazioni principali
    for theta = orientations
        g = gabor(wavelength, theta);
        gaborMag = imgaborfilt(gray_img, g);
        % Prendi solo statistiche robuste
        gaborFeatures = [gaborFeatures, median(gaborMag(:))];
    end
    
    % GLCM con statistiche principali
    glcm = graycomatrix(gray_img, 'Offset', [0 1; -1 0]);  % Solo orizzontale e verticale
    stats = graycoprops(glcm, {'Contrast', 'Correlation'});
    % Media delle direzioni per robustezza
    contrast = mean([stats.Contrast]);
    correlation = mean([stats.Correlation]);

    % LBP con parametri ottimizzati per foglie
    lbp = extractLBPFeatures(gray_img, 'CellSize', [64 64], ...  % Celle più grandi
                            'NumNeighbors', 8, 'Radius', 1);
    % Prendi solo i momenti principali
    lbp_mean = mean(lbp);
    lbp_std = std(lbp);
    
    % Entropia globale (misura della complessità della texture)
    entropy_val = entropy(gray_img);
    
    % Deviazione standard locale (variazioni locali)
    local_std = std2(entropyfilt(gray_img));
    
    % Concatenazione delle features 
    ValVector = [h_mean, s_mean, gr_ratio, ...        % 3 features di colore
                gaborFeatures, ...                     % 2 features di orientazione
                contrast, correlation, ...             % 2 features GLCM
                lbp_mean, lbp_std, ...                % 2 features LBP
                entropy_val, local_std];              % 2 features di omogeneità
    
end