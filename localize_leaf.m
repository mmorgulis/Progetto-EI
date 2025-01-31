function img_bin = localize_leaf(image)
    load("data.mat");
    
    % Preprocess
    %[~, ~, canali] = size(image);
    image = imresize(image, 0.25);
    image = medfilt3(image, [5 5 5]);
    
    features = compute_all_features(image, finestra);
    [r, c, num_features] = size(features);
    features_reshaped = reshape(features, r * c, num_features);
    
    % Predizione kNN per l'immagine corrente
    pred_labels = predict(C, features_reshaped);
    
    pred_image = reshape(pred_labels, [r, c]);
    
    % Post Processing
    %pred_image = medfilt2(pred_image, [9 9]);
    %pred_image = imfill(pred_image, "holes"); % slide

    img_bin = pred_image;

end

