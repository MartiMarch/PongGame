class Campo{
  
  public Campo(){}
  
  public void dibujar()
  {
    fill(0, 0, 0);
    rect(0, 0, width, height);
    fill(255, 255, 255);
    rect(width/2-10, 0, 10, height);
    rect(width/2, 0, 10, height);
  }
  
  public int tocandoExtremo(float x)
  {
    int dentro = 0;
    if(x > 0 && x < width)
    {
      dentro = 1;
    }
    else if(x < 0)
    {
      dentro = 2;
    }
    else if(x > width)
    {
      dentro = 3;
    }
    return dentro;
  }
}
