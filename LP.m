function au_new = LP(au, fs, fc)
c = (tan(pi*fc/fs)-1) / (tan(pi*fc/fs)+1);
x = 0;

au_new = zeors(size(au));

for n = 1:length(au)
    x_1 = -c * x+ au(n);
    au_new(n) = ((1-c^2)/2) * x + (1+c)/2 * au(n);
    x = x_1;   
end

