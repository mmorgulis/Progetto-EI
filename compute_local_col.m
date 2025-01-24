function img = compute_local_col(im_rgb, finestra)

    % Calcolo la media del colore nell'intorno
    im_hsv = rgb2hsv(im_rgb);
    
    % Crea un filtro di media normalizzato
    media = fspecial('average', finestra);    
    media_hue = imfilter(im_hsv(:,:,1), media, 'same');
    
    img = media_hue;

end

