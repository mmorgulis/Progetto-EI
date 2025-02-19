function features = compute_all_loc_features(im_rgb, finestra)
    im_gray = im2double(rgb2gray(im_rgb));
    
    % Estraggo features
    var_local = compute_local_var(im_gray, finestra);
    col = compute_col(im_rgb);
    sat = compute_sat(im_rgb);
    entropy_local = entropyfilt(im_gray);
    [gabor, ~] = imgaborfilt(im_gray, 4, 90); % slide
    
    % Concateno tutte le features
    features = cat(3, var_local, col, sat, entropy_local, gabor);

end