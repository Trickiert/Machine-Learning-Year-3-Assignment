clear all;
clc;

Image=imread('wavelet_watermarked_image.tif');
% initialization of the watermark sequence to be extracted.
w_H2=[];
w_V2=[];
w_D2=[];

load key_file;
load watermark.mat;

[A1,H1,V1,D1] = dwt2(double(Image),'haar','mode','per');  % four sub-bands in the first decomposition
[A2,H2,V2,D2] = dwt2(double(A1),'haar','mode','per'); % second decomposition

Quantization_step=30;
weight = 0.3;
for i=1:8
    
     row=key(i,1); column=key(i,2);
      
       H2(row,column) = H2(row,column) + weight*w1(i) * H2(row,column);
       V2(row,column) = V2(row,column) + weight*w2(i) * V2(row,column);
       D2(row,column) = D2(row,column) + weight*w3(i) * D2(row,column);
   

    co_A3=A2(row,column);
 
    Q_coefficient_A3=round(co_A3/Quantization_step); 
    if mod(Q_coefficient_A3,2)==0, 
        w_H2=[w_H2,0];
    else
        w_H2=[w_H2,1]; 
    end
      if mod(Q_coefficient_A3,2)==0, 
        w_V2=[w_V2,0];
    else
        w_V2=[w_V2,1];
      end
      if mod(Q_coefficient_A3,2)==0,
        w_D2=[w_D2,0];
    else
        w_D2=[w_D2,1]; 
    end
    
end

disp('extracted watermark at A3 (H2): '),w_H2
disp('extracted watermark at A3 (D2): '),w_D2
disp('extracted watermark at A3 (V2): '),w_V2