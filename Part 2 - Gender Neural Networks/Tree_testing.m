
clc;
test_image=imread('test_gender\male20.jpg');
feature_vector=get_featureVector(test_image)'; % function get_featureVector returns a column vector.

Y_testing = predict(tree,feature_vector);

imshow(test_image),title('Original Image'),
if round(Y_testing)~=0,
    disp('female');
else
    disp('male');
end