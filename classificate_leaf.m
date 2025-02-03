function image_with_class = classificate_leaf(image_tot, foglia)
    % FACCIO PREDICT E SCRIVO SU IMG
    %load(class.mat)

    % Per bounding box
    %stats = regionprops(labels_final, 'BoundingBox');
    %bbox = stats(i).BoundingBox;
    %x = floor(bbox(1));
    %y = floor(bbox(2));
    %width = ceil(bbox(3));
    %height = ceil(bbox(4));
    %foglia = im(y:y+height-1, x:x+width-1, :);
    %figure, imshow(foglia);
    
    
    image_with_class = image_tot;
end

