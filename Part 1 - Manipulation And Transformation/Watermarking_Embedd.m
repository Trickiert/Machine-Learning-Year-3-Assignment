clear all;
clc;
Image = imread('peppers.tif');
watermark=[0 1 0 1 1 1 0 1]; % this is the watermark sequence to be embedded.

load key_file;
load watermark.mat;
%********************* DWT transform
[A1,H1,V1,D1] = dwt2(double(Image),'haar','mode','per');  % four sub-bands in the first decomposition
[A2,H2,V2,D2] = dwt2(double(A1),'haar','mode','per'); % second decomposition

weight = 0.3;

Quantization_step=30;
for i=1:8
    
    
    row=key(i,1); column=key(i,2);
    
    
       H2(row,column) = H2(row,column) + weight*w1(i) * H2(row,column); %Equations, Add to report
       V2(row,column) = V2(row,column) + weight*w2(i) * V2(row,column);
       D2(row,column) = D2(row,column) + weight*w3(i) * D2(row,column);

    c_A3=A2(row,column);
   
    Q_coefficient_A3=round(c_A3/Quantization_step);
    if watermark(i)==0, 
        if mod(Q_coefficient_A3,2)~=0, 
            Q_coefficient_A3=Q_coefficient_A3+1;
        end
    else 
        if mod(Q_coefficient_A3,2)==0, 
            Q_coefficient_A3=Q_coefficient_A3+1;
        end
    end
    reconstructed_coefficient_A2=Q_coefficient_A3*Quantization_step; 
    A2(row,column)=reconstructed_coefficient_A2;
end
    


Reconstructed_A2=idwt2(A2,H2,V2,D2,'haar','mode','per') ;
Reconstructed_picture=idwt2(Reconstructed_A2,H1,V1,D1,'haar','mode','per') ;
imshow(Image),title('Original');
figure,imshow(uint8(round(Reconstructed_picture))), title('image with watermark')

imwrite(uint8(round(Reconstructed_picture)),'wavelet_watermarked_image.tif');












