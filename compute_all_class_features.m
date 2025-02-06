function features = compute_all_class_features(foglia_rgb)
    shape = compute_shape(foglia_rgb);
    val = compute_leaf_val(foglia_rgb); 

    % Concateno orizzontalmente i vettori
    features = [shape(:)', val(:)']; 
end

