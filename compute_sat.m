function img = compute_sat(im_rgb)

    % Calcolo la media del colore nell'intorno
    im_hsv = rgb2hsv(im_rgb);
    
    % Crea un filtro di media normalizzato
    %media = fspecial('average', finestra);    
    %media_sat = imfilter(im_hsv(:,:,2), media, 'same');
    
    img = im_hsv(:,:,2);

end

