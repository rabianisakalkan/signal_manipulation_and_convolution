
%defining and plotting the picecewise defined signal
t = -12:0.01:12;
x = zeros(size(t));
x(-5<=t & t<=-1) = t(-5<=t & t<=-1) + 4;
x(-1<t & t<2) = 3;
x(2<=t & t<=5) = 7-2*t(2<=t & t<=5);
plot(t,x);
xlabel('time');
ylabel('amplitude');
ylim([-5, 5]);
title('piecewise defined signal x(t)');


% defining s1(t) = x(t-3)
t = -12:0.01:12;
s1 = zeros(size(t))
s1((-5 +3)<=t & t<=(-1+3)) = t((-5+3)<=t & t<=(-1 +3))+1; 
s1((-1+3)<t & t<(2+3)) = 3;
s1((2+3)<=t & t <=(5+3)) = 7-2*t((2+3) <=t & t<=(5+3)) + 6; 
%plotting %s1(t) = x(t-3)
subplot(2,1,1)
plot(t,s1)
xlabel('time');
ylabel('amplitude');
ylim([-5, 5]);
title('shifted signal s1(t)= x(t-3)');


% defining s2(t) = x(t+3)
s2=zeros(size(t))
s2((-5-3)<=t & t<=(-1-3))=t((-5-3)<=t & t<=(-1-3)) + 7;
s2((-1-3)<t & t<(2-3)) = 3;
s2((2-3)<=t & t<=(5-3)) = 7-2*t((2-3)<=t & t<=(5-3)) - 6;
%plotting s2(t)=x(t+3)
subplot(2,1,2);
plot(t,s2)
xlabel('time');
ylabel('amplitude');
ylim([-5, 5]);
title('shifted signal s2(t) = x(t+3)');


% defining the signal f1(t) = s1(-t)
t = -12:0.01:12;
s1 = zeros(size(t))
s1((-5 +3)<=t & t<=(-1+3)) = t((-5+3)<=t & t<=(-1 +3)) +1; 
s1((-1+3)<t & t<(2+3)) = 3;
s1((2+3)<=t & t <=(5+3)) = 7-2*t((2+3) <=t & t<=(5+3)) + 6; 
t_shifted_for_f1 = -t
f1 = interp1(t,s1,t_shifted_for_f1,'linear',0); %interp1 for shifting
%plotting f1(t)
subplot(3,1,1);
plot(t,f1);
xlabel('time');
ylabel('amplitude');
ylim([-5, 5]);
title('shifted and reflected signal f1(t) = s1(-t)');


% defining the signal f2(t) = s2(-t-1)
s2=zeros(size(t))
s2((-5-3)<=t & t<=(-1-3))=t((-5-3)<=t & t<=(-1-3)) + 7;
s2((-1-3)<t & t<(2-3)) = 3;
s2((2-3)<=t & t<=(5-3)) = 7-2*t((2-3)<=t & t<=(5-3)) - 6;
t_shifted_for_f2 = -t-1
f2 = interp1(t,s2,t_shifted_for_f2,'linear',0);
%plotting f2(t)
subplot(3,1,2);
plot(t,f2);
xlabel('time');
ylabel('amplitude');
ylim([-5, 5]);
title('shifted and reflected signal f2(t)=s2(-t-1)');


% defining the signal f3(t) = x(-t-2)
t = -12:0.01:12;
x = zeros(size(t));
x(-5<=t & t<=-1) = t(-5<=t & t<=-1) + 4;
x(-1<t & t<2) = 3;
x(2<=t & t<=5) = 7-2*t(2<=t & t<=5);
t_shifted_for_f3 = -t-2
f3 = interp1(t,x,t_shifted_for_f3,'linear',0);
%plotting f3(t)
subplot(3,1,3);
plot(t,f3)
xlabel('time');
ylabel('amplitude');
ylim([-5, 5]);
title('shifted and reflected signal f3(t)= x(-t-2)');


% defining m1(t)=x(-2t+2)
t = -12:0.01:12;
t_shifted_for_m1 = -2*t+2
m1 = interp1(t,x,t_shifted_for_m1,'linear',0);
subplot(2,1,1);
plot(t,m1);
xlabel('time');
ylabel('amplitude');
ylim([-5, 5]);
title('shifted and scaled signal m1(t)= x(-2t+2)');


% defining m2(t) = f2(0.5t+2)
t_shifted_for_m2 = 0.5*t + 2;
m2 = interp1(t, f2, t_shifted_for_m2, 'linear', 0);
subplot(2,1,2);
plot(t, m2)
xlabel('time');
ylabel('amplitude');
ylim([-5, 5]);
title('shifted and scaled signal m2(t)= f2(0.5t+2)');

%find a and b such that m1(a*t+b) = m2(t)
%to find alpha and beta

syms a real
syms b real

m1_fun = matlabFunction(m1);
m2_fun = matlabFunction(m2);
equation1 = m1_fun(a*t+b) == m2_fun(t);
equation2 = diff(subs(m1_fun(a*t+b))) == diff(subs(m2_fun(t)));
solution = solve([equation1,equation2],[a,b]);

alpha = double(solution.a);
beta = double(solution.b);


%--------------------------------------------------------------------------


