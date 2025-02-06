function [ValVector] = compute_leaf_val(foglia_rgb)
    % Colore medio
    col_medio = mean(mean(mean(foglia_rgb)));
    
    % Sature media
    foglia_hsv = rgb2hsv(foglia_rgb);
    sat_media = mean(foglia_hsv(:,:,1));

    wavelength = 4;
    orientation = 0;
    g = gabor(wavelength, orientation);
    gaborMag = imgaborfilt(im2gray(foglia_rgb), g);
    gaborFeature = mean(gaborMag(:));

    entropy = entropyfilt(im2gray(foglia_rgb));
    entropyFeature = mean(entropy(:));

    glcm = graycomatrix(im2gray(foglia_rgb), 'Offset', [0 1]);
    s = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
    contr = s.Contrast;
    corr = s.Correlation;
    en = s.Energy;
    h = s.Homogeneity;

    ValVector = [col_medio sat_media gaborFeature entropyFeature ...
        contr corr en h];

end

