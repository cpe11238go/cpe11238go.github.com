void Reset()
{
  score = 0;
  int Gcount = 12;            //設置第一排只有10顆球，之所以+2是因為第一顆球的X座標起始位置在95
  int GBY =60;
  int GBX = 0;
  int BallCount = 0;
  scoretime = 100;
  nowsecond = second();
  while(Gcount>2)
  {
    for(int i=95; i<Gcount*50; i=i+55)
    {
        Ball[BallCount] = BallColor[(int)random(1,6)];
        BallX[BallCount] = i+GBX;
        BallY[BallCount] = GBY;
        BallCount++;
    }
    Gcount = Gcount-1;
    GBY = GBY+46;
    GBX = GBX+25;  
  }
  for(int i=0; i<55; i++)
  {
    DL[i] = -1;
    RCDL[i] = -1;
  }
}