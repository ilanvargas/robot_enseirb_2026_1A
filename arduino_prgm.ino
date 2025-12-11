void setup() {
    Serial.begin(9600);
    while (!Serial) ;
    Serial.println("ESP32 Echo Ready!");
}

void loop() {
    if (Serial.available()) {
        String recieved_msg = Serial.readStringUntil('\n');
        if (recieved_msg[0] == 's') 
        Serial.println(recieved_msg);
    }
}

void stepper_control(String msg){
    char left_dir = msg[2];
    char right_dir = msg[4];
    // TODO
}
