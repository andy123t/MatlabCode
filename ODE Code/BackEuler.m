% BackEuler.m
% Backward Euler Method for Nonlinear ODE:
% u'(x)=u-2x/u in [0,1]
% Initial condition: u(0)=1;
% Exact solution: u=sqrt(2*x+1)
clear all
h=0.01;
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
ue=sqrt(2*x+1);    % exact solution
plot(x,ue,'b-',x,u,'r+','LineWidth',1)
legend('Exact ','Numerical','location','northwest')
% title('Backward Euler method','fontsize',12)
set(gca,'fontsize',12)
xlabel('t','fontsize',16), ylabel('u','fontsize',16,'Rotation',0)

% computing error
error=max(abs(u-ue))

% print -dpng -r600  BackEuler.png
