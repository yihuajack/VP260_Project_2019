V0=1;%potential difference
m=50;%The number of grid points
p=0.00001;%accuracy
n=0;%iteration number
A=zeros(m,m);
A(1,1:m)=V0;
A(m,1:m)=0;
A(2:m,1)=0;
A(2:m,m)=0;
A(2:m-1,2:m-1)=V0/2;
A(2:m/2,m/2)=V0;
A(2:m/2,m/2+1)=V0;
E1=zeros(m,m);E2=zeros(m,m);
tic
% figure(1);
% subplot(2,2,1);
% j=1:m;k=1:m;
% imagesc(A(j,k));
% colorbar;
% figure(2);
% subplot(2,2,1);
% contour(j,-k,A(j,k));
% colorbar;
while true
    for j=2:m-1
        for k=2:m-1
            if (k==m/2||k==m/2+1)&&2<=j&&j<=m/2
                continue
            end
            A(j,k)=(A(j+1,k)+A(j-1,k)+A(j,k+1)+A(j,k-1))/4;
        end
    end
    n=n+1;
    flag=true;
    for j=2:m-1
        for k=2:m-1
            if (k==m/2||k==m/2+1)&&2<=j&&j<=m/2
                continue
            end
            B=(A(j+1,k)+A(j-1,k)+A(j,k+1)+A(j,k-1))/4;
            if abs((B-A(j,k))/A(j,k))>p
                flag=false;
            end
        end
    end
    if flag==true
        break
    end
%     if n==214
%         figure(1);
%         subplot(2,2,2);
%         j=1:m;k=1:m;
%         imagesc(A(j,k));
%         colorbar;
%         figure(2);
%         subplot(2,2,2);
%         contour(j,-k,A(j,k));
%         colorbar;
%     end
%     if n==427
%         figure(1);
%         subplot(2,2,3);
%         j=1:m;k=1:m;
%         imagesc(A(j,k));
%         colorbar;
%         figure(2);
%         subplot(2,2,3);
%         contour(j,-k,A(j,k));
%         colorbar;
%     end
end
% figure(1);
% subplot(2,2,4);
% j=1:m;k=1:m;
% imagesc(A(j,k));
% colorbar;
% figure(2);
% subplot(2,2,4);
% contour(j,-k,A(j,k));
% colorbar;
for j=2:m-1
    for k=2:m-1
        if (k==m/2||k==m/2+1)&&2<=j&&j<=m/2
                continue
        end
        E1(j,k)=-(A(j,k+1)-A(j,k-1))/2;
        E2(j,k)=-(A(j-1,k)-A(j+1,k))/2;
    end
end
toc
%************density plot**********
figure(1);
j=1:m;k=1:m;
imagesc(A(j,k));
colorbar;
%************density plot**********
%************contour plot*************
% figure(2);
% contour(j,-k,A(j,k));
% colorbar;
%************contour plot*************
%***********electric field***********
% figure(3)
% j=1:m;k=1:m;
% quiver(k,-j,E1,E2);
%***********electric field***********