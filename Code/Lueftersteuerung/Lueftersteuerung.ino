/*************************************************************************************************
                                      PROGRAMMINFO
**************************************************************************************************
Funktion: Motordrehzahl PWM Steuerung 20kHz mit Potentiometer Steuerung 
Links-Rechtslauf Arduino II 149 Wohnmobil Tom
(Aufloesung 9 Bit = 512 Stufen).

**************************************************************************************************
Version: 12.04.2022
**************************************************************************************************
Board: UNO
**************************************************************************************************
C++ Arduino IDE V1.8.13
**************************************************************************************************
Einstellungen:
https://dl.espressif.com/dl/package_esp32_index.json
http://dan.drown.org/stm32duino/package_STM32duino_index.json
https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_dev_index.json
*************************************************************************************************
**************************************************************************************************/

#define potiPin 2 //Eingang Poti ist A2

int potiWert;
bool pwmStatus = true;

void setup() {
  Serial.begin(115200);

//Loeschen der Timer/Counter Control Register A und B
  TCCR1A = 0;
  TCCR1B = 0;

//Modus Fast PWM-Mode 9 Bit einstellen
  TCCR1A |= (0 << WGM10) | (1 << WGM11);
  TCCR1B |= (1 << WGM12);

//Vorteiler auf 1 setzen
  TCCR1B |= (1 << CS10);

//Nichtinvertiertes PWM-Signal setzen
  TCCR1A |= (1 << COM1A1);

//PWM-Pin 9 als Ausgang definieren
  DDRB |= (1 << DDB1);
}

void loop() {
  potiWert = analogRead(potiPin); //Potiwert einlesen (Auflösung Analogeingang = 10 Bit)


  //Anpassung PotiWert auf 10 Bit: 0-1023, keine Anpassung
  //Anpassung PotiWert auf 9 Bit: 0-511:
  //Anpassung PotiWert auf 8 Bit: 0-255:
  potiWert = map(potiWert, 0, 1023, 0, 511);

  
  if (potiWert == 0 && pwmStatus)
  {
    TCCR1A &= ~(1 << COM1A1); //COM1A1-Bit loeschen
    pwmStatus = false;
  }
  else if (potiWert > 0 && !pwmStatus)
  {
    TCCR1A |= (1 << COM1A1); //COM1A1-Bit setzen
    pwmStatus = true;
  }
 
  OCR1A = potiWert; // Setzen des Impuls-Pausenverhaeltnis

  Serial.println(potiWert);
  delay(15);
}
