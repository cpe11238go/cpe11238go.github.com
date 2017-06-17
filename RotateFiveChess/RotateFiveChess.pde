final int START = 0;
final int Illustrate = 1;
final int PLAY = 2;
final int END = 3;
int GameState = START;

PImage FiveInterface = new PImage();
PImage option = new PImage();
PImage option2 = new PImage();
PImage EXThree = new PImage();

PImage[] IllustrateBall = new PImage[15];
int[] IllustrateBallX = new int[15];
int[] IllustrateBallY = new int[15];
boolean IWR = false;                               //WhetherRotateIllustrate教學用旋轉事件
int IRC = 0;                                      //IllustraterotateCount
int ITC = 2;                                       //IllustrateTimeCount  計算時間間隔
int ITCN = 0;                                      //IllustrateTimeCountNum

PImage[] Ball   = new PImage[55];
int[] BLAO = {54,52,49,45,40,34,27,19,10,0,53,50,46,41,35,28,20,11,1,51,47,42,36,29,21,12,2,48,43,37,30,22,13,3,44,38,31,23,14,4,39,32,24,15,5,33,25,16,6,26,17,7,18,8,9};    //原座標順時針轉60度後的座標BallLocationAtotherOne
int[] BLAT = {9,18,26,33,39,44,48,51,53,54,8,17,25,32,38,43,47,50,52,7,16,24,31,37,42,46,49,6,15,23,30,36,41,45,5,14,22,29,35,40,4,13,21,28,34,3,12,20,27,2,11,19,1,10,0};    //原座標逆時針轉60度後的座標BallLocationAtotherTwo
PImage[] BallColor = new PImage[6];
int[]    BallX  = new int[55];
int[]    BallY  = new int[55];
PImage threeCBD = new PImage();
PImage threeCBU = new PImage();
int threeCBX = 55;
int threeCBY = 0;
int threeCBAppearX = 0;
int threeCBAppearY = 0;
boolean threeCBAppear = false;          //是否顯示上、下三角
int TCBAM = 0;                          //要顯示為上或下
int ClickThreeCX = 0;                   //上三角上次滑鼠按完後之位置
int ClickThreeCY = 0;
int[][] choiceThreeNumU = new int[46][3];                //(9+1)*9/2=45，+1表沒選情況
int[][] choiceThreeNumD = new int[37][3];

int SDM = -1;             //SameDotNum    若點選該位置後，存位置數值，若再點一次則觸發旋轉事件
boolean WR = false;      //WhetherRotate
float degree = 0;        //選轉角度
int rotateCount = 0;
int RUD = 0;           //Rotate Up or Down(0不顯示，1上2下)
PImage[] threeBallStack = new PImage[3];          //顯示要選轉的三顆球顏色
int[] TBSN = new int[3];                          //threeBallStackNum  紀錄旋轉前原位置分別是哪三個，之後方便傳回去
int[] DL = new int[55];                           //DisappearLocation  紀錄達成消除條件之球座標
int DLP = 0;                                      //DisappearLocationPoint DL指標
boolean RA = false;                               //RecoverAgain  判定是否再生
int[] RCDL = new int[55];                         //RandonColorDisappearLocation  暫存DL的隨機顏色變數
boolean RAA = false;                              //RecoverAgainAnimation  是否執行RA動畫
float zoom = 0;                                   //放大倍率
int score = 0;
int scoretime = 61;                               //遊戲倒數時間
int nowsecond = second();
void setup()
{
  size(750,600);
  background(255);
  BallColor[0]  = loadImage("img/white.png");
  BallColor[1]  = loadImage("img/green.png");
  BallColor[2]  = loadImage("img/purple.png");
  BallColor[3]  = loadImage("img/red.png");
  BallColor[4]  = loadImage("img/blue.png");
  BallColor[5]  = loadImage("img/yellow.png");
  threeCBD      = loadImage("img/threeCBD.png");
  threeCBU      = loadImage("img/threeCBU.png");
  FiveInterface = loadImage("img/FiveInterface.png");
  option        = loadImage("img/option.png");
  option2       = loadImage("img/optionTwo.png");
  EXThree       = loadImage("img/EXThree.png");
  Reset();
  IllustrateBall();
  rect(155,96,25,25);//同行間格55
  int CTNU = 9;
  int CTNUP = 1;
  int CTNUPD = 0;
  while(CTNU>1)
  {
    
    for(int i=CTNUP; i<CTNUP+CTNU;i++)
    {
      choiceThreeNumU[i][0] = i+CTNUPD;
      choiceThreeNumU[i][1] = i+1+CTNUPD;
      choiceThreeNumU[i][2] = 10+i;

    }
    CTNUP = CTNUP+CTNU;
    CTNUPD++;
    CTNU--;
  }
  choiceThreeNumU[choiceThreeNumU.length-1][0] = 53;
  choiceThreeNumU[choiceThreeNumU.length-1][1] = 54;
  choiceThreeNumU[choiceThreeNumU.length-1][2] = 55;
  int CTND = 8;
  int CTNDP = 1;
  int CTNDPD = 0;
  while(CTND>1)
  {
    
    for(int i=CTNDP; i<CTNDP+CTND;i++)
    {
      choiceThreeNumD[i][0] = 1+i+CTNDPD;
      choiceThreeNumD[i][1] = 1+i+CTNDPD+CTND+1;
      choiceThreeNumD[i][2] = 1+i+CTNDPD+CTND+2;

    }
    CTNDP = CTNDP+CTND;
    CTNDPD+=2;
    CTND--;
  }
  choiceThreeNumD[choiceThreeNumD.length-1][0] = 51;
  choiceThreeNumD[choiceThreeNumD.length-1][1] = 53;
  choiceThreeNumD[choiceThreeNumD.length-1][2] = 54;
  for(int i=0; i<choiceThreeNumD.length; i++)
  {
    println(choiceThreeNumD[i][0]+","+choiceThreeNumD[i][1]+","+choiceThreeNumD[i][2]);
  }
}

void draw()
{
  switch (GameState)
  {
    case START:
      background(255);
      Appeartext ("五" , width/2, 50 , 30);
      Appeartext ("棋" , width/2+105, 115 , 30);
      Appeartext ("子" , width/2+60, 75 , 30);
      Appeartext ("轉" , width/2-60, 75 , 30);
      Appeartext ("旋" , width/2-105, 115 , 30);
      image(FiveInterface,width/2-FiveInterface.width/2,80);
      image(option,width/2-option.width/2,300);
      image(option,width/2-option.width/2,400);      
      if(mouseX>width/2-option.width/2&&mouseX<width/2-option.width/2+option.width&&mouseY>300&&mouseY<300+option.height)  
      {
        image(option2,width/2-option.width/2,300);
        if(mousePressed)
          GameState = PLAY;
      }
      if(mouseX>width/2-option.width/2&&mouseX<width/2-option.width/2+option.width&&mouseY>400&&mouseY<400+option.height)  
      {
        image(option2,width/2-option.width/2,400);
        if(mousePressed)
          GameState = Illustrate;
      }
      fill(0);
      Appeartext ("遊戲開始" , width/2, 340 , 30);
      Appeartext ("遊戲說明" , width/2, 440 , 30);
      break;
    case Illustrate:
      background(255);
      Appeartext ("遊戲說明:" , 50, 50 , 20);
      Appeartext ("1.將滑鼠移置任三點之間，中間會有小黑點" , 200, 80 , 20);
      Appeartext ("2.點擊一次後會有將三點框起來的邊以做確認(如右圖)" , 250, 130 , 20);
      Appeartext ("3.再點擊一次後，三點將以順時針旋轉，若旋轉後有任五點或以上連成直線，就會" , 370, 180 , 20);
      Appeartext ("消除(如下圖)並獲得分數，來嘗試一下限時100秒會獲得多少分吧!" , 320, 230 , 20);
      Appeartext ("PS:有時連直線後，要等一下才會消除，敬請見諒" , 510, 280 , 20);
      image(EXThree,580,20);
      for(int i=0; i<IllustrateBall.length; i++)
      {
        if(IllustrateBall[i]!=null)
        {
          if(IWR)
          {
            if(i!=2&&i!=5&&i!=6&&i!=13&&i!=9&&i!=12)
              image(IllustrateBall[i],IllustrateBallX[i],IllustrateBallY[i]);
          }
          else
            image(IllustrateBall[i],IllustrateBallX[i],IllustrateBallY[i]);
        }
      }
      if(IWR)
      {
        degree = degree+PI/45.0;
        pushMatrix();     
          translate((IllustrateBallX[2]+IllustrateBallX[5]+IllustrateBallX[6])/3+25, (IllustrateBallY[2]+IllustrateBallY[5]+IllustrateBallY[6])/3+25);
          rotate(degree);              
          image(IllustrateBall[2],0-IllustrateBall[2].width/2,0-IllustrateBall[2].height/2-(threeCBD.width/(float)Math.sqrt(3))/2.2);
          image(IllustrateBall[5],0-IllustrateBall[5].width/2-(threeCBD.width/2)/2.2,0-IllustrateBall[5].height/2+(threeCBD.width/(2*(float)Math.sqrt(3)))/2.2);
          image(IllustrateBall[6],0-IllustrateBall[6].width/2+(threeCBD.width/2)/2.2,0-IllustrateBall[6].height/2+(threeCBD.width/(2*(float)Math.sqrt(3)))/2.2);
        popMatrix();
        pushMatrix();     
          translate((IllustrateBallX[13]+IllustrateBallX[9]+IllustrateBallX[12])/3+25, (IllustrateBallY[13]+IllustrateBallY[9]+IllustrateBallY[12])/3+25);
          rotate(degree);              
          image(IllustrateBall[13],0-IllustrateBall[13].width/2,0-IllustrateBall[13].height/2-(threeCBD.width/(float)Math.sqrt(3))/2.2);
          image(IllustrateBall[9],0-IllustrateBall[9].width/2-(threeCBD.width/2)/2.2,0-IllustrateBall[9].height/2+(threeCBD.width/(2*(float)Math.sqrt(3)))/2.2);
          image(IllustrateBall[12],0-IllustrateBall[12].width/2+(threeCBD.width/2)/2.2,0-IllustrateBall[12].height/2+(threeCBD.width/(2*(float)Math.sqrt(3)))/2.2);
        popMatrix();
        IRC++;
        if(IRC==30)
        {
          IWR = false;
          IllustrateBall[5] = IllustrateBall[6];
          IllustrateBall[6] = IllustrateBall[2];  
          IllustrateBall[12] = IllustrateBall[13];
          IllustrateBall[13] = IllustrateBall[9];
          for(int i=0; i<5; i++)
          {
            IllustrateBall[i] = null;
            IllustrateBall[i+7] = null;            
          }
          ITC = 1;
          IRC = 0;
          degree = 0;
        }       
      }
      if(ITC==1)
      {
        ITCN++;
        if(ITCN==90)
        {
          ITC = 2;
          ITCN = 0;
          IllustrateBall();
        }
      }
      if(ITC==2)
      {
        ITCN++;
        if(ITCN==90)
        {
          ITC = 0;
          ITCN = 0;
          IWR = true;
        }
      }
      image(option,width/2-option.width/2,500); 
      if(mouseX>width/2-option.width/2&&mouseX<width/2-option.width/2+option.width&&mouseY>500&&mouseY<500+option.height)  
      {
        image(option2,width/2-option.width/2,500);
        if(mousePressed)
          GameState = PLAY;
      }
      fill(0);
      Appeartext ("遊戲開始" , width/2, 540 , 30);
      break;
    case PLAY:
      background(255);
      for(int i=0; i<Ball.length; i++)
      {
        if(Ball[i]!=null)
          image(Ball[i],BallX[i],BallY[i]);   
      }
      int threeCUD = 9;            //上三角中間點數量(threeCircleUpDot)
      int CUDX =0;                 //間隔
      int CUDY = 0;     
      while(threeCUD>0)
      {
        for(int i=0; i<threeCUD; i++)
        {
          if(mouseX>130+CUDX+i*55&&mouseX<130+25+CUDX+i*55&&mouseY>85+CUDY&&mouseY<85+25+CUDY)
          {
            fill(0);
            ellipse(143+CUDX+i*55, 97+CUDY, 10, 10);//X間隔55，下一列X偏差25，Y偏差45
            if(threeCBAppear&&(ClickThreeCX>130+CUDX+i*55&&ClickThreeCX<130+25+CUDX+i*55&&ClickThreeCY>85+CUDY&&ClickThreeCY<85+25+CUDY))
            {
              threeCBAppearX = 75+CUDX+i*55;
              threeCBAppearY = 55+CUDY;
            }
          }
        }
        threeCUD = threeCUD-1;
        CUDY = CUDY+46;
        CUDX = CUDX+25;        
      }
      int threeCDD = 8;            //下三角中間點數量(threeCircleDownDot)
      int CDDX =0;                 //間隔
      int CDDY = 0;
      while(threeCDD>0)
      {
        for(int i=0; i<threeCDD; i++)
        {
          if(mouseX>155+CDDX+i*55&&mouseX<155+25+CDDX+i*55&&mouseY>96+CDDY&&mouseY<96+25+CDDY)
          {
            fill(0);
            ellipse(168+CDDX+i*55, 113+CDDY, 10, 10);//X間隔55，下一列X偏差25，Y偏差45
            if(threeCBAppear&&(ClickThreeCX>155+CDDX+i*55&&ClickThreeCX<155+25+CDDX+i*55&&ClickThreeCY>96+CDDY&&ClickThreeCY<96+25+CDDY))
            {
              threeCBAppearX = 100+CDDX+i*55;
              threeCBAppearY = 30+CDDY;
            }
          }
        }
        threeCDD = threeCDD-1;
        CDDY = CDDY+46;
        CDDX = CDDX+25;        
      }
      if(threeCBAppear&&!WR)
      {
        if(TCBAM==1)
          image(threeCBU,threeCBAppearX,threeCBAppearY);
        if(TCBAM==2)
          image(threeCBD,threeCBAppearX,threeCBAppearY);
      }
      //旋轉事件
      if(WR)
      {
        threeCBAppear = false;
        degree = degree+PI/45.0;
        pushMatrix();
        if(RUD==1)
        {
          translate(threeCBAppearX+68, threeCBAppearY+37);
          rotate(degree);
          image(threeBallStack[0],0-threeBallStack[0].width/2-(threeCBU.width/2)/2.2,0-threeBallStack[0].height/2-(threeCBU.width/(2*(float)Math.sqrt(3)))/2.2);
          image(threeBallStack[1],0-threeBallStack[0].width/2+(threeCBU.width/2)/2.2,0-threeBallStack[0].height/2-(threeCBU.width/(2*(float)Math.sqrt(3)))/2.2);
          image(threeBallStack[2],0-threeBallStack[0].width/2,0-threeBallStack[0].height/2+(threeCBU.width/(float)Math.sqrt(3))/2.2);
        }
        if(RUD==2)
        {
          translate(threeCBAppearX+68, threeCBAppearY+87);
          rotate(degree);
          image(threeBallStack[0],0-threeBallStack[0].width/2,0-threeBallStack[0].height/2-(threeCBU.width/(float)Math.sqrt(3))/2.2);
          image(threeBallStack[1],0-threeBallStack[0].width/2-(threeCBU.width/2)/2.2,0-threeBallStack[0].height/2+(threeCBU.width/(2*(float)Math.sqrt(3)))/2.2);
          image(threeBallStack[2],0-threeBallStack[0].width/2+(threeCBU.width/2)/2.2,0-threeBallStack[0].height/2+(threeCBU.width/(2*(float)Math.sqrt(3)))/2.2);
        }
        popMatrix();
        rotateCount++;
        if(rotateCount==30)
        {
          WR = false;
          if(RUD==1)
          {
            Ball[TBSN[0]] = threeBallStack[2];
            Ball[TBSN[1]] = threeBallStack[0];
            Ball[TBSN[2]] = threeBallStack[1];
          }
          if(RUD==2)
          {
            Ball[TBSN[0]] = threeBallStack[1];
            Ball[TBSN[1]] = threeBallStack[2];
            Ball[TBSN[2]] = threeBallStack[0];
          }
          rotateCount = 0;
          degree = 0;
        }       
      }
      
      //消除事件
      if(!RAA)
      {
        int CLNL = 0;    //CheckLineNumLocation  目前要檢測之位置
        int LT = 6;      //LineTime              該行檢測次數
        int LLE = 10;    //LineLocation          上一行檢測完後與下一行位置間隔
        for(int i=0; i<6; i++)
        {
          for(int j=CLNL; j<CLNL+LT; j++)
          {
            if(Ball[j]==Ball[j+1]&&Ball[j]==Ball[j+2]&&Ball[j]==Ball[j+3]&&Ball[j]==Ball[j+4])
            {           
              int MoreFive = j+5;
              while(MoreFive<=CLNL+LLE-1)
              {
                if(Ball[MoreFive]==Ball[j])
                {
                  DL[DLP] = MoreFive;
                  DLP++;               
                  MoreFive++;
                }
                else
                  break;
              }
              DL[DLP] = j;
              DLP++; 
              DL[DLP] = j+1;
              DLP++;  
              DL[DLP] = j+2;
              DLP++;  
              DL[DLP] = j+3;
              DLP++;  
              DL[DLP] = j+4;
              DLP++;  
              
            }
            if(Ball[BLAO[j]]==Ball[BLAO[j+1]]&&Ball[BLAO[j]]==Ball[BLAO[j+2]]&&Ball[BLAO[j]]==Ball[BLAO[j+3]]&&Ball[BLAO[j]]==Ball[BLAO[j+4]])
            {           
              int MoreFive = j+5;
              while(MoreFive<=CLNL+LLE-1)
              {
                if(Ball[BLAO[MoreFive]]==Ball[BLAO[j]])
                {
                  DL[DLP] = BLAO[MoreFive];
                  DLP++;
                  MoreFive++;
                }
                else
                  break;
              }
              DL[DLP] = BLAO[j];
              DLP++; 
              DL[DLP] = BLAO[j+1];
              DLP++;  
              DL[DLP] = BLAO[j+2];
              DLP++;  
              DL[DLP] = BLAO[j+3];
              DLP++;  
              DL[DLP] = BLAO[j+4];
              DLP++;  
              
            }
            if(Ball[BLAT[j]]==Ball[BLAT[j+1]]&&Ball[BLAT[j]]==Ball[BLAT[j+2]]&&Ball[BLAT[j]]==Ball[BLAT[j+3]]&&Ball[BLAT[j]]==Ball[BLAT[j+4]])
            {           
              int MoreFive = j+5;
              while(MoreFive<=CLNL+LLE-1)
              {
                if(Ball[BLAT[MoreFive]]==Ball[BLAT[j]])
                {
                  DL[DLP] = BLAT[MoreFive];
                  DLP++;
                  MoreFive++;
                }
                else
                  break;
              }
              DL[DLP] = BLAT[j];
              DLP++;
              DL[DLP] = BLAT[j+1];
              DLP++;
              DL[DLP] = BLAT[j+2];
              DLP++;
              DL[DLP] = BLAT[j+3];
              DLP++;
              DL[DLP] = BLAT[j+4];
              DLP++;          
            }
          }
          
          CLNL =CLNL+LLE;
          LLE--;
          LT--;
        }      
        for(int i=0; i<DL.length; i++)
        {
          if(DL[i]!=-1)        
          {
            Ball[DL[i]] = null;
            score++;
            RA = true;
          }
        }
      }
      //再生事件
      if(RA&&!RAA)
      {
        //先設定好隨機顏色變數
        for(int i=0; i<DL.length; i++)
          if(DL[i]!=-1)        
            RCDL[i] = (int)random(1,6);                      
        RAA = true;
      }
      if(RAA)
      {       
        
        for(int i=0; i<DL.length; i++)
        {
          if(DL[i]!=-1) 
          {
            pushMatrix();
            translate(BallX[DL[i]]+22,BallY[DL[i]]+23);
            scale(zoom);
            image(BallColor[RCDL[i]],0-BallColor[RCDL[i]].width/2,0-BallColor[RCDL[i]].height/2);
            popMatrix();
          }
        }
        zoom = zoom+0.02;
        if(zoom>=1)
        {
          zoom = 0;
          RAA = false;
        }
      }
      
      //再生後重置
      if(!RAA)
      {
        for(int i=0; i<DL.length; i++)
        {
          if(DL[i]!=-1) 
            Ball[DL[i]] = BallColor[RCDL[i]];            
          DL[i] = -1; 
          RCDL[i] = -1;
        }      
        DLP = 0;
      }
      //顯示分數
      fill(0);
      Appeartext ("Score:"+score, 600, 500 , 30);
      //顯示倒數時間
      if(nowsecond!=second())
      {
        nowsecond = second();
        scoretime--;
      }
      String ST = scoretime+"";
      Appeartext ("時間倒數:"+ST , 330, 50 , 30);
      if(scoretime==0)
        GameState = END;      
      break;
    case END:
      background(255);
      fill(0);
      Appeartext ("Score:"+score, width/2 , height/2-100 , 50);
      if(score<30)
        Appeartext ("評語:(・ω・)", width/2 , height/2 , 40);
      if(score>=30&&score<60)
        Appeartext ("評語:分數有點低喔，再接再厲", width/2 , height/2 , 40);
      if(score>=60&&score<90)
        Appeartext ("評語:玩得不錯~~分數算普普啦~~", width/2 , height/2 , 40);
      if(score>=90&&score<120)
        Appeartext ("評語:這程度可算是中上了呢!", width/2 , height/2 , 40);
      if(score>=120&&score<150)
        Appeartext ("評語:好厲害啊!!真可謂高手耶!!", width/2 , height/2 , 40);
      if(score>=150)
        Appeartext ("評語:狂!!    (°ﾛ°)", width/2 , height/2 , 40);
      image(option,width/2-option.width/2,350);
      if(mouseX>width/2-option.width/2&&mouseX<width/2-option.width/2+option.width&&mouseY>350&&mouseY<350+option.height)  
      {
        image(option2,width/2-option.width/2,350);
        if(mousePressed)
        {
          Reset();
          GameState = PLAY;
        }
      }
      Appeartext ("重新開始" , width/2, 390 , 30);
      break;
    
  }
}
void mouseClicked() 
{
  
   switch (GameState)
   {
     case PLAY:
     if(!WR)
     {
        int threeCUD = 9;            //上三角中間點數量(threeCircleUpDot)
        int CUDX =0;                 //間隔
        int CUDY = 0;
        if(threeCBAppear)
        {
          threeCBAppear = false;
          ClickThreeCX = 0;
          ClickThreeCY = 0;
          TCBAM = 0;
        }
        while(threeCUD>0)
        {
          for(int i=0; i<threeCUD; i++)
          {
            if(mouseX>130+CUDX+i*55&&mouseX<130+25+CUDX+i*55&&mouseY>85+CUDY&&mouseY<85+25+CUDY)
            {
              boolean WSXY = true;            
              if(!(ClickThreeCX>130+CUDX+i*55&&ClickThreeCX<130+25+CUDX+i*55&&ClickThreeCY>85+CUDY&&ClickThreeCY<85+25+CUDY)&&threeCBAppear)
              {
                threeCBAppear = false;
                ClickThreeCX = 0;
                ClickThreeCY = 0;
                WSXY = false;
              }
              if(WSXY)
              {
                threeCBAppear = true;
                ClickThreeCX = mouseX;
                ClickThreeCY = mouseY;
                TCBAM = 1;
                int GDU = 0;                  //GraphDisappearUp
                int threeCUDCount = threeCUD;
                while(threeCUDCount!=9)
                {
                  threeCUDCount++;
                  GDU = GDU+threeCUDCount;
                }
                GDU = GDU+i+1;
                if(SDM==GDU)
                {
                  if(Ball[choiceThreeNumU[GDU][0]-1]!=null&&Ball[choiceThreeNumU[GDU][1]-1]!=null&&Ball[choiceThreeNumU[GDU][2]-1]!=null)
                  {
                    threeBallStack[0] = Ball[choiceThreeNumU[GDU][0]-1];
                    threeBallStack[1] = Ball[choiceThreeNumU[GDU][1]-1];
                    threeBallStack[2] = Ball[choiceThreeNumU[GDU][2]-1];
                    TBSN[0] = choiceThreeNumU[GDU][0]-1;
                    TBSN[1] = choiceThreeNumU[GDU][1]-1;
                    TBSN[2] = choiceThreeNumU[GDU][2]-1;
                    Ball[choiceThreeNumU[GDU][0]-1] = null;
                    Ball[choiceThreeNumU[GDU][1]-1] = null;
                    Ball[choiceThreeNumU[GDU][2]-1] = null;
                    RUD = 1;
                    WR = true;
                  }
                }
                else
                  SDM = GDU;
                println("CUD:"+threeCUD+"，"+i+" GDU:"+GDU);
              }
            }
          }
          threeCUD = threeCUD-1;
          CUDY = CUDY+46;
          CUDX = CUDX+25;        
        }
        int threeCDD = 8;            //下三角中間點數量(threeCircleDownDot)
        int CDDX =0;                 //間隔
        int CDDY = 0;
        while(threeCDD>0)
        {
          for(int i=0; i<threeCDD; i++)
          {
            if(mouseX>155+CDDX+i*55&&mouseX<155+25+CDDX+i*55&&mouseY>96+CDDY&&mouseY<96+25+CDDY)
            {         
              boolean WSXY = true;            
              if(!(ClickThreeCX>155+CDDX+i*55&&ClickThreeCX<155+25+CDDX+i*55&&ClickThreeCY>96+CDDY&&ClickThreeCY<96+25+CDDY)&&threeCBAppear)
              {
                threeCBAppear = false;
                ClickThreeCX = 0;
                ClickThreeCY = 0;
                WSXY = false;
              }
              if(WSXY)
              {
                threeCBAppear = true;
                ClickThreeCX = mouseX;
                ClickThreeCY = mouseY;
                TCBAM = 2;
                int GDD = 0;                  //GraphDisappearDown
                int threeCDDCount = threeCDD;
                while(threeCDDCount!=8)
                {
                  threeCDDCount++;
                  GDD = GDD+threeCDDCount;
                }
                GDD = GDD+i+1;
                if(SDM==GDD+50)
                {
                  if(Ball[choiceThreeNumD[GDD][0]-1]!=null&&Ball[choiceThreeNumD[GDD][1]-1]!=null&&Ball[choiceThreeNumD[GDD][0]-1]!=null)
                  {
                    threeBallStack[0] = Ball[choiceThreeNumD[GDD][0]-1];
                    threeBallStack[1] = Ball[choiceThreeNumD[GDD][1]-1];
                    threeBallStack[2] = Ball[choiceThreeNumD[GDD][2]-1];
                    TBSN[0] = choiceThreeNumD[GDD][0]-1;
                    TBSN[1] = choiceThreeNumD[GDD][1]-1;
                    TBSN[2] = choiceThreeNumD[GDD][2]-1;
                    Ball[choiceThreeNumD[GDD][0]-1] = null;
                    Ball[choiceThreeNumD[GDD][1]-1] = null;
                    Ball[choiceThreeNumD[GDD][2]-1] = null;
                    RUD = 2;
                    WR = true;
                  }
                }
                else
                  SDM = GDD+50;
                println("CDD:"+threeCDD+"，"+i+" GDD:"+GDD);
              }
            }
          }
          threeCDD = threeCDD-1;
          CDDY = CDDY+46;
          CDDX = CDDX+25;        
        }
     }
       break;
   }
}
void Appeartext (String message, int x, int y , int size)
{
  PFont text;
  text = createFont("標楷體",30);
  textFont(text,size);
  textAlign(CENTER);
  text(message,x,y);
}
void IllustrateBall()
{
  for(int i=13; i<18; i++)
  {
    if(i-13==2)
      IllustrateBall[i-13] = BallColor[3];
    else
      IllustrateBall[i-13] = BallColor[1];
    IllustrateBallX[i-13] = BallX[i]+100;
    IllustrateBallY[i-13] = BallY[i]+250;
    if(i-6==9)
      IllustrateBall[i-6] = BallColor[4];
    else
      IllustrateBall[i-6] = BallColor[5];
    IllustrateBallX[i-6] = BallX[BLAO[i]]-100;
    IllustrateBallY[i-6] = BallY[BLAO[i]]+150;
  }
  IllustrateBall[5] = BallColor[1];
  IllustrateBallX[5] = BallX[23]+100;
  IllustrateBallY[5] = BallY[23]+250;
  IllustrateBall[6] = BallColor[2];
  IllustrateBallX[6] = BallX[24]+100;
  IllustrateBallY[6] = BallY[24]+250;
  IllustrateBall[12] = BallColor[5];
  IllustrateBallX[12] = BallX[BLAO[23]]-100;
  IllustrateBallY[12] = BallY[BLAO[23]]+150;
  IllustrateBall[13] = BallColor[3];
  IllustrateBallX[13] = BallX[BLAO[24]]-100;
  IllustrateBallY[13] = BallY[BLAO[24]]+150;
}