V0=1;%potential difference
m=50;%The number of grid points
p=0.0001;%accuracy
n=0;%iteration number
A=zeros(m,m);
A(1,1:m)=0;%***************
A(m,1:m)=V0;%
A(2:m,1)=V0;%Initial condition
A(2:m,m)=V0;%
A(2:m-1,2:m-1)=V0/2;%*******
E1=zeros(m,m);E2=zeros(m,m);l=1:m;
tic
while true
    for j=2:m-1
        for k=2:m-1
            A(j,k)=(A(j+1,k)+A(j-1,k)+A(j,k+1)+A(j,k-1))/4;
        end
    end
    n=n+1;
    flag=true;
    for j=2:m-1
        for k=2:m-1
            B=(A(j+1,k)+A(j-1,k)+A(j,k+1)+A(j,k-1))/4;
            if abs((B-A(j,k))/A(j,k))>p
                flag=false;
            end
        end
    end
    if flag==true
        break
    end
    if mod(n,10)==1
        figure(1);
        j=1:m;k=1:m;
        imagesc([0 50],[0 50],A(j,k));
        colorbar;
        drawnow;
        x=ceil(n/10);
        im1(x)=getframe(1);
        figure(2);
        contour(l,-l,A(j,k));
        colorbar;
        drawnow;
        im2(x)=getframe(2);
    end
end
n=0;
for j=2:m-1
    for k=2:m-1
        E1(j,k)=-(A(j,k+1)-A(j,k-1))/2;
        E2(j,k)=-(A(j-1,k)-A(j+1,k))/2;
        n=n+1;
        if mod(n,10)==1
            figure(3);
            quiver(l,-l,E1,E2);
            drawnow;
            x=ceil(n/10);
            im3(x)=getframe(3);
        end
    end
end
toc
filename1='SystemB_Density_Sampling_One_Tenth.gif';
filename2='SystemB_Contour_Sampling_One_Tenth.gif';
filename3='SystemB_Vector_Sampling_One_Tenth.gif';
for idx=1:size(im1,2)
    [A1,map] = rgb2ind(frame2im(im1(idx)),256);
    if idx == 1
        imwrite(A1,map,filename1,'gif','LoopCount',Inf,'DelayTime',1e-1);
    else
        imwrite(A1,map,filename1,'gif','WriteMode','append','DelayTime',1e-1);
    end
end
for idx=1:size(im2,2)
    [A2,map] = rgb2ind(frame2im(im2(idx)),256);
    if idx == 1
        imwrite(A2,map,filename2,'gif','LoopCount',Inf,'DelayTime',1e-1);
    else
        imwrite(A2,map,filename2,'gif','WriteMode','append','DelayTime',1e-1);
    end
end
for idx=1:size(im3,2)
    [A3,map] = rgb2ind(frame2im(im3(idx)),256);
    if idx == 1
        imwrite(A3,map,filename3,'gif','LoopCount',Inf,'DelayTime',1e-1);
    else
        imwrite(A3,map,filename3,'gif','WriteMode','append','DelayTime',1e-1);
    end
end