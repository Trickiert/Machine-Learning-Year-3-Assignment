function vector=get_featureVector(image)
% this function returns a column vector of 64 features.
% First convert the colour input image into a greayscale image
image= rgb2gray(image);
[m,n]=size(image);

min_dimension=min([m n]);
Z = zigzag4(min_dimension); % the DCT-trandformed image is converted into one-dimensional array in a zigzag order.
transformed_image=dct2(image);
vector=[]; % initialisation with empty vector
for i=3:66, % use 64 coefficients of the DCT-transformed image in ZigZag order.
    vector=[vector;transformed_image(Z(i,1),Z(i,2))];
end
end