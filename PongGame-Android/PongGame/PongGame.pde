import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress direccionRemota;
Campo campo = new Campo(); 
Jugador jugadorIzq, jugadorDer;
Pelota pelota;
int goles1, goles2, contadorIzq, contadorDer, posicionY, puerto = 12000;
boolean salvadaIzq, salvadaDer, empezar = false;
float posicionPelotaX = width / 2, posicionPelotaY = height / 2, posicionJugDer = height /2;
final static String IP = "192.168.1.35";

public void setup(){
 fullScreen();
 orientation(LANDSCAPE);
 goles1 = 0;
 goles2 = 0;
 contadorIzq = 0;
 contadorDer = 0;
 salvadaIzq = false;
 salvadaDer = false;
 posicionY = 0;
 campo = new Campo();
 pelota = new Pelota();
 jugadorIzq = new Jugador(0, pelota.getRadio());
 jugadorDer = new Jugador(width-20 , pelota.getRadio());
 initNetworkConnection();
}

public void draw(){
  campo.dibujar();
  jugadorIzq.setY(posicionY);
  jugadorIzq.dibujar();
  jugadorDer.setPosicion(posicionJugDer);
  jugadorDer.dibujar();
  
  textSize(20);
  fill(255, 255, 255);
  text(goles2, width/2-60, 20);
  
  textSize(20);
  fill(255, 255, 255);
  text(goles1, width/2+40, 20);
    
  if(empezar)
  {
    pelota.setX(posicionPelotaX);
    pelota.setY(posicionPelotaY);
    pelota.dibujar();
    if(contadorIzq == 15)
    {
      contadorIzq = 0;
      salvadaIzq = false;
    }
    if(contadorDer == 15)
    {
      contadorDer = 0;
      salvadaDer = false;
    }
    
    if((campo.tocandoExtremo(pelota.getX()) == 1 && jugadorIzq.estaDentro(pelota.getX(), pelota.getY())) || salvadaIzq)
    {
      salvadaIzq = true;
    }
    else if((campo.tocandoExtremo(pelota.getX()) == 1 && jugadorDer.estaDentro(pelota.getX(), pelota.getY())) ||  salvadaDer)
    {
      salvadaDer = true;
    }
    else if(campo.tocandoExtremo(pelota.getX()) == 2)
    {
      pelota.setUbicacion(width/2, height/2);
      jugadorIzq.setPosicion(height/2);
      jugadorDer.setPosicion(height/2);
    }
    else if(campo.tocandoExtremo(pelota.getX()) == 3)
    {
      pelota.setUbicacion(width/2, height/2);
      jugadorIzq.setPosicion(height/2);
      jugadorDer.setPosicion(height/2);
    }
    ++contadorIzq;
    ++contadorDer;
    iniciarPartida();
  }
  else
  {
    iniciarPartida();
  }
}
  
void mousePressed()
{
  posicionY = mouseY;
  OscMessage mensaje = new OscMessage("posicionY");
  mensaje.add(posicionY * 100 / height);
  oscP5.send(mensaje, direccionRemota);
}
  
void mouseDragged()
{
  posicionY = mouseY;
  OscMessage mensaje = new OscMessage("posicionY");
  mensaje.add(posicionY * 100 / height);
  oscP5.send(mensaje, direccionRemota);
}

void mouseReleased()
{
  posicionY = mouseY;
  OscMessage mensaje = new OscMessage("posicionY");
  mensaje.add(posicionY * 100 / height);
  oscP5.send(mensaje, direccionRemota);
}

void initNetworkConnection()
{
  oscP5 = new OscP5(this, puerto);
  direccionRemota = new NetAddress(IP, puerto);
}

public void iniciarPartida()
{
  OscMessage mensaje = new OscMessage("empezar");
  oscP5.send(mensaje, direccionRemota);
}

void oscEvent(OscMessage mensajeRecibido) {
  if(mensajeRecibido.addrPattern().equals("posicionPelota"))
  {
    posicionPelotaX = mensajeRecibido.get(0).floatValue();
    posicionPelotaY = mensajeRecibido.get(1).floatValue();
    posicionPelotaX = posicionPelotaX * width / 100;
    posicionPelotaY = posicionPelotaY * height / 100;
  }
  else if(mensajeRecibido.addrPattern().equals("empezar"))
  {
    empezar = true;
  }
  else if(mensajeRecibido.addrPattern().equals("puntuaciones"))
  {
    goles1 = mensajeRecibido.get(0).intValue();
    goles2 = mensajeRecibido.get(1).intValue();
  }
  else if(mensajeRecibido.addrPattern().equals("posicionContrincante"))
  {
    posicionJugDer = mensajeRecibido.get(0).floatValue();
    posicionJugDer =  posicionJugDer * height / 100;
  }
}
