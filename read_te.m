function [labels] = read_te()
    f=fopen("test_label.list");
    l = textscan(f,'%s');
    labels = l{:};
    fclose(f);
end
