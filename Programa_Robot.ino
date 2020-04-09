#include <Servo.h> 
Servo myservo;  // Para el control de los servomotores
    char mensaje[10];  //Almacena el mensaje que enviamos en codigo ASCI
    byte posicion=0;  // Variable para cambiar la posición de los caracteres de la cadena.

    int Left_motor_go=8;
    int Left_motor_back=9;
    int Right_motor_go=10;
    int Right_motor_back=11;
    int myangle;
    Servo servo1;
    Servo servo2;
    int val_h10;
    int val_h11;
void setup() {
      Serial.begin(9600);//Inicializamos el puerto serial 1 del Arduino Mega
      pinMode(Left_motor_go,OUTPUT);
      pinMode(Left_motor_back,OUTPUT);
      pinMode(Right_motor_go,OUTPUT); 
      pinMode(Right_motor_back,OUTPUT);
      servo1.attach(2);
      servo2.attach(12);
      val_h10=0;
      val_h11=0;
      }

void loop() {
  if(Serial.available())
  {
    memset(mensaje, 0,sizeof(mensaje)); //Borra el contenido previo del mensaje
    while(Serial.available()>0)//Si recibe datos del celular...
        {
          delay(10);
          mensaje[posicion] = Serial.read(); // Lee un carácter y lo guarda en mensaje
          Serial.println(posicion,DEC);//Prueba...
          Serial.println(mensaje[posicion],DEC);//Prueba...
          posicion++;//Para guardar caracter por caracter
          if (mensaje[0] == 'A') //Motor izquierda avanza
          {
              digitalWrite(Right_motor_go,LOW); 
              digitalWrite(Right_motor_back,HIGH);
              analogWrite(Right_motor_go,0); 
              analogWrite(Right_motor_back,255);
              digitalWrite(Left_motor_go,LOW);
              digitalWrite(Left_motor_back,HIGH); //HIGH
              analogWrite(Left_motor_go,0); 
              analogWrite(Left_motor_back,255);  //255
          }
           if (mensaje[0] == 'B') //Adelante
          {
              digitalWrite(Right_motor_go,HIGH);
              digitalWrite(Right_motor_back,LOW);     
              digitalWrite(Left_motor_go,LOW);
              digitalWrite(Left_motor_back,HIGH);
          }
           if (mensaje[0] == 'C') //Motor derecha avanza
          {
              digitalWrite(Right_motor_go,HIGH);
              digitalWrite(Right_motor_back,LOW);
              analogWrite(Right_motor_go,255); 
              analogWrite(Right_motor_back,0);
              digitalWrite(Left_motor_go,LOW);
              digitalWrite(Left_motor_back,LOW);
              analogWrite(Left_motor_go,0); 
              analogWrite(Left_motor_back,0);
          }
           if (mensaje[0] == 'D') //Para
          {
              digitalWrite(Right_motor_go,LOW);
              digitalWrite(Right_motor_back,LOW);
              digitalWrite(Left_motor_go,LOW);
              digitalWrite(Left_motor_back,LOW);
          }
           if (mensaje[0] == 'E') //Motor izquierda atras
          {
              digitalWrite(Right_motor_go,LOW);
              digitalWrite(Right_motor_back,LOW);
              digitalWrite(Left_motor_go,HIGH);
              digitalWrite(Left_motor_back,LOW);
              analogWrite(Left_motor_back,255);
          }
           if (mensaje[0] == 'F') //Atras
          {
              digitalWrite(Left_motor_go,HIGH);
              digitalWrite(Left_motor_back,LOW);
              analogWrite(Left_motor_back,255);
              digitalWrite(Right_motor_go,HIGH);
              digitalWrite(Right_motor_back,LOW);
              analogWrite(Right_motor_back,255);
          }
           if (mensaje[0] == 'G') //Motor derecha atras
          {
              digitalWrite(Left_motor_go,LOW);
              digitalWrite(Left_motor_back,LOW);
              digitalWrite(Right_motor_go,HIGH);
              digitalWrite(Right_motor_back,LOW);
              analogWrite(Right_motor_back,255);
          }
           if (mensaje[0] == 'H') //Motor derecha atras
          {
    val_h10=val_h10+10;
         servo1.write(val_h10); 
          }
           if (mensaje[0] == 'I') //Motor derecha atras
          {
    val_h10=val_h10-10;
         servo1.write(val_h10); 
          }
           if (mensaje[0] == 'J') //Motor derecha atras
          {
    val_h11=val_h11+10;
         servo2.write(val_h11); 
          }
           if (mensaje[0] == 'K') //Motor derecha atras
          {
    val_h11=val_h11-10;
         servo2.write(val_h11); 
          }
      }
        
     posicion=0; //Se apunta a la primera posición de mensaje
  } 
      delay(100);  
}



