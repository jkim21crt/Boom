import processing.serial.*;

import cc.arduino.*;
Arduino arduino;
PImage death;
PImage UI;
PImage Ahit;
PImage Bhit;
PImage Chit;
PImage Dhit;
PImage Ehit;
PImage Fhit;
PImage Ghit;
PImage Hhit;
PImage Ihit;

PImage entre;
PImage clear;

int minu;
int seco = 59;
int pwmValue;
int counter;
int PIR;
int d = 0;
int analogFill;

int slot1 = 0;
int slot2 = 0;
int slot3 = 0;
int slot4 = 0;
int slot5 = 0;
int slot6 = 0;
int slot7 = 0;
int slot8 = 0;
int slot9 = 0;
int unlock = 0;
int wrong = 0;
int charge = 0;
Timer timer;
int countAmount = 299;
void setup() {
    size(1680,1050);
    UI = loadImage("UI.png");
    death = loadImage("death.png");
     Ahit = loadImage("1hit.png");
    Bhit = loadImage("2hit.png");
    Chit = loadImage("3hit.png");
    Dhit = loadImage("4hit.png");
    Ehit = loadImage("5hit.png");
    Fhit = loadImage("6hit.png");
    Ghit = loadImage("7hit.png");
    Hhit = loadImage("8hit.png");
    Ihit = loadImage("9hit.png");
    entre = loadImage("enter.png");
    clear = loadImage("reset.png");
    
    
    
    println(Arduino.list()); // NEED TO KNOW WHAT PORT
    arduino = new Arduino(this, Arduino.list()[0], 57600); // CHANGE ARRAY INDEX TO MATCH PORT NUMBER
    //arduino.pinMode(0, Arduino.INPUT);//Potentiometer
    arduino.pinMode(0, Arduino.INPUT);//Tilt
    arduino.pinMode(4, Arduino.INPUT); //PIR
    arduino.pinMode(11, Arduino.OUTPUT);//Servo
    arduino.pinMode(3, Arduino.OUTPUT);//LED
    arduino.pinMode(7, Arduino.OUTPUT); //buzzer
   
    timer = new Timer(1000);
}

void draw() {
    image(UI,0,0);
    minu = countAmount/60;
    
     if(counter==0)  //PIR            ///PIR sensor Pwm and Time Trigger
    {
      timer.start(); 
     counter = 1;
    }
    if(counter==1){

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
     if(countAmount>0 && d==0){
      textSize(40);   
    text(minu,1255,125);
    text(seco,1295,125);
  }
  else{
   d=1;
      }

     
     ////////////////////////
   
   
    if(charge<20){
     charge++; 
    } 
    if(charge==20)
    { 
    
    if(mouseX>110&&mouseX<215&&mouseY>450&&mouseY<610 && mousePressed){
     slot1++;
     if(slot1>2)
     {
      wrong = 1; 
     }
     charge = 0;
    }
    
    if(mouseX>225&&mouseX<330&&mouseY>450&&mouseY<610&&mousePressed){
      slot2++;
      if(slot9==1 && slot2==1){ 
      unlock = 1; 
     }
     else{
 
      wrong = 1; 
     }
     charge = 0;
      } 
    
    if(mouseX>345&&mouseX<445&&mouseY>450&&mouseY<610&&mousePressed){
      slot3++;
      if(slot1==2 && slot3==1)
      {
       wrong = 0;
      }
      else{
       wrong = 1; 
      }
      charge = 0;
        }
      
    
    if(mouseX>110&&mouseX<215&&mouseY>615&&mouseY<795&&mousePressed){
     slot4++;
     wrong = 1;
     charge = 0;
        } 
      
    if(mouseX>225&&mouseX<330&&mouseY>615&&mouseY<795&&mousePressed){
       slot5++;  
       wrong = 1;
       charge = 0;
        }
      
    if(mouseX>345&&mouseX<445&&mouseY>615&&mouseY<795&&mousePressed){
      slot6++;
      wrong = 1;
      charge = 0;
        }
      
    
    if(mouseX>110&&mouseX<215&&mouseY>800&&mouseY<900&&mousePressed){
      slot7++;
      wrong = 1;
      charge = 0;
        }
     
    if(mouseX>225&&mouseX<330&&mouseY>800&&mouseY<900&&mousePressed){
      slot8++; 
      wrong = 1;
      charge = 0;
       
        }
      
    if(mouseX>345&&mouseX<445&&mouseY>800&&mouseY<900&&mousePressed){
     slot9++;   
      if(slot3==1 && slot9==1){
          wrong = 0;
         }
         else{
          wrong = 1; 
         }
         charge = 0;
    
          }
       
       
       
    
    if(mouseX>500&&mouseX<615&&mouseY>500&&mouseY<575 && mousePressed){   // ENTER
      
      image(entre,0,0);
      if(unlock==1 && wrong==0){
        text("ABORTED", width/2, height/2);
       arduino.analogWrite(11,0);  //motor
       arduino.digitalWrite(3, 0);      // LED
       arduino.analogWrite(7, 0);      //buzzer
       noLoop();
      }
      
      }
      
      
    if(mouseX>500&&mouseX<615&&mouseY>665&&mouseY<750 && mousePressed){    // Reset
      
      image(clear,0,0);
      slot1 = 0;
      slot2 = 0;
      slot3 = 0;
      slot4 = 0;
      slot5 = 0;
      slot6 = 0;
      slot7 = 0;
      slot8 = 0;
      slot9 = 0;
      unlock = 0;
      wrong = 0;
     charge = 0;
      
    }
    
    
   } ///charge end
   
    if(slot1>=1){ image(Ahit,0,0); }
    if(slot2>=1){ image(Bhit,0,0); }
    if(slot3>=1){ image(Chit,0,0); }
    
    if(slot4>=1){ image(Dhit,0,0); }
    if(slot5>=1){ image(Ehit,0,0); }
    if(slot6>=1){ image(Fhit,0,0); }
   
    if(slot7>=1){ image(Ghit,0,0); }
    if(slot8>=1){ image(Hhit,0,0); }
    if(slot9>=1){ image(Ihit,0,0); }


    //ANALOG OUTPUT (PWM)
    //arduino.analogWrite(11, 0); // OFF
    //arduino.analogWrite(11, 255); // ON
    //arduino.analogWrite(11, 128); // 50%

   
      
      if(d ==1){
      death(); 
     }
     
       if(counter==1){
       arduino.digitalWrite(3, 255);      // LED
      if(arduino.analogRead(0) == Arduino.HIGH)         /// TIlt switch
     {
       println("tilt");
      d=1;
     }
       }
      
}    
 
void death(){
  image(death,0,0);
 arduino.analogWrite(7, 255);      //buzzer
  arduino.analogWrite(11, 180);    //motor
 

   // Trigger switch
    
  
}

