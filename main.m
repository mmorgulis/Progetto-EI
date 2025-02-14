clear;
close all;

% Carico modelli
load("locator.mat");
load("classificator.mat");

% Carico immagine
im = imread("Test/trifoglio_test.jpg");
composizione_foglie = imresize(im, 0.25);

% Pre-processing per togliere rumore
composizione_foglie = medfilt3(composizione_foglie);

% Localizzo
leafs = localize_leaf(composizione_foglie);

% Seleziono solo le foglie
labels = bwlabel(leafs);
stats = regionprops(labels, 'Area', 'Centroid');
filter = find([stats.Area] >= 300);
labels_filtered = ismember(labels, filter);
labels_final = bwlabel(labels_filtered);
num_comp_conn = max(max(labels_final));
figure, imagesc(labels_final), axis image, colorbar;

% Ottengo i centroids per ogni foglia
stats_final = regionprops(labels_final, 'Centroid');

% Figura con foglie
figure;
imshow(composizione_foglie);
hold on;

% Classifico ogni foglia
for i = 1:num_comp_conn
    foglia_bin = labels_final == i;
    foglia_bin_3d = repmat(foglia_bin, [1 1 3]);
    foglia_rgb = composizione_foglie .* uint8(foglia_bin_3d);
    features_foglia = compute_all_class_features(foglia_rgb);
    features_foglia_reshaped = reshape(features_foglia, 1, []);
    [tipo_foglia, certezza] = predict(Cl, features_foglia_reshaped);

    % Valuto se è unknown
    % certezza è la probabilità assegnata per ogni classe, quindi ne
    % estraggo il max, certezza empirica scelta maggiore dell'50%
    if (max(certezza) < 0.5)
        tipo_foglia = 'unknown';
    end

    fprintf("%f \n", max(certezza));

    % Ottengo il centroide della foglia corrente
    centroid = stats_final(i).Centroid;
    
    % Scrivo il testo nell'immagine
    text(centroid(1), centroid(2), tipo_foglia, ...
        'Color', 'red', ...
        'FontSize', 12, ...
        'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center');
    
    %fprintf("%s \n", foglie(tipo_foglia));
end

hold off;

