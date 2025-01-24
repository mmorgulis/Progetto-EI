function img = compute_local_var(im_gray, finestra)
    % Calcolo varianza in una finestra specifica
    % con la formula Var(X)=E[X^2]−(E[X])^2

    % Crea un filtro di media normalizzato
    media = fspecial('average', finestra);
    % Calcola la media locale
    media_var_locale = imfilter(im_gray(:, :), media, 'same');
    % Calcola la media locale dei quadrati
    media_var_locale_sq = imfilter(im_gray(:, :).^2, media, 'same'); 
    % Calcola la varianza locale
    varianza_locale = media_var_locale_sq - media_var_locale.^2;
    
    img = varianza_locale;
end

