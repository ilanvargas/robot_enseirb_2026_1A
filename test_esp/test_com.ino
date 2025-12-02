void setup() {
  Serial.begin(9600);
  delay(1000); // Attendre que le Serial soit prêt
  Serial.println("ESP demarre !");
}

void loop() {
  Serial.println("Test - ESP fonctionne");
  delay(1000);
}