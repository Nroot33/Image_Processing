function result = my_rgb2gray(image)
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);
result = 0.2989*R+0.5870*G+0.1140*B;

