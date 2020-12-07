% BackEuler_error.m
% Backward Euler Method for Nonlinear ODE:
% u'(x)=u-2x/u in [0,1]
% Initial condition: u(0)=1;
% Exact solution: u=sqrt(2*x+1)
clear all
Nvec=[10 20 100 200 1000];
%hv=[0.1 0.05 0.01 0.005 0.001];
Error=[];
for k=1:length(Nvec)
N=Nvec(k);
h=1/N;
x=0:h:1;
N=length(x)-1;
u(1)=1;
NI(1,N)=0;  % Record the number of iterations
for n=1:N
    % Newton iteration
    Xn=u(n);
    Xp=Xn;
    Xprev=0;
    while abs(Xp-Xprev) > eps*abs(Xp)
        Xprev=Xp;
        Xp=Xp-(Xp-h*Xp+2*h*x(n+1)/Xp-u(n))./(1-h-2*h*x(n+1)/(Xp^2));
        NI(n)=NI(n)+1;
    end
    u(n+1)=Xp;
end
ue=sqrt(2*x+1);
error=max(abs(u-ue));
Error=[Error,error];
end
plot(log10(Nvec),log10(Error),'ro-','MarkerFaceColor','w','LineWidth',1)
hold on
plot(log10(Nvec), log10(Nvec.^(-1)), '--')
grid on
%title('Rate of Convergence','fontsize',12)
set(gca,'fontsize',14)
xlabel('log_{10}N','fontsize',14),ylabel('log_{10}Error','fontsize',14)

% add annotation of slope
ax = [0.57 0.53];
ay = [0.68 0.63];
annotation('textarrow',ax,ay,'String','slope = -1 ','fontsize',14)

% computating convergence order
for n=1:length(Nvec)-1     % computating convergence order
    order(n)=-log(Error(n)/Error(n+1))/(log(Nvec(n)/Nvec(n+1)));
end
Error
order

% print -dpng -r600  BackEuler_error.png
