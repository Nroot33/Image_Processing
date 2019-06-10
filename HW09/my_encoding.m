function [zigzag,encode_x,encode_y] = my_encoding(img2)
% Compress Image using portion of JPEG
% img    : GrayScale Image
% zigzag : result of zigzag scanning

q_mtx =     [16 11 10 16 24 40 51 61; 
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56; 
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];
% 양자화를 위한 행렬
% Subtract 128
[x,y] = size(img2);
sub_img = zeros(x,y);
img2 = double(img2); 
sub_img = img2 - 128;

% 8*8사이즈와 안맞으면 미러패딩을 실시
p_x = 0;
p_y = 0;

if mod(x,8) ~= 0
  p_x = 8 - mod(x,8);
end
if mod(y,8) ~= 0
  p_y = 8 - mod(y,8);
end

after_img = zeros(x+p_x,y+p_y);
after_img(1:x,1:y) = sub_img(1:x,1:y);
after_img(x+1:x+p_x,1:y) = sub_img(x:-1:x-p_x+1,1:y);
after_img(1:x,y+1:y+p_y) = sub_img(1:x,y:-1:y-p_y+1);
after_img(x:x+p_x,y:y+p_y) = sub_img(x:-1:x-p_x,y:-1:y-p_y);   

% Apply DCT

% Quantize Image using Qunatization Table
block_dct = zeros(8);
for i=1:8:x 
  for j=1:8:y
    block = after_img(i:i+7,j:j+7);
    
    for u=0:7
      for v=0:7
        % Cu와 Cv를 구한다.
        if u == 0
          Cu = sqrt(1/8);
        else
          Cu = sqrt(2/8);
        end
        
        if v == 0
          Cv = sqrt(1/8);
        else
          Cv = sqrt(2/8);
        end
        
        temp_dct = 0; % DCT값을 구해서 넣을곳
        for q=0:7
          for w=0:7
            temp_dct= temp_dct+ ( block(q+1,w+1) * cos((((2*q)+1)*u*pi)/16) * cos((((2*w)+1)*v*pi)/16));
          end
        end
        block_dct(u+1,v+1) = Cu * Cv * temp_dct;
      end
    end
    after_img(i:i+7,j:j+7) = block_dct(1:8,1:8);
  end
end

for i=1:8:x
  for j=1:8:y
    after_img(i:i+7,j:j+7) = round(after_img(i:i+7,j:j+7) ./ q_mtx(1:8,1:8));
  end
end

% Zigzag scanning
% [~, 8]=size(after_img);

Vect_all=zeros(1,x*y);
flag = 1; % 다음에 쓸 값이 저장될 위치.

for q=1:8:x
  for w=1:8:y

    tmp_block = after_img(q:q+7,w:w+7);    
    Vect = zeros(1,8*8);  
    Vect(1)=after_img(q,w);
    v=1;
    conut = 0;
    tail = 0; 
      
    for k=1:2*7
        if k<=8
            if mod(k,2)==0
            j=k;
            for i=1:k
                Vect(v)=tmp_block(i,j);
                
                if tmp_block(i,j) == 0
                  conut = conut +1;
                else
                  conut = 0;
                end
                v=v+1;j=j-1;    
            end
            else
            i=k;
            for j=1:k   
                Vect(v)=tmp_block(i,j);
                
                if tmp_block(i,j) == 0
                  conut = conut +1;
                else
                  conut = 0;
                end
                v=v+1;i=i-1; 
            end
            end
        else
            if mod(k,2)==0
            p=mod(k,8); j=8;
            for i=p+1:8
                Vect(v)=tmp_block(i,j);       
                
                if tmp_block(i,j) == 0
                  conut = conut +1;
                else
                  conut = 0;
                end
                
                v=v+1;j=j-1;    
            end
            else
            p=mod(k,8);i=8;
            for j=p+1:8 
                Vect(v)=tmp_block(i,j);      
                
                if tmp_block(i,j) == 0
                  conut = conut +1;
                else
                  conut = 0;
                end
                
                v=v+1;i=i-1; 
            end
            end
        end
    end
    tail = 16 - conut ;
    Vect(tail+1) = 999;
    Vect_all(flag:flag+res) = Vect(1:res+1);
    flag = flag + res+1;
  end
end
counter = 0;
for i=1:x*y
  if Vect_all((x*y) - i) ~= 0
    break;
  else
    counter = counter + 1;
  end
end
ret_Vect = zeros(1,x*y-counter-1);
ret_Vect(1:(x*y)-counter-1) = Vect_all(1:(x*y)-counter-1);
zigzag = ret_Vect;
encode_x = x
encode_y =y
end

