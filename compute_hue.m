function img = compute_hue(im_rgb)

    % Calcolo la media del colore nell'intorno
    im_hsv = rgb2hsv(im_rgb);
    
    % Crea un filtro di media normalizzato
    %media = fspecial('average', finestra);    
    %media_hue = imfilter(im_hsv(:,:,1), media, 'same');
    
    img = im_hsv(:,:,1);

end

