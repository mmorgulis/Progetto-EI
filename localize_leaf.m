function img_bin = localize_leaf(image)
    load("data.mat");
    finestra = 7;
    [righe, colonne, ~] = size(image);
    
    % Preprocess
    image =  medfilt3(image, [5 5 5]);
    
    var = compute_local_var(im2double(rgb2gray(image)), finestra);
    sat = compute_local_saturation(image, finestra);
    col = compute_local_col(image, finestra);
    var = var(:);
    sat = sat(:);
    col = col(:);
    X = [var, sat, col];
    pred_image = predict(C, X);
    pred_image = reshape(pred_image, righe, colonne);

    % POST PROCESS
    pred_image = medfilt2(pred_image, [21 21]);
    %pred_image = imfill(pred_image, "holes");
    %pred_image = imclose(pred_image, strel("disk", 31));

    img_bin = pred_image;

end

