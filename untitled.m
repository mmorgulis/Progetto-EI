%function ShapeDescriptor = compute_shape(im)
    clear;
    close all;
    % load("locator.mat");
    im = imread("Training\Bianco\quercia_training.jpg");
    im = imresize(im, 0.25);
    leaf = localize_leaf(im);
    % leaf = localize_leaf(im);
    %figure, imshow(leaf);

    col_medio = mean(im, 3);
    sat = compute_sat(im);

    im_gray = im2gray(im);
    finestra = 5;
    
    varianza_locale = compute_local_var(im_gray, finestra);
    [gabor, ~] = imgaborfilt(im_gray, 4, 90);
    entropy_local = entropyfilt(im_gray);
    
    figure, imagesc(col_medio), axis image, colorbar;
    figure, imshow(sat);
    figure, imshow(varianza_locale), colorbar;
    figure, imshow(gabor, []), colorbar;
    figure, imshow(entropy_local, []), colorbar;
    
    % % lbp - estrazione e riduzione a 3 features
    % lbp = extractLBPFeatures(im2gray(im), 'CellSize', [128 128], 'NumNeighbors', 4);
    % texture_lbp = [mean(lbp) std(lbp) max(lbp)];  % 3 caratteristiche statistiche
    % 
    % edges_c = edge(im2gray(im), "canny");
    % media_edge_c = mean(mean(edges_c));
    % edges_s = edge(im2gray(im), "sobel");
    % media_edge_s = mean(mean(edges_s));
    % figure, imshow(edges_c);
    % figure, imshow(edges_s);
    % 
    % wavelength = 4;
    % orientation = 0;
    % g = gabor(wavelength, orientation);
    % gaborMag = imgaborfilt(im2gray(im), g);
    % gaborFeature = mean(gaborMag(:));
    % 
    % glcm = graycomatrix(im2gray(im), 'Offset', [0 1]);
    % s = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
    % contr = s.Contrast;
    % corr = s.Correlation;
    % en = s.Energy;
    % h = s.Homogeneity;
    % 
    % %lbpFeatures = extractLBPFeatures(im2gray(im), 'CellSize', [32 32]);
    % 
    % col_m = mean(mean(mean(im)));
    % im_hsv = rgb2hsv(im);
    % sat_media = mean(mean(im_hsv(:,:,2)));
    % 
    % labels = bwlabel(leaf);
    % area = regionprops(labels, 'Area');
    % filter = find([area.Area] >= 400);
    % labels_filtered = ismember(labels, filter);
    % labels_final = bwlabel(labels_filtered);
    % num_comp_conn = max(max(labels_final));
    % % figure, imagesc(labels_final), axis image, colorbar;
    % %figure, imagesc(labels_final == 1), axis image, colorbar;
    % 
    % 
    % for i = 1:1
    %     foglia_bin = labels_final == i;
    %     foglia_bin_3d = repmat(foglia_bin, [1 1 3]);
    %     foglia_rgb = im .* uint8(foglia_bin_3d);
    %     %figure, imshow(foglia_rgb);
    % 
    %     %% CODICE FUNZIONE
    %     im_gray = rgb2gray(foglia_rgb);
    %     im_bin = im_gray > 0; % lo sfondo è nero
    %     stats = regionprops(im_bin, 'MajorAxisLength', 'MinorAxisLength', ...
    %         'Orientation', 'Centroid', 'Area', 'BoundingBox', 'Perimeter', 'Solidity');
    %     area = stats.Area;
    %     perimetro = stats.Perimeter;
    %     bounding_box = stats.BoundingBox;
    %     a_b_b = bounding_box(3) * bounding_box(4);
    %     lato_maggiore = stats.MajorAxisLength;
    %     lato_minore = stats.MinorAxisLength;
    %     angolo = stats.Orientation;
    %     centro = stats.Centroid;
    %     diametro = mean([lato_maggiore lato_minore], 2);
    %     raggio = diametro/2;
    % 
    %     ratio = lato_minore / lato_maggiore;
    %     eccentricita = sqrt(1 - (ratio * ratio));
    %     circolarita = (4 * pi * area) / (perimetro * perimetro);
    %     rettangolarita = (lato_maggiore * lato_minore) / area;
    %     g = perimetro / lato_maggiore;
    %     s = perimetro / (lato_minore + lato_maggiore);
    %     ab = area / a_b_b;
    %     solid = stats.Solidity;
    %     ShapeDescriptor = [ratio eccentricita circolarita ...
    %          rettangolarita g s ab solid];
    % 
    %     % figure, imshow(im_bin);
    %     % hold on
    %     %     plot(centro(:,1), centro(:,2), 'b*')
    %     % hold off
    % 
    %     % im ha la scritta con la classe di appartenenza
    % 
    % end
    

