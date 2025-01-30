function norm_feature = normalize_feature(feature)
    norm_feature = (feature - min(feature(:))) / (max(feature(:)) - min(feature(:)) + eps);
end