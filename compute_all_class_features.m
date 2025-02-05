function features = compute_all_class_features(foglia_rgb)
    % Calcolo le features CEDD (144 elementi)
    %cedd = compute_CEDD(foglia_rgb);
    
    % Calcolo le features shape (8 elementi)
    shape = compute_shape(foglia_rgb);
    
    % Concateno orizzontalmente i due vettori di features
    features = [shape(:)']; 
end

