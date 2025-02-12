function [norm_features] = normalize_feature(features)
    min_vals = min(features);
    max_vals = max(features);
    
    % Normalizza ogni colonna (feature)
    norm_features = (features - min_vals) ./ (max_vals - min_vals);
    
    % Gestisci eventuali NaN dovuti a divisione per zero
    norm_features(isnan(norm_features)) = 0;
end