function img = my_decoding(zigzag,row,col)
% Compress Image using portion of JPEG
% zigzag : result of zigzag scanning
% img    : GrayScale Image 

q_mtx =     [16 11 10 16 24 40 51 61; 
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56; 
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];
% 양자화를 위한 행렬
% Construct 8x8 blocks using zigzag scanning value

after_img = zeros(row,col);

check = 999; %해당 변수를 이용하여 값저장 위치 확인
v=1;

%지그재그 함수 실행
for q=1:8:row
  for w=1:8:col

    tmp_block = zeros(8,8); %해당 블록을 이용하여 각 위치의 8*8의 내용 저장
    flag=0; %해당 변수를 이용하여 값저장 위치 확인
    
    for k=1:14
        if k<=8
            if mod(k,2)==0
            j=k;
            for i=1:k
                if zigzag(v) == check
                  v=v+1;
                  flag=1;
                  break;
                end
                
                tmp_block(i,j) = zigzag(v);                
                v=v+1;j=j-1;    
            end
            else
              i=k;
              for j=1:k   
                  if zigzag(v) == check
                    v=v+1;
                    flag=1;
                    break;
                  end
                  
                  tmp_block(i,j) = zigzag(v);                
                  v=v+1;i=i-1; 
              end
            end
        else
            if mod(k,2)==0
            p=mod(k,8); j=8;
            for i=p+1:8
                
                if zigzag(v) == check
                  v=v+1;
                  flag=1;
                  break;
                end
                
                tmp_block(i,j) = zigzag(v);                
                v=v+1;j=j-1;   
            end
            else
            p=mod(k,8);i=8;
            for j=p+1:8  
               
                if zigzag(v) == check
                  v=v+1;
                  flag=1;
                  break;
                end
                
                tmp_block(i,j) = zigzag(v);                
                v=v+1;i=i-1; 
            end 
            end 
        end 
        if flag == 1
          after_img(q:q+7, w:w+7) = tmp_block(1:8,1:8);
          break;
        end
    end
  end
end

% 양자화 실시
% Multiply Quantization Table
for i=1:8:row
  for j=1:8:col
    after_img(i:i+7,j:j+7) = (after_img(i:i+7,j:j+7) .* q_mtx(1:8,1:8)) ;
  end
end

% DCT 계산
% Apply Inverse DCT
[x,y] = size(after_img);
block_dct = zeros(8);

for i=1:8:row
  for j=1:8:col
    block = after_img(i:i+7,j:j+7);.
    
    for u=0:7
      for v=0:7
        tmp_sum = 0;
        for q=0:7
          for w=0:7
            % Cu와 Cv를 구한다.
            if q == 0
              Cq = sqrt(1/8);
            else
              Cq = sqrt(2/8);
            end
        
            if w == 0
              Cw = sqrt(1/8);
            else
              Cw = sqrt(2/8);
            end
        
            tmp_sum = tmp_sum + ( Cq * Cw * block(q+1,w+1) * cos((((2*u)+1)*q*pi)/16) * cos((((2*v)+1)*w*pi)/16));
          end
        end
        block_dct(u+1,v+1) = tmp_sum;
      end
    end
    after_img(i:i+7,j:j+7) = block_dct(1:8, 1:8);
  end
end

% Add 128
after_img = after_img + 128;

img = uint8(after_img);
end

