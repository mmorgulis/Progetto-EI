function features = compute_all_features(im_rgb, finestra)
    im_gray = im2double(rgb2gray(im_rgb));
    
    var_local = compute_local_var(im_gray, finestra);
    hue = compute_hue(im_rgb);
    sat = compute_sat(im_rgb);
    entropy_local = entropyfilt(im_gray, true(finestra));
    [gabor, ~] = imgaborfilt(im_gray, 4, 90); % slide


    %features = cat(3, normalize_feature(var_local), ...
    %                 normalize_feature(hue_local), ...
    %                 normalize_feature(sat_local), ...
    %                 normalize_feature(entropy_local), ...
    %                 normalize_feature(gabor));

    features = cat(3, var_local, hue, sat, entropy_local, gabor);

end