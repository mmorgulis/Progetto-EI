clear;
close all;

im = imread("Test\oleandro_test.jpg");
foglia_rgb = imresize(im, 0.25);

    % Colore medio
    col_medio = mean(mean(mean(foglia_rgb)));
    
    % Saturazione media
    foglia_hsv = rgb2hsv(foglia_rgb);
    sat_media = mean(mean(foglia_hsv(:,:,1)));
    
    % gabor
    wavelength = 4;
    orientation = 0;
    g = gabor(wavelength, orientation);
    gaborMag = imgaborfilt(im2gray(foglia_rgb), g);
    gaborFeature = mean(gaborMag(:));
    
    % entropia
    entropy = entropyfilt(im2gray(foglia_rgb));
    entropyFeature = mean(entropy(:));
    
    % glcm
    glcm = graycomatrix(im2gray(foglia_rgb), 'Offset', [0 1]);
    s = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});    
    contr = s.Contrast;
    corr = s.Correlation;
    en = s.Energy;
    h = s.Homogeneity;
    
    % canny
    foglia_vett = medfilt2(im2gray(foglia_rgb));
    edges_c = edge(im2gray(foglia_vett), "canny");
    media_edge_c = mean(mean(edges_c));
    
   % lbp - estrazione e riduzione a 3 features
    lbp = extractLBPFeatures(im2gray(foglia_rgb), 'CellSize', [128 128], 'NumNeighbors', 4);
    texture_lbp = [mean(lbp) std(lbp) max(lbp)];  % 3 caratteristiche statistiche
    

    ValVector = [col_medio sat_media gaborFeature entropyFeature ...
        contr corr en h media_edge_c texture_lbp];



