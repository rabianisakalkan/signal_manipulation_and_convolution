% define x[n]
n = -10:30;
x = zeros(size(n));
x(n>=-5 & n<=-1) = n(n>=-5 & n<=-1)+4;
x(n>-1 & n<2) = 3;
x(n>=2 & n<=5) = 7-2*n(n>=2 & n<=5);

% define ha[n]
a_values = [8,2,0,-3]
for m = 1:length(a_values)
    a = a_values(m)
    if a == 0             %because in this case the signal is an impulse 
        ha = [1 zeros(1,length(n)-1)];
    else
        ha = zeros(1, length(n));
        if a > 0
            ha(n >= 0 & n <= a) = 1;
        else
            ha(n >= a & n <= 0) = 1;
        end
    end
    % convolution
    y = zeros(1, length(n));
    for i=1:length(n)
        for k=1:length(ha)
            if (i-k+1) >= 1 && (i-k+1) <= length(x) % not to be out of the boundaries
                 y(i) = y(i) + x(i-k+1)*ha(k);
            end
        end
    end
    % plotting
    subplot(length(a_values), 1, m);
    stem(n,y, 'filled');
    xlabel('n');
    ylabel(sprintf('y[n] (a = %d)', a));
    title(sprintf('y[n] = x[n] * ha[n] (a = %d)', a));
   
end
    


