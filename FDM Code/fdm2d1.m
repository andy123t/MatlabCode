% fdm2d1.m
% finite difference method for 2D problem
% -d^2u/dx^2-d^2u/dy^2=f(x,y)
% f(x,y)=-2*pi^2*exp(pi*(x+y))*(sin(pi*x)*cos(pi*y)+cos(pi*x)*sin(pi*y))
% exact solution: ue=exp(pi*x+pi*y)*sin(pi*x)*sin(pi*y)
clear all;  clf
% generate coordinates on the grid
h=0.02;
x=[0:h:1]';
y=[0:h:1]';
N=length(x)-1;
M=length(y)-1;
[X,Y]=meshgrid(x,y);
X=X(2:M,2:N);
Y=Y(2:M,2:N);
% generate the matrix of RHS
f=-2*pi^2*exp(pi*X+pi*Y).*(sin(pi*X).*cos(pi*Y)+cos(pi*X).*sin(pi*Y));
% constructing the coefficient matrix
C=4/h^2*eye(N-1)-1/h^2*diag(ones(N-2,1),1)-1/h^2*diag(ones(N-2,1),-1);
D=-1/h^2*eye(N-1);
A=kron(eye(M-1),C)+kron(diag(ones(M-2,1),1)+diag(ones(M-2,1),-1),D);
% solving the linear system
f=f';
u=zeros(M+1,N+1);
u(2:M,2:N)=reshape(A\f(:),N-1,M-1)';
u(:,1)=0;
u(:,end)=0;
ue=zeros(M+1,N+1);
ue(2:M,2:N)=exp(pi*X+pi*Y).*sin(pi*X).*sin(pi*Y);
% compute maximum error
Error=max(max(abs(u-ue)))
mesh(x,y,u)
%title('Finite Difference Method','fontsize',14)
set(gca,'fontsize',12)
xlabel('x','fontsize', 16)
ylabel('y','fontsize',16)
zlabel('u','fontsize',16,'Rotation',0)

% print -dpng -r600  fdm2d1.png
