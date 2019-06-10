function closing = my_closing(img, filter)
% Calculate closing of binary image
% img     : binary image
% filter  : filter for closing
% closing : result of closing

[x, y] = size(img);
[filter_x, filter_y] = size(filter);
pad_x = floor(filter_x/2);
pad_y = floor(filter_y/2);
pad_img = zeros(row+2*pad_x, col+2*pad_y);
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

% Apply closing
dilation = bias_img(1 + pad_x : row + pad_x, 1 + pad_y : col+pad_y);
closing = zeros(x, y);

for i = 1+pad_x : x-pad_x
    for j = 1+pad_y : y-pad_y
        check = 0;
        for m = 1 : filter_x
            for n = 1 : filter_y
                if filter(m, n) == dilation(i - pad_x + m - 1, j - pad_y + n - 1)
                    check = check + 1;
                end
            end
        end
        if check == filter_x * filter_y
            closing(i, j) = 1;
        end
    end
end

end