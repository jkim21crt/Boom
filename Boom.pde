import processing.serial.*;

import cc.arduino.*;

Arduino arduino;
PImage death;
PImage UI;
PImage Schem;
int minu;
int seco = 59;
int pwmValue;
int counter;
int PIR;
int d = 0;
int analogFill;
Timer timer;
int countAmount = 299;
void setup() {
    size(1680,1050);
    UI = loadImage("UI.png");
    death = loadImage("death.png");
    
    println(Arduino.list()); // NEED TO KNOW WHAT PORT
    arduino = new Arduino(this, Arduino.list()[0], 57600); // CHANGE ARRAY INDEX TO MATCH PORT NUMBER
    //arduino.pinMode(0, Arduino.INPUT);//Potentiometer
    arduino.pinMode(0, Arduino.INPUT);//Tilt
    arduino.pinMode(4, Arduino.INPUT); //PIR
    arduino.pinMode(11, Arduino.OUTPUT);//Servo
    arduino.pinMode(3, Arduino.OUTPUT);//LED
    arduino.pinMode(7, Arduino.OUTPUT); //buzzer

    timer = new Timer(1000);
    noStroke();
}

void draw() {
    image(UI,0,0);
    minu = countAmount/60;
  
     if(d ==1){
      death(); 
     }
     
     
    if(arduino.digitalRead(4)==Arduino.HIGH && counter==0)  //PIR            ///PIR sensor Pwm and Time Trigger
    {
      println("hot");
      timer.start(); 
     counter = 1;
    }
    if(counter==1){
      
      if(arduino.analogRead(0) == Arduino.HIGH)         /// TIlt switch
     {
       println("tilt");
      d=1;
     }
      
    if (timer.isFinished()) {
    countAmount--;
    
    arduino.digitalWrite(3, 255);      // LED
    arduino.analogWrite(7, 255);      //buzzer
    
    if(seco>-1)
    {
     seco--;
    }
    if(countAmount==299 || countAmount==239 || countAmount==179 || countAmount==119 || countAmount== 59)
    {
      seco = 59;
    }
    
    timer.start();
  }
    }
    //ANALOG OUTPUT (PWM)
    //arduino.analogWrite(11, 0); // OFF
    //arduino.analogWrite(11, 255); // ON
    //arduino.analogWrite(11, 128); // 50%

    if(countAmount>0 && d==0){
      textSize(40);
    text(minu,1230,140);
    text(seco,1270,140);
  }
    
  
  else{
   d=1;
      }
      
      if(keyPressed){
       if(key == 'q'){
        text("ABORTED BY USER", 50, 50);
       arduino.analogWrite(11,0);
       noLoop();
       }
      }

}


void death(){
  image(death,0,0);
 
  arduino.analogWrite(11, 180);
 

   // Trigger switch
    
  
}

