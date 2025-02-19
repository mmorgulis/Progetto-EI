function img = compute_sat(im_rgb)
    % Converto in hsv
    im_hsv = rgb2hsv(im_rgb);
    
    img = im_hsv(:,:,2);

end

