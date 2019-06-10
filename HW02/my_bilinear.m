function re_img = my_bilinear(img, row, col)
[x, y] =size(img);
pad_img = zeros(x+2, y+2);
pad_img(2:x+1, 2:y+1) = img;

pad_img(1,1) = img(1,1);
pad_img(1,y+2) = img(1, y);
pad_img(x+2,1) = img(x, 1);
pad_img(x+2,y+2) =img(x, y);

pad_img(2:x+1, 1) = img(1:x, 1);
pad_img(2:x+1,y+2) = img(1:x, y);
pad_img(1,2:y+1) = img(x, 1:y);
pad_img(x+2,2:y+1) =img(x, 1:y);
pad_img = uint8(pad_img);

r_p = x/row;
c_p = y/col;

for i = 1:row
    for j = 1:col
        %f(i,j)
        x1 = floor(r_p*i)+1;
        y1 = floor(c_p*j)+1;
        
        x2 = floor(r_p*i)+1;
        y2 = ceil(c_p*j)+1;
        
        x3 = ceil(r_p*i)+1;
        y3 = ceil(c_p*j)+1;
        
        x4 = ceil(r_p*i)+1;
        y4 = floor(c_p*j)+1;
        
        s = (r_p*i) - floor(r_p*i);
        t = (c_p*j) - floor(c_p*j);
        
        re_img(i,j) = (1-s)*(1-t)*pad_img(x1,y1) + s*(1-t)*pad_img(x2,y2)+(1-s)*t*pad_img(x4,y4)+s*t*pad_img(x3,y3);
        
    end
end
re_img = uint8(re_img);  
end