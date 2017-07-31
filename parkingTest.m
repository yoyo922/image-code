function parkingTest
    input = 'parkingLot1.png';
    outBin = createBinary(input);
    carArrayOne = [0 0 0 0 0];
    xPos = 23;
    totalPix = 285 * 140;
    
    for i = 1:5
       pics{i} = outBin(20:305,xPos:xPos+140);
       xPos = xPos + 160;
       total = bwarea(pics{i});
       result = total/totalPix;
       if result > 0.1
           carArrayOne(i) = 1;
       end
    end
    
    input = 'parkingLot2.png';
    imtool (input);
    outBin = createBinary(input);
    carArrayTwo = [0 0 0];
    xPos = 10;
    
    for i = 1:3
       pics{i} = outBin(6:343,xPos+20:xPos+145);
       xPos = xPos + 147;
       total = bwarea(pics{i});
       result = total/totalPix;
       if result > 0.15
           carArrayTwo(i) = 1;
       end
    end
    
    disp('**************************');
    input = 'parkingLot3.png';
    imtool (input);
    outBin = createBinary(input);
    carArrayThree = [0 0 0];
    xPos = 18;
    
    for i = 1:3
       pics{i} = outBin(6:343,xPos:xPos+170);
       xPos = xPos + 175;
       figure
       imshow(pics{i});
       total = bwarea(pics{i});
       result = total/totalPix;
       if result > 0.15
           carArrayThree(i) = 1;
       end
    end
    
    date = datestr(now, 'mm dd,HH:MM:SS');
    outfile = fopen('output.txt', 'w');
    printBuffer = sprintf('%d ',carArrayOne);
    fprintf(outfile,'%s\n',printBuffer);
    printBuffer = sprintf('%d ',carArrayTwo);
    fprintf(outfile,'%s\n',printBuffer);
    printBuffer = sprintf('%d ',carArrayThree);
    fprintf(outfile,'%s\n',printBuffer);
    fprintf(outfile,'%s\n', date);
    fclose(outfile);
end

function final = createBinary(inputImage)
    I = imread(inputImage);  
    bw = imbinarize(rgb2gray(I),'adaptive','ForegroundPolarity','dark','Sensitivity',0.38);
    sedisk = strel('disk',3);
    noSmallStructures = imopen(bw, sedisk);
    final = imcomplement(noSmallStructures);
end 