function [labels] = read_tr()
    f=fopen('labels.list');
    l = textscan(f,'%s');
    labels = l{:};
    fclose(f);
end

