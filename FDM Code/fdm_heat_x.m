% fdm_heat_x.m
% forward difference scheme for heat equation
% the error respect to step size of x
% u_t=u_{xx}, (x,t) in (0,1)x(0,1],
% u(x,0)=exp(x), x in [0,1],
% u(0,t)=exp(t), u(1,t)=exp(1+t), t in (0,1]
% exact solution: u(x,t)=exp(x+t)
clear all; close all;
a=1;
Mvec=[4:2:20];
N=1000;
tau=1/N;
t=[0:tau:1];
Error=[];
for k=1:length(Mvec)
    M=Mvec(k);
    h=1/M;
    r=a*tau/h^2;
    x=[0:h:1];
    % constructing the coefficient matrix
    e=r*ones(M-1,1);
    A=spdiags([e 1-2*e e],[-1 0 1],M-1,M-1);
    % setting initial and boundary conditions
    u=zeros(M+1,N+1);
    u(:,1)=exp(x);
    u(1,:)=exp(t);
    u(end,:)=exp(1+t);
    for n=1:N
        u(2:M,n+1)=A*u(2:M,n);
        u(2,n+1)=u(2,n+1)+r*u(1,n);
        u(M,n+1)=u(M,n+1)+r*u(end,n);
    end
    [T X]=meshgrid(t,x);
    ue=exp(X+T);
    error=max(max(abs(ue-u)))
    Error=[Error,error];
end
% plot the figure of error
plot(1./Mvec,Error,'ro-','MarkerFaceColor','w','LineWidth',1)
set(gca,'fontsize',12)
xlabel('h','fontsize', 14), ylabel('Error','fontsize',14),

% plot(log10(Mvec),log10(Error),'ro-','MarkerFaceColor','w','LineWidth',1)
% hold on
% plot(log10(Mvec), log10(Mvec.^(-2)), '--')
% grid on

% computating convergence order
% for i=1:length(Mvec)-1
%     order(i)=-log(Error(i)/Error(i+1))/(log(Mvec(i)/Mvec(i+1)));
% end
% Error
% order


% print -dpng -r600  fdm_heat_x.png
