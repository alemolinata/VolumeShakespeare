// A Niff!

// A Niff doesn't like it when you scream or make loud noises. He becomes very uneasy, really.

// Importing libraries to connect to server
import ciid2015.exquisitdatacorpse.*;
import oscP5.*;
import netP5.*;

NetworkClient mClient;
float volume;

// Floats for changing LEFT & RIGHT size of eyes
float lSize;
float rSize;
// floats for changing the background colour
float backRColor;
float backLColor;

// Distance used in mouth
int d = 100;

// Floats for LEFT & RIGHT bezier points used to change mouth-shape
float lBezier;
float rBezier;

void setup(){
  size(1200,800);
  mClient = new NetworkClient(this, "edc.local", "ale");
}

void draw(){
  
  // BACKGROUND
  // Mapping values to be used in changing background colour according to volume. As the Niff stresses it gets red
  backRColor = map(volume,0,1,0,255);
  backLColor = map(volume,0,1,255,0);
  // changing background colour
  background(backRColor, backLColor/2,  backLColor);
  
  // EYES
  // Mapping values to be used in sizing eyes according to volume  
  lSize = map(volume,0,1,200,0);
  rSize = map(volume,0,1,200,0);
  noStroke();
  
  // Drawing shadow for eyes
  fill(0,0,0,80);
  ellipse(width/3, height/2-40, lSize, lSize);
  ellipse(width/3*2, height/2-40, rSize, rSize);
  
  // Drawing eyes
  fill(255);
  ellipse(width/3, height/2-50, lSize, lSize);
  ellipse(width/3*2, height/2-50, rSize, rSize);
  
  
  // MOUTH
  // Mouth moves according to volume as well. When it's quiet it's happy, medium amplitude he is serious, and high volume, stressed.
  noFill();
  strokeWeight(6);
  
  // Mapping values for RIGHT side of the mouth.
  // It moves up to make a straight line as it gets closer to the mid-tones, but then goes down again as it gets louder
  if(volume<0.5){
    rBezier = map(volume, 0, 0.5, 100, 0);
  }
  else{
    rBezier = map(volume, 0.5, 1, 0, 100);
  }
  // Mapping values for LEFT side of the mouth.
  // It moves down when it's quiet and up when it's louder
  lBezier = map(volume, 0, 1, 100, -100);
  
  // Drawing shadow of mouth
  stroke(0,80);
  bezier(width/2-d, (height/2+d)+6, width/2-d/2, (height/2+lBezier+d)+6, width/2+d/2, (height/2+rBezier+d)+6, width/2+d, (height/2+d)+6);
  
  // Drawing actual mouth
  stroke(255);
  bezier(width/2-d, height/2+d, width/2-d/2, height/2+lBezier+d, width/2+d/2, height/2+rBezier+d, width/2+d, height/2+d);

}

void receive(String name, String tag, float x){
  if(name.equals("max") && tag.equals("amp")){
    volume = x;
    println("volume " + x);
  }
}

