% image �� ���� ��
img = imread('test.png');
img = rgb2gray(img);
% my_bilinear �� ���� �̹����� ũ�� ����
re = my_bilinear(img, 1000, 1000);

% �̹��� Ȯ��
figure
subplot(1, 1000, 1:470);
imshow(img);
title('base image');

subplot(1, 1000, 530:1000);
imshow(re);
title('resized image');