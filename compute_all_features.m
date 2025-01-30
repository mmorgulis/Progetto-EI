function features = compute_all_features(im_rgb, finestra)
    im_gray = im2double(rgb2gray(im_rgb));
    
    var_local = compute_local_var(im_gray, finestra);
    hue_local = compute_local_col(im_rgb, finestra);
    sat_local = compute_local_sat(im_rgb, finestra);
    entropy_local = entropyfilt(im_gray, true(finestra));
    [gabor, ~] = imgaborfilt(im_gray, 4, 90); % slide


    %features = cat(3, normalize_feature(var_local), ...
    %                 normalize_feature(hue_local), ...
    %                 normalize_feature(sat_local), ...
    %                 normalize_feature(entropy_local), ...
    %                 normalize_feature(gabor));

    features = cat(3, var_local, hue_local, sat_local, entropy_local, gabor);

end