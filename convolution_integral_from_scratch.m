% define x(t)
t = -15:0.1:30;
x = zeros(size(t));
x(t>=-5 & t<=-1) = t(t>=-5 & t<=-1) + 4;
x(t>-1 & t<2) = 3;
x(t>=2 & t<=5) = 7-2*t(t>=2 & t<= 5);

% define ha(t)
a_values = [8,2,0,-3];
for m = 1:length(a_values)
    a = a_values(m);
    ha = zeros(size(t));
    if a>=0
        ha(t>=0 & t<=a) = 1;
    else
        ha(t>=a & t<=0) = 1;
    end
    if a == 0
        ha(t == 0) = 1;
    end
    % convolution integral
    y = zeros(size(t));
    if a == 0
        y = x;
    else
        for i = 1:length(t)
            if a ~= 0
                product = x .* interp1(t, ha, t(i)-t, 'linear', 0);
            else
                product = x .* ha(t == t(i)); % because if a=0 means ha is an impulse function
            end
            y(i) = trapz(t, product);
        end
    end

    % plotting
   
    subplot(length(a_values),1,m);
    plot(t, y, 'b');
    xlabel('t');
    ylabel(sprintf('y(t) (a = %d)', a));
    title(sprintf('y(t) = x(t) * ha(t) (a = %d)', a));
    ylim([-5, 20]);
    xlim([-15, 15]);
    
end 