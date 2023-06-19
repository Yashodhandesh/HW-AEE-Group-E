#include <SPI.h>
#include <WiFiNINA.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <ArduinoMqttClient.h>

char ssid[] = "YASH";
char pass[] = "yash2345";

#define KY001_Signal_PIN 4

OneWire oneWire(KY001_Signal_PIN);
DallasTemperature sensors(&oneWire);
int heartPin = A0;

WiFiClient wifiClient;
MqttClient mqttClient(wifiClient);

const char broker[] = "192.168.181.180";
int        port     = 1883;
const char topic[]  = "HWE";

void setup() {
   Serial.begin(9600);
   WiFi.begin(ssid, pass);
   pinMode(heartPin, INPUT);
  sensors.begin();
  mqttClient.connect(broker, port);

}

void loop() {
  mqttClient.poll();

  sensors.requestTemperatures();
  float temperature = sensors.getTempCByIndex(0);
  int heartValue = analogRead(heartPin);
  int heartBPM = calculateHeartRate(heartValue);

   mqttClient.beginMessage(topic);
   
    mqttClient.print(heartBPM);
    mqttClient.print(" (BPM)");
   mqttClient.endMessage();
   delay(1400);
      mqttClient.beginMessage(topic);
    
  mqttClient.print(temperature);
     mqttClient.print(" Celsius");
    mqttClient.endMessage();

  delay(1400);
}

int calculateHeartRate(int heartValue) {
  // Adjust the following values for your heart rate sensor
  const int minValue = 300;  // Minimum sensor value
  const int maxValue = 800;  // Maximum sensor value
  const int minBPM = 40;    // Minimum heart rate (BPM)
  const int maxBPM = 200;   // Maximum heart rate (BPM)

  // Map the sensor value to the heart rate range
  int mappedValue = map(heartValue, minValue, maxValue, minBPM, maxBPM);

  return mappedValue;
}
