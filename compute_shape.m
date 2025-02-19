function ShapeDescriptor = compute_shape(foglia_rgb)
        im_gray = rgb2gray(foglia_rgb);
        im_bin = im_gray > 0; % lo sfondo è nero
        
        % Estraggo statistiche
        stats = regionprops(im_bin, 'MajorAxisLength', 'MinorAxisLength', ...
             'Area', 'BoundingBox', 'Perimeter', 'Solidity');
        area = stats.Area;
        perimetro = stats.Perimeter;
        bounding_box = stats.BoundingBox;
        a_b_b = bounding_box(3) * bounding_box(4);
        lato_maggiore = stats.MajorAxisLength;
        lato_minore = stats.MinorAxisLength;
        
        % Calcolo invarianti
        ratio = lato_minore / lato_maggiore;
        eccentricita = sqrt(1 - (ratio * ratio));
        circolarita = (4 * pi * area) / (perimetro * perimetro);
        rettangolarita = (lato_maggiore * lato_minore) / area;
        g = perimetro / lato_maggiore;
        s = perimetro / (lato_minore + lato_maggiore);
        ab = area / a_b_b;
        solid = stats.Solidity;
        
        % Inserisco le features in un vettore
        ShapeDescriptor = [ratio eccentricita circolarita ...
             rettangolarita g s ab solid];
       
end
    

