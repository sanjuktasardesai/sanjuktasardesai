clc;
clear all;
close all;


%finding the average of near and far target
    nt1=readmatrix('NEAR TARGET.txt');
    ft1=readmatrix('FAR TARGET.txt');
     for j=1:1:20000
        checknt=isnan(nt1(j));
        if(checknt==1)
            totreadnt=j-1;
            break
        end
     end
     for j=1:1:20000
        checkft=isnan(ft1(j));        
        if(checkft==1)
            totreadft=j-1;
            break
        end
     end
    sensor1ft=ft1(1:5:totreadft,5:1:10);
    sensor1nt=nt1(1:5:totreadnt,5:1:10);
    nframesft=totreadft/5;
    nframesnt=totreadnt/5;
    nt2=0;ft2=0;
    %resetting all other values based on first value   
      remnt=sensor1nt(1,:);
      remft=sensor1ft(1,:);
    
    for j=1:1:nframesnt
        sensor1nt(j,:)=sensor1nt(j,:)-remnt;
        nt2=nt2+sensor1nt(j,1:3);
    end
    for j=1:1:nframesft
        sensor1ft(j,:)=sensor1ft(j,:)-remft;
        ft2=ft2+sensor1ft(j,1:3);
    end
     nt=nt2/nframesnt;
     ft=ft2/nframesft;

     
for i=1:1:1
    %initialize
    vel1=0;vel2=0;vel3=0;vel4=0;vel5=0;
    tdis1=0;tdis2=0;tdis3=0;tdis4=0;tdis5=0;
    rem1=0;rem2=0;rem3=0;rem4=0;rem5=0;dum=0;
    
    %extracting data and finding number of frames
    fname=sprintf('TRIAL %d.txt',i);
    fname1=sprintf('TRIAL %d.xlsx',i);
    fname2=sprintf('Total readings.xlsx');
    n=readmatrix(fname);
    
    for j=1:1:20000
        check=isnan(n(j));
        
        if(check==1)
            totread=j-1;
            break
        end
    end
    
%     making individual sheets sensor wise and saving them for each trial
      nframes=totread/5;
      sensor1=n(1:5:totread,5:1:10);
      sensor2=n(2:5:totread,5:1:10);
      sensor3=n(3:5:totread,5:1:10);
      sensor4=n(4:5:totread,5:1:10);
      sensor5=n(5:5:totread,5:1:10);
      sname=sprintf('TRIAL %d.xlsx',i);
      sname1=sprintf('TRIAL %d',i);
        writematrix(sensor1,'sensor1.xlsx','Sheet',i)
        writematrix(sensor2,'sensor2.xlsx','Sheet',i)
        writematrix(sensor3,'sensor3.xlsx','Sheet',i)
        writematrix(sensor4,'sensor4.xlsx','Sheet',i)
        writematrix(sensor5,'sensor5.xlsx','Sheet',i)
        
      
      %considering 1st point 
      rem1=sensor1(1,:);
      rem2=sensor2(1,:);
      rem3=sensor3(1,:);
      rem4=sensor4(1,:);
      rem5=sensor5(1,:);
  
        
     %resetting all other values based on first value   
      for j=1:1:nframes
      sensor1(j,:)=sensor1(j,:)-rem1;
      sensor1(j,2:3)=sensor1(j,2:3)*(-1);
       sensor2(j,:)=sensor2(j,:)-rem2;
       sensor2(j,2:3)=sensor2(j,2:3)*(-1);
        sensor3(j,:)=sensor3(j,:)-rem3;
        sensor3(j,2:3)=sensor3(j,2:3)*(-1);
         sensor4(j,:)=sensor4(j,:)-rem4;
         sensor4(j,2:3)=sensor4(j,2:3)*(-1);
          sensor5(j,:)=sensor5(j,:)-rem5;
          sensor5(j,2:3)=sensor5(j,2:3)*(-1);
      end
      
      lftdis=min(sensor1(:,2));
      rtdis=max(sensor1(:,2));
      
      %creating a excel for each trial with each sheet being 1 sensor
        writematrix(sensor1,fname1,'Sheet',1)
        writematrix(sensor2,fname1,'Sheet',2)
        writematrix(sensor3,fname1,'Sheet',3)
        writematrix(sensor4,fname1,'Sheet',4)
        writematrix(sensor5,fname1,'Sheet',5)
      x1=xlsread(sname,1,'A:A'); 
      y1=xlsread(sname,1,'B:B');
      z1=xlsread(sname,1,'C:C');
      plot3(x1,y1,z1)
      savefig (sname1)
        
       %phase 1 1-p1e, phase 2 p1e - p3s, phase 3 p3s - p4s, phase 4 p4s -
       %nframes
            %Phase 3 start
            [~,p3s]=max(sensor1(:,3));
            %phase 1 end
            [~,p1e]=max(sensor1(1:p3s,1));
            %phase 4 start
            [~,p4s]=max(sensor1(p3s:nframes,1));
            p4s=p4s+p3s;
            maxnft1=sensor1(p1e,:);
            
      
      for j=1:1:nframes
          if (j<nframes)
      displacement1(j,1)=sqrt(((sensor1(j+1,1)-sensor1(j,1))^2)+((sensor1(j+1,2)-sensor1(j,2))^2)+((sensor1(j+1,3)-sensor1(j,3))^2));
      velocity1(j,1)=displacement1(j,1)*120;
      
      %to find the average velocity summing
      vel1=vel1+velocity1(j,1);
      
      % to find total displacement
      tdis1=tdis1+displacement1(j,1);
      
      %reaction time
     while (dum==0)
      if (tdis1>0.5)
          racttim=j/120;
          dum=1;
      else 
          break
      end
     end
      
      displacement2(j,1)=sqrt(((sensor2(j+1,1)-sensor2(j,1))^2)+((sensor2(j+1,2)-sensor2(j,2))^2)+((sensor2(j+1,3)-sensor2(j,3))^2));
      velocity2(j,1)=displacement2(j,1)*120;
      vel2=vel2+velocity2(j,1);
      tdis2=tdis2+displacement2(j,1);
      
      displacement3(j,1)=sqrt(((sensor3(j+1,1)-sensor3(j,1))^2)+((sensor3(j+1,2)-sensor3(j,2))^2)+((sensor3(j+1,3)-sensor3(j,3))^2));
      velocity3(j,1)=displacement3(j,1)*120;
      vel3=vel3+velocity3(j,1);
      tdis3=tdis3+displacement3(j,1);
      
      displacement4(j,1)=sqrt(((sensor4(j+1,1)-sensor4(j,1))^2)+((sensor4(j+1,2)-sensor4(j,2))^2)+((sensor4(j+1,3)-sensor4(j,3))^2));
      velocity4(j,1)=displacement4(j,1)*120;
      vel4=vel4+velocity4(j,1);
      tdis4=tdis4+displacement4(j,1);
      
      displacement5(j,1)=sqrt(((sensor5(j+1,1)-sensor5(j,1))^2)+((sensor5(j+1,2)-sensor5(j,2))^2)+((sensor5(j+1,3)-sensor5(j,3))^2));
      velocity5(j,1)=displacement5(j,1)*120;
      vel5=vel5+velocity5(j,1);
      tdis5=tdis5+displacement5(j,1); 
      T=j/120;
      timep(j,1)=T;
          else
              break
          end
      end
      
       %Maximum displacement in x direction for reaching
        if ((i==1)||(i==2)||(i==5)||(i==7)||(i==10)||(i==11)||(i==15)||(i==16)||(i==17)||(i==19))%near target
            maxdisp1=sqrt(((maxnft1(1,1)-nt(1,1))^2)+((maxnft1(1,2)-nt(1,2))^2)+((maxnft1(1,3)-nt(1,3))^2));
            
        else %far target
            maxdisp1=sqrt(((maxnft1(1,1)-ft(1,1))^2)+((maxnft1(1,2)-ft(1,2))^2)+((maxnft1(1,3)-ft(1,3))^2));  
        end
      dispreach=sum(displacement1(1:p1e,1));
     
      %getting the average velocity
      avgvel1=vel1/(nframes-1);
      avgvel2=vel2/(nframes-1);
      avgvel3=vel3/(nframes-1);
      avgvel4=vel4/(nframes-1);
      avgvel5=vel5/(nframes-1);
      avgvel=(avgvel1+avgvel2+avgvel3+avgvel4+avgvel5)/5;
      
      %phase1 displacement & average velocity
      ph1s1d=sum(displacement1(1:p1e));
      ph1s2d=sum(displacement2(1:p1e));
      ph1s3d=sum(displacement3(1:p1e));
      ph1s4d=sum(displacement4(1:p1e));
      ph1s5d=sum(displacement5(1:p1e));
       ph1s1v=sum(velocity1(1:p1e))/p1e;
       ph1s2v=sum(velocity2(1:p1e))/p1e;
       ph1s3v=sum(velocity3(1:p1e))/p1e;
       ph1s4v=sum(velocity4(1:p1e))/p1e;
       ph1s5v=sum(velocity5(1:p1e))/p1e;
      
      %phase2 displacement and velocity
      ph2s1d=sum(displacement1((p1e+1):p3s));
      ph2s2d=sum(displacement2((p1e+1):p3s));
      ph2s3d=sum(displacement3((p1e+1):p3s));
      ph2s4d=sum(displacement4((p1e+1):p3s));
      ph2s5d=sum(displacement5((p1e+1):p3s));
        ph2s1v=sum(velocity1((p1e+1):p3s))/(p3s-p1e);
        ph2s2v=sum(velocity2((p1e+1):p3s))/(p3s-p1e);
        ph2s3v=sum(velocity3((p1e+1):p3s))/(p3s-p1e);
        ph2s4v=sum(velocity4((p1e+1):p3s))/(p3s-p1e);
        ph2s5v=sum(velocity5((p1e+1):p3s))/(p3s-p1e);
      
      %phase3 displacement
      ph3s1d=sum(displacement1((p3s+1):p4s));
      ph3s2d=sum(displacement2((p3s+1):p4s));
      ph3s3d=sum(displacement3((p3s+1):p4s));
      ph3s4d=sum(displacement4((p3s+1):p4s));
      ph3s5d=sum(displacement5((p3s+1):p4s));
        ph3s1v=sum(velocity1((p3s+1):p4s))/(p4s-p3s);
        ph3s2v=sum(velocity2((p3s+1):p4s))/(p4s-p3s);
        ph3s3v=sum(velocity3((p3s+1):p4s))/(p4s-p3s);
        ph3s4v=sum(velocity4((p3s+1):p4s))/(p4s-p3s);
        ph3s5v=sum(velocity5((p3s+1):p4s))/(p4s-p3s);
      
       %phase4 displacement
      ph4s1d=sum(displacement1((p4s+1):(nframes-1)));
      ph4s2d=sum(displacement2((p4s+1):(nframes-1)));
      ph4s3d=sum(displacement3((p4s+1):(nframes-1)));
      ph4s4d=sum(displacement4((p4s+1):(nframes-1)));
      ph4s5d=sum(displacement5((p4s+1):(nframes-1)));
       ph4s1v=sum(velocity1((p4s+1):(nframes-1)))/((nframes-1)-p4s);
       ph4s2v=sum(velocity2((p4s+1):(nframes-1)))/((nframes-1)-p4s);
       ph4s3v=sum(velocity3((p4s+1):(nframes-1)))/((nframes-1)-p4s);
       ph4s4v=sum(velocity4((p4s+1):(nframes-1)))/((nframes-1)-p4s);
       ph4s5v=sum(velocity5((p4s+1):(nframes-1)))/((nframes-1)-p4s);
      
      %writing displacement as a separate column
       writematrix(displacement1,fname1,'Sheet',1,'Range','G1')
       writematrix(displacement2,fname1,'Sheet',2,'Range','G1')
       writematrix(displacement3,fname1,'Sheet',3,'Range','G1')
       writematrix(displacement4,fname1,'Sheet',4,'Range','G1')
       writematrix(displacement5,fname1,'Sheet',5,'Range','G1')
       
       %writing velocity as a separate column
       writematrix(velocity1,fname1,'Sheet',1,'Range','H1')
       writematrix(velocity2,fname1,'Sheet',2,'Range','H1')
       writematrix(velocity3,fname1,'Sheet',3,'Range','H1')
       writematrix(velocity4,fname1,'Sheet',4,'Range','H1')
       writematrix(velocity5,fname1,'Sheet',5,'Range','H1')
       
      %writing phase wise velocity for each trial
       
       writematrix(timep(1:p1e),fname2,'Sheet',(i+1),'Range','A1')
       writematrix(velocity1(1:p1e),fname2,'Sheet',(i+1),'Range','B1')
       writematrix(timep((p1e+1):p3s),fname2,'Sheet',(i+1),'Range','C1')
       writematrix(velocity1((p1e+1):p3s),fname2,'Sheet',(i+1),'Range','D1')
       writematrix(timep((p3s+1):p4s),fname2,'Sheet',(i+1),'Range','E1')
       writematrix(velocity1((p3s+1):p4s),fname2,'Sheet',(i+1),'Range','F1')
       writematrix(timep((p4s+1):(nframes-1)),fname2,'Sheet',(i+1),'Range','G1')
       writematrix(velocity1((p4s+1):(nframes-1)),fname2,'Sheet',(i+1),'Range','H1')
      
        %trunk displacement from sensor 5 maximum
        trnkdisp=min(sensor5(:,1));
        
        %shoulder flexion
        angshfl=max(sensor3(:,5));
        angshex=min(sensor3(:,5));
        
        %abduction
        abdang=max(sensor3(:,4));
        
        %adduction
        %vec11=rem4;
        %vec21=rem4;
        %vec12=rem1;
        %vec22=maxnft1;
        A=((rem1(1)-rem4(1))^2)+((rem1(2)-rem4(2))^2)+((rem1(3)-rem4(3))^2);
        B=((maxnft1(1)-rem4(1))^2)+((maxnft1(2)-rem4(2))^2)+((maxnft1(3)-rem4(3))^2);
        C=(sqrt(A)*sqrt(B));
        D=rem1(1)-rem4(1);
        E=maxnft1(1)-rem4(1);
        F=rem1(2)-rem4(2);
        G=maxnft1(2)-rem4(2);
        H=rem1(3)-rem4(3);
        K=maxnft1(3)-rem4(3);
        L=(D*E)+(F*G)+(H*K);
        addang=acos(L/C);
        addang=rad2deg(addang);
       
       %Finding total time for the task
       time=nframes/120;
       tp1=p1e/120;
       tp2=(p3s-p1e)/120;
       tp3=(p4s-p3s)/120;
       tp4=(nframes-p4s)/120;
       
       %Output of important data
       output1((1+(31*(i-1))),:)=["Trial",i];
       output1((2+(31*(i-1))),1:6)=["Total time","Average velocity - 1","Average velocity - 2","Average velocity - 3","Average velocity - 4","Average velocity - 5"];
       output1((3+(31*(i-1))),1:6)=[time,avgvel1,avgvel2,avgvel3,avgvel4,avgvel5];
       output1((4+(31*(i-1))),1:4)=["Total Disp Ph1 S1","Total disp Ph2 S1","Total disp Ph3 S1","Total disp Ph4 S1"];  
       output1((5+(31*(i-1))),1:4)=[ph1s1d,ph2s1d,ph3s1d,ph4s1d];
       output1((6+(31*(i-1))),1:4)=["Total Disp Ph1 S2","Total disp Ph2 S2","Total disp Ph3 S2","Total disp Ph4 S2"];   
       output1((7+(31*(i-1))),1:4)=[ph1s2d,ph2s2d,ph3s2d,ph4s2d];
       output1((8+(31*(i-1))),1:4)=["Total Disp Ph1 S3","Total disp Ph2 S3","Total disp Ph3 S3","Total disp Ph4 S3"];   
       output1((9+(31*(i-1))),1:4)=[ph1s3d,ph2s3d,ph3s3d,ph4s3d];
       output1((10+(31*(i-1))),1:4)=["Total Disp Ph1 S4","Total disp Ph2 S4","Total disp Ph3 S4","Total disp Ph4 S4"];   
       output1((11+(31*(i-1))),1:4)=[ph1s4d,ph2s4d,ph3s4d,ph4s4d];
       output1((12+(31*(i-1))),1:4)=["Total Disp Ph1 S5","Total disp Ph2 S5","Total disp Ph3 S5","Total disp Ph4 S5"];   
       output1((13+(31*(i-1))),1:4)=[ph1s5d,ph2s5d,ph3s5d,ph4s5d];
       
       output1((14+(31*(i-1))),1:4)=["Total vel Ph1 S1","Total vel Ph2 S1","Total vel Ph3 S1","Total vel Ph4 S1"];  
       output1((15+(31*(i-1))),1:4)=[ph1s1v,ph2s1v,ph3s1v,ph4s1v];
       output1((16+(31*(i-1))),1:4)=["Total vel Ph1 S2","Total vel Ph2 S2","Total vel Ph3 S2","Total vel Ph4 S2"];   
       output1((17+(31*(i-1))),1:4)=[ph1s2v,ph2s2v,ph3s2v,ph4s2v];
       output1((18+(31*(i-1))),1:4)=["Total vel Ph1 S3","Total vel Ph2 S3","Total vel Ph3 S3","Total vel Ph4 S3"];   
       output1((19+(31*(i-1))),1:4)=[ph1s3v,ph2s3v,ph3s3v,ph4s3v];
       output1((20+(31*(i-1))),1:4)=["Total vel Ph1 S4","Total vel Ph2 S4","Total vel Ph3 S4","Total vel Ph4 S4"];   
       output1((21+(31*(i-1))),1:4)=[ph1s4d,ph2s4d,ph3s4d,ph4s4d];
       output1((22+(31*(i-1))),1:4)=["Total vel Ph1 S5","Total vel Ph2 S5","Total vel Ph3 S5","Total vel Ph4 S5"];   
       output1((23+(31*(i-1))),1:4)=[ph1s5v,ph2s5v,ph3s5v,ph4s5v];
     
       output1((24+(31*(i-1))),1:6)=["Average velocity of all sensors","Total displacement - 1","Total displacement - 2","Total displacement - 3","Total displacement - 4","Total displacement - 5"];
       output1((25+(31*(i-1))),1:6)=[avgvel,tdis1,tdis2,tdis3,tdis4,tdis5];
       output1((26+(31*(i-1))),1:6)=["Maximum left displacement","Maximum right displacement","Maximum displacement path straightness for the patient in reaching","Difference in reaching from target","Shoulder flexion","Shoulder extension"];
       output1((27+(31*(i-1))),1:6)=[lftdis,rtdis,dispreach,maxdisp1,angshfl,angshex];
       output1((28+(31*(i-1))),1:4)=["Reaction time","Abduction angle","adduction angle","Trnk displacement"];
       output1((29+(31*(i-1))),1:4)=[racttim,abdang,addang,trnkdisp];
       output1((30+(31*(i-1))),1:4)=["Time Phase 1","Time Phase 2","Time Phase 3","Time Phase 4"];
       output1((31+(31*(i-1))),1:4)=[tp1,tp2,tp3,tp4];
       
       writematrix(output1,fname2,'Sheet',1,'Range','A1')
       
end
    
