function opening = my_opening(img, filter)
% Apply opening of binary image
% img     : binary image
% filter  : filter for opening
% opening : result of opening
[x, y] = size(img);
[filter_x, filter_y] = size(filter);
pad_x = floor(filter_x/2);
pad_y = floor(filter_y/2);
erosion = zeros(row, col);

% Apply Erosion
for i = 1+pad_x : x-pad_x
    for j = 1+pad_y : y-pad_y
        check = 0;
        for m = 1 : filter_x
            for n = 1 : filter_y
                if filter(m, n) == img(i - pad_x + m - 1, j - pad_y + n - 1)
                    check = check + 1;
                end
            end
        end
        if check == filter_x * filter_y
            erosion(i, j) = 1;
        end
    end
end

% Apply Opening
pad_img = zeros(x+2*pad_x, y+2*pad_y);
pad_img(1 + pad_x : x + pad_x, 1 + pad_y : y+pad_y) = erosion;
opening_img = pad_img;

for i = -pad_x : pad_x
    for j = -pad_y : pad_y
        if filter(i + pad_x+1, j + pad_y+1) == 1
            pad_img(1+pad_x + i : x+pad_x + i, 1+pad_y + j: y+pad_y + j) = img;
            opening_img = opening_img | pad_img;
        end
    end
end

opening = opening_img(1 + pad_x : row + pad_x, 1 + pad_y : col+pad_y);
end