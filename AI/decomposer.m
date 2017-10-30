function [digit1, digit2, digit3 digit4, digit5]=decomposer
% load MNIST datasets
load MNist0-4.mat;
load MNist5-9.mat;
load input_images.mat;
load numbers.mat;

dimensions=size(input_images);
shapednumbers=zeros(dimensions(1,1)/28,28*dimensions(1,2));
images=input_images';
digit1=zeros(dimensions(1,1)/28,784);
digit2=zeros(dimensions(1,1)/28,784);
digit3=zeros(dimensions(1,1)/28,784);
digit4=zeros(dimensions(1,1)/28,784);
digit5=zeros(dimensions(1,1)/28,784);

for i=1:dimensions(1,1)/28;
    
    for j=1:5
    shapednumbers(i,1+(j-1)*784:j*784)=reshape(images(1+(j-1)*28:j*28,1+(i-1)*28:i*28),1,784);
    end
    digit1(i,:)=shapednumbers(i,1:784);
    digit2(i,:)=shapednumbers(i,1+784:2*784);
    digit3(i,:)=shapednumbers(i,1+(2*784):3*784);
    digit4(i,:)=shapednumbers(i,1+(3*784):4*784);
    digit5(i,:)=shapednumbers(i,1+(4*784):5*784);

end
