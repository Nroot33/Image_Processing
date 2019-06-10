function dilation = my_dilation(img, filter)
% Apply dilation of binary image
% img      : binary image
% filter   : filter for dilation
% dilation : result of dilation 

[x, y] = size(img);
[filter_x, filter_y] = size(filter);
pad_x = floor(filter_x/2);
pad_y = floor(filter_y/2);
pad_img = zeros(x+2*pad_x, y+2*pad_y);
pad_img(1 + pad_x : x + pad_x, 1 + pad_y : y+pad_y) = img;
dilation_img = pad_img;

% Apply dilation
for i = -pad_x : pad_x
    for j = -pad_y : pad_y
        if filter(i + pad_x+1, j + pad_y+1) == 1
            pad_img(1+pad_x + i : x+pad_x + i, 1+pad_y + j: y+pad_y + j) = img;
            dilation_img = dilation_img | pad_img;
        end
    end
end

dilation = dilation_img(1 + pad_x : row + pad_x, 1 + pad_y : col+pad_y);
end