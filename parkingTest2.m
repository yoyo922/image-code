function parkingTest2
    input = 'shadow1.jpg';
    I = imread(input);
    imtool(I)
    outBin = createBinary(input);
    %imshow(outBin);
    carArrayOne = [0 0 0 0];
    for i = 1:4
       if (i == 1)
           picBuff = outBin(780:1250,1:530);
           totalPix = (1256 - 780) * (530 - 1);
           total = bwarea(picBuff);
           result = total/totalPix;
           if result > 0.1
              carArrayOne(i) = 1;
           end
           figure
           imshowpair(outBin,picBuff,'montage');
       elseif (i == 2)
           picBuff = outBin(780:1425,800:1334);
           total = bwarea(picBuff);
           totalPix = (1325 - 780) * (1334 - 800);
           result = total/totalPix;
           if result > 0.1
               carArrayOne(i) = 1;
           end
           figure
           imshowpair(outBin,picBuff,'montage');
       elseif (i == 3)    
           picBuff = outBin(780:1425,1420:2050);
           total = bwarea(picBuff);
           totalPix = (1425 - 780) * (2050 -1420);
           result = total/totalPix;
           if result > 0.1
               carArrayOne(i) = 1;
           end
           figure
           imshowpair(outBin,picBuff,'montage');
       elseif (i == 4)
           picBuff = outBin(780:1425,2100:2820);
           total = bwarea(picBuff);
           totalPix = (1420 - 780) * (2820 - 2100);
           result = total/totalPix;
           if result > 0.1
               carArrayOne(i) = 1;
           end
           figure
           imshowpair(outBin,picBuff,'montage');
       end
       disp(result);
    end
    date = datestr(now, 'mm dd,HH:MM:SS');
    outfile = fopen('output.txt', 'w');
    printBuffer = sprintf('%d ',carArrayOne);
    fprintf(outfile,'%s\n',printBuffer);
    fprintf(outfile,'%s\n', date);
    fclose(outfile);
end
function final = createBinary(inputImage)
    I = imread(inputImage);  
    bw = imbinarize(rgb2gray(I),'adaptive','ForegroundPolarity','dark','Sensitivity',0.38);
    sedisk = strel('disk',3);
    noSmallStructures = imopen(bw, sedisk);
    imwrite(noSmallStructures,'before_inverse.jpg')
    final = imcomplement(noSmallStructures);
    sedisk = strel('disk',15);
    final = imopen(final,sedisk);
end 