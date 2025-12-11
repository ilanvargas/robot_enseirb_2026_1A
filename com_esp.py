import serial
import time

PORT = '/dev/ttyUSB0'
BAUDRATE = 9600
TIMEOUT = 2

# TODO : error handleing

def init():
    global ser
    ser = serial.Serial(PORT, BAUDRATE, timeout=TIMEOUT)
    print(f"Connexion, port: {PORT}, baudrate: {BAUDRATE}")
    
    time.sleep(2)
    
    ser.reset_input_buffer()
    ser.reset_output_buffer()
    
    if ser.in_waiting > 0:
        startup_msg = ser.readline().decode('utf-8').strip()
        print(f"ESP32: {startup_msg}\n")
    
def close():
    global ser
    ser.close()

def send_text(msg : str):
    global ser
    ser.write(f"{msg}\n".encode('utf-8'))
    response = ser.readline().decode('utf-8').strip()
    
    if response != msg:
        # TODO : error handleing
        print("Unexpected result\n")

def recover_from_interuption():
    # TODO
    pass

