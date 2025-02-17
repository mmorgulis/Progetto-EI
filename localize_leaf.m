function img_bin = localize_leaf(image)
    load("locator.mat");
    
    features = compute_all_loc_features(image, finestra);
    [r, c, num_features] = size(features);
    features_reshaped = reshape(features, r * c, num_features);
    
    % Predizione kNN per l'immagine corrente
    pred_labels = predict(C, features_reshaped);
    
    pred_image = reshape(pred_labels, [r, c]);

    img_bin = pred_image;

end

