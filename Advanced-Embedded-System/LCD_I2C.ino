#include <Wire.h>
#include <LiquidCrystal_I2C.h>          // library for LCD with I2C
#include <SPI.h>
#include <WiFiNINA.h>
#include <ArduinoMqttClient.h>


char ssid[] = "YASH";
char pass[] = "yash2345";

LiquidCrystal_I2C lcd(0x3F, 16, 2);     // Set the LCD address (0x27) and size of lcd (16 chars and 2 line display)

WiFiClient wifiClient;
MqttClient mqttClient(wifiClient);

const char broker[] = "192.168.181.180";
int        port     = 1883;
const char topic[]  = "HWE";
String result;
void setup()
{
  Serial.begin(9600);
  lcd.init();         // initialize the LCD
 lcd.backlight();
  WiFi.begin(ssid, pass);
  delay(5000);
  mqttClient.connect(broker, port);
  mqttClient.subscribe(topic);
  
}

void loop()
{

 mqttClient.poll();
   
   lcd.clear();                      // clear the LCD
  lcd.setCursor (0, 0);
  int messageSize = mqttClient.parseMessage();
  if (messageSize) {  
  while (mqttClient.available()) {
  lcd.print((char) mqttClient.read());// print the message
 delay(50);
   }
  }
 }
