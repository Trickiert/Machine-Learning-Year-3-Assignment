%Testing via Perceptron

clc;
test_image=imread('test_gender\male20.jpg');
feature_vector=get_featureVector(test_image); % function get_featureVector returns a column vector. 
Y_testing = sim(net,feature_vector);  % compute the output of the trained network
               
imshow(test_image),title('Original Image'),
if round(Y_testing)~=0,
    disp('female');
else
    disp('male');
end