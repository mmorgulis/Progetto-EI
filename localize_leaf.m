function img_bin = localize_leaf(image)
    load("data.mat");
    finestra = 7;
    [righe, colonne, ~] = size(image);
    var = compute_local_var(im2double(rgb2gray(image)), finestra);
    col = compute_local_col(image, finestra);
    var = var(:);
    col = col(:);
    X = [var, col];
    pred_image = predict(C, X);
    img_bin = reshape(pred_image, righe, colonne);
    %img_bin = imclose(pred_image, strel("disk", 3));

end

