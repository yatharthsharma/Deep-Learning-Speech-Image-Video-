
videoObject = mmreader('C:\Users\yatharth\Desktop\video6.wmv');
numFrames = videoObject.NumberOfFrames;
Y=[];
INDEX=[];
detail=[];
secmax=[];
% t1=imageData(:,:,1,5);
% t2=imageData(:,:,2,5);
% t3=imageData(:,:,3,5);
%  im = uint8(cat(3,t1,t2,t3));
%  imshow(im)
image = [];
% for i=1 : 50
   countauto=0; 
     counth=0;
     countair=0;
imageData = read(videoObject,[1 633]);
zmx=[];
for U=1:633
a=imageData(:,:,:,U);
size(a);
% crop1=imcrop(a,[225 225 23 23]);
 im=imresize(a, [32 32]);
% imshow(a)

im3 = rgb2gray(im);
im2=im3;

% imshow(a)
z=[]; 
V=[];

% imshow(crop1)
for i=1:32
   z= [z im2(i,:)];
 end
  z=z/255;
  

load mnistclassify_weights(5ob) w1 w2 w3 w_class;

w1t=w1;
w2t=w2;
w3t=w3;
w_classt =w_class;
   testbatchdata=z;

   data = testbatchdata(:,:);
   data = [data ones(1,1)];
 
   w1probs = 1./(1 + exp(-double(data)*double(w1t))); w1probs = [w1probs  ones(1,1)];
   w2probs = 1./(1 + exp(-w1probs*w2t)); w2probs = [w2probs ones(1,1)];
   w3probs = 1./(1 + exp(-w2probs*w3t)); w3probs = [w3probs  ones(1,1)];
   targetout = exp(w3probs*w_classt);
   targetout = targetout./repmat(sum(targetout,2),1,10);
   [I J]=max(targetout,[],2);
   
  SecondMax = max(targetout(targetout<max(targetout)));
INDEX=[INDEX find(targetout==SecondMax)];
   Y=[Y J];
   V=[V;targetout];
   
end

if (J==1)
       disp('airplane');
       
   elseif (J==2)
       disp('car');
       
       
   elseif (J==3)
       disp('bird');
       
       
   elseif (J==4)
       disp('cat');
         counth=counth+1;
       
   elseif (J==5)
       disp('deer');
         counth=counth+1;
       
   elseif (J==6)
       disp('dog');
         counth=counth+1;
       
   elseif (J==7)
       disp('frog');
         counth=counth+1;
          
   elseif (J==8)
       disp('horse');
       counth=counth+1;
       
   elseif (J==9)
      disp('ship');
       
              
   elseif (J==10)
       disp('truck');
              
   
   end
   
     Y
     
 counth=counth+length(find(Y==8));
 counth=counth+length(find(Y==7));
counth=counth+length(find(Y==6));
counth=counth+length(find(Y==5));
counth=counth+length(find(Y==4));

countauto=countauto+length(find(Y==9));
countauto=countauto+length(find(Y==10));
countauto=countauto+length(find(Y==2));

countair=countair+length(find(Y==1));
countair=countair+length(find(Y==3));


counth=counth+length(find(INDEX==8));
 counth=counth+length(find(INDEX==7));
counth=counth+length(find(INDEX==6));
counth=counth+length(find(INDEX==5));
counth=counth+length(find(INDEX==4));

countauto=countauto+length(find(INDEX==9));
countauto=countauto+length(find(INDEX==10));
countauto=countauto+length(find(INDEX==2));

countair=countair+length(find(INDEX==1));
countair=countair+length(find(INDEX==3));

finalar=[];
finalar = [counth countauto countair];
[maxin maxel]=max(finalar,[],2)

if maxel==1
   msgbox('network believes that the content of this video belongs to animal class');
elseif maxel==2
    msgbox('network believes that the content of this video belongs to automobile class');

elseif maxel==3
    msgbox('network believes that the content of this video belongs to airobjects class');
end



    
 



