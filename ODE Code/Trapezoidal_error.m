% Trapezoidal_error.m
% Trapezoidal rule for the ODE model
% u'(x)=x^2+x-u, x in [0,1] 
% Initial condition: u(0)=0 ;
% Exact solution: u(x)=-exp(-x)+x^2-x+1.
clear all;  clf
Nvec=[10 50 100 500 1000];     % Number of divisions
Error=[];
for k=1:length(Nvec)
    N=Nvec(k);
    h=1/N;
x=0:h:1;                       % interval division
N=length(x)-1;
u(1)=0;                        % initial value
for n=1:N
    u(n+1)=(2-h)/(2+h).*u(n)+h/(2+h).*(x(n)^2+x(n)+x(n+1)^2+x(n+1));
end
    ue=-exp(-x)+x.^2-x+1;      % exact solution
    error=max(abs(u-ue));
    Error=[Error,error];
end
plot(log10(Nvec),log10(Error),'ro-','MarkerFaceColor','w','LineWidth',1)
%loglog(Nvec,Error,'ro-','LineWidth',1.5)
hold on
%loglog(Nvec, Nvec.^(-2), '--')
plot(log10(Nvec), log10(Nvec.^(-2)), '--')
grid on
%title('Convergence of Trapezoidal rule','fontsize',12)
set(gca,'fontsize',12)
xlabel('log_{10}N','fontsize',14), ylabel('log_{10}Error','fontsize',14)

% add annotation of slope
ax = [0.63 0.58];
ay = [0.70 0.65];
annotation('textarrow',ax,ay,'String','slope = -2 ','fontsize',14)

% computating convergence order
for n=1:length(Nvec)-1
    order(n)=-log(Error(n)/Error(n+1))/(log(Nvec(n)/Nvec(n+1)));
end
Error
order

% print -dpng -r600  Trapezoidal_error.png
