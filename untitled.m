%function ShapeDescriptor = compute_shape(im)
    clear;
    close all;
    im = imread("Test\prezzemolo_test.jpg");
    im = imresize(im, 0.25);
    leaf = localize_leaf(im);
    %figure, imshow(leaf);
    
    labels = bwlabel(leaf);
    area = regionprops(labels, 'Area');
    filter = find([area.Area] >= 100);
    labels_filtered = ismember(labels, filter);
    labels_final = bwlabel(labels_filtered);
    num_comp_conn = max(max(labels_final));
    %figure, imagesc(labels_final), axis image, colorbar;


    for i = 1:1
        foglia_bin = labels_final == i;
        foglia_bin_3d = repmat(foglia_bin, [1 1 3]);
        foglia_rgb = im .* uint8(foglia_bin_3d);
        %figure, imshow(foglia_rgb);
        
        %% CODICE FUNZIONE
        im_gray = rgb2gray(foglia_rgb);
        im_bin = im_gray > 0; % lo sfondo è nero
        stats = regionprops(im_bin, 'MajorAxisLength', 'MinorAxisLength', ...
            'Orientation', 'Centroid', 'Area', 'BoundingBox', 'Perimeter', 'Solidity');
        area = stats.Area;
        perimetro = stats.Perimeter;
        bounding_box = stats.BoundingBox;
        a_b_b = bounding_box(3) * bounding_box(4);
        lato_maggiore = stats.MajorAxisLength;
        lato_minore = stats.MinorAxisLength;
        angolo = stats.Orientation;
        centro = stats.Centroid;
        diametro = mean([lato_maggiore lato_minore], 2);
        raggio = diametro/2;

        ratio = lato_minore / lato_maggiore;
        eccentricita = sqrt(1 - (ratio * ratio));
        circolarita = (4 * pi * area) / (perimetro * perimetro);
        rettangolarita = (lato_maggiore * lato_minore) / area;
        g = perimetro / lato_maggiore;
        s = perimetro / (lato_minore + lato_maggiore);
        ab = area / a_b_b;
        solid = stats.Solidity;
        ShapeDescriptor = [ratio eccentricita circolarita ...
             rettangolarita g s ab solid];
        
        figure, imshow(im_bin);
        hold on
            plot(centro(:,1), centro(:,2), 'b*')
        hold off
        
        % im ha la scritta con la classe di appartenenza
        
    end
    

