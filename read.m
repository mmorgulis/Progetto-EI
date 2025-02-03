function [labels] = read()
    f=fopen('labels.list');
    l = textscan(f,'%s');
    labels = l{:};
    fclose(f);
end

