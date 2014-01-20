import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioOutput out;
SineWave sine;
WhiteNoise white;
float waveH = 50;
boolean playing = false;
String type = "sine";
String val = "220";

void setup() {
  size(512, 200);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
}
 
void draw() {
  background(0);
  stroke(255);
  for(int i = 0; i < out.bufferSize()-1; i++) {
    point(i, 50 + out.left.get(i)*waveH);
    point(i, 150 + out.right.get(i)*waveH);
  }
  disp();
}

void outSine(int Hz) {
  if(type == "whitenoise") playStop();
  if(!playing) startSine();
  sine.setFreq(Hz);
  Integer Hzc = new Integer(Hz);
  val = Hzc.toString();
}
void whitenoise() {
  if(playing) playStop();
  type = "whitenoise";
  playing = true;
  white = new WhiteNoise(1.0);
  out = minim.getLineOut(Minim.STEREO);
  out.addSignal(white);
  val = "-";
}

void disp() {
  text(type + " " + val,50,50);
}

void keyPressed() {
  char keyType = key;
  if(keyType == '1') {
    outSine(60);
  }else if(keyType == '2') {
    outSine(220);
  }else if(keyType == '3') {
    outSine(440);
  }else if(keyType == '4') {
    outSine(880);
  }else if(keyType == '5') {
    outSine(1760);  
  }else if(keyType == '6') {
    outSine(3520);  
  }else if(keyType == '7') {
    outSine(7040);  
  }else if(keyType == '8') {
    outSine(14080);
  }else if(keyType == '9') {
    whitenoise();
  }else if(keyType == ' ') {
    if(playing) {
      playStop();
    }else if(type == "sine") {
      startSine();
    }else if(type == "whitenoise") {
      whitenoise();
    }
  }
}

void startSine() {
  out = minim.getLineOut(Minim.STEREO);
  sine = new SineWave(220, 1.0, out.sampleRate());
  out.addSignal(sine);
  playing = true;
  type = "sine";
}
void playStop() {
  playing = false;
  out.close();
}
void stop() {
  playing = false;
  out.close();
  minim.stop();
}
