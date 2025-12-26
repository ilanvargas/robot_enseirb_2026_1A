#define RECIEVING_BUFFER_SIZE 20

char revieving_buffer[RECIEVING_BUFFER_SIZE];

void setup() {
    Serial.begin(9600);
    while (!Serial);
    Serial.println("ESP32 Echo Ready!");
}

void loop() {
    if (Serial.available()) {
        Serial.readStringUntil('\n')
            .toCharArray(revieving_buffer, RECIEVING_BUFFER_SIZE);
        if (revieving_buffer[0] == 's') {
            stepper_control(revieving_buffer);
            Serial.println(revieving_buffer);
        }
    }
}

void stepper_control(char* msg){
    char left_dir = msg[2];
    char right_dir = msg[4];
    
    char 
}
