function au_new = HP(au, fs, fc)
c = (tan(pi*fc/fs)-1) / (tan(pi*fc/fs)+1);
x = 0;

au_new = zeros(size(au));

for n = 1:length(au)
    x_1 = -c * x+ au(n);
    au_new(n) = ((c^2-1)/2) * x + (1-c)/2 * au(n);
    x = x_1;    
end

