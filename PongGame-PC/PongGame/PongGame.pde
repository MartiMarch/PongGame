import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress direccionRemota;
Campo campo = new Campo(); 
Jugador jugadorIzq, jugadorDer;
Pelota pelota;
int goles1, goles2, contadorIzq, contadorDer, puerto = 12000, posicionYIzq;
boolean salvadaIzq, salvadaDer, inicio, empezar = false;
final static String IP = "192.168.1.33";

public void setup(){
 size(1020, 720);
 goles1 = 0;
 goles2 = 0;
 contadorIzq = 0;
 contadorDer = 0;
 salvadaIzq = false;
 salvadaDer = false;
 inicio = true;
 campo = new Campo();
 pelota = new Pelota();
 jugadorIzq = new Jugador(0, pelota.getRadio());
 jugadorDer = new Jugador(width-20 , pelota.getRadio());
 initNetworkConnection();
}

public void draw(){
  campo.dibujar();
  jugadorIzq.setPosicion(posicionYIzq);
  jugadorIzq.dibujar();
  jugadorDer.dibujar();
  
  textSize(20);
  fill(255, 255, 255);
  text(goles2, width/2-60, 20);

  textSize(20);
  fill(255, 255, 255);
  text(goles1, width/2+40, 20);
  
  if(keyPressed)
  {
    switch(key)
    {
      case 'w':
        jugadorDer.setY("UP");
        break;
      case 'W':
        jugadorDer.setY("UP");
        break;
      case 's':
        jugadorDer.setY("DOWN");
        break;
      case 'S':
        jugadorDer.setY("DOWN");
        break;
      case CODED:
        if(keyCode == UP)
        {
          jugadorDer.setY("UP");
        }
        else if(keyCode == DOWN)
        {
          jugadorDer.setY("DOWN");
        }
        break;
      default:
        break;
    }
    OscMessage mensaje = new OscMessage("posicionContrincante");
    mensaje.add(jugadorDer.getPosicion() * 100 / height);
    oscP5.send(mensaje, direccionRemota);
  }
  
  if(empezar)
  {
    pelota.dibujar();
    OscMessage mensaje = new OscMessage("posicionPelota");
    mensaje.add(pelota.getX() * 100 / width);
    mensaje.add(pelota.getY() * 100 / height);
    oscP5.send(mensaje, direccionRemota);
    
    mensaje = new OscMessage("puntuaciones");
    mensaje.add(goles1);
    mensaje.add(goles2);
    oscP5.send(mensaje, direccionRemota);
    
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
      ++goles2;
      pelota.setUbicacion(width/2, height/2);
      jugadorIzq.setPosicion(height/2);
      jugadorDer.setPosicion(height/2);
    }
    else if(campo.tocandoExtremo(pelota.getX()) == 3)
    {
      ++goles1;
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

public void iniciarPartida()
{
  OscMessage mensaje = new OscMessage("empezar");
  oscP5.send(mensaje, direccionRemota);
}

void oscEvent(OscMessage mensajeRecibido) {
  if(mensajeRecibido.checkTypetag("i"))
  {
    posicionYIzq = mensajeRecibido.get(0).intValue();
    posicionYIzq = posicionYIzq * height / 100;
  }
  else if(mensajeRecibido.addrPattern().equals("empezar"))
  {
    empezar = true;
  }
}

void initNetworkConnection()
{
  oscP5 = new OscP5(this, puerto);
  direccionRemota = new NetAddress(IP, puerto);
}
