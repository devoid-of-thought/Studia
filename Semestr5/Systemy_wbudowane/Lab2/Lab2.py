# Complete project details at https://RandomNerdTutorials.com/micropython-hc-sr04-ultrasonic-esp32-esp8266/
from hcsr04 import HCSR04
from time import sleep
from machine import Pin


# ESP32
sensor = HCSR04(trigger_pin=14, echo_pin=2, echo_timeout_us=10000)

# ESP8266
#sensor = HCSR04(trigger_pin=12, echo_pin=14, echo_timeout_us=10000)
yellow = Pin(16, Pin.OUT)
red= Pin(5,Pin.OUT)
green = Pin(4,Pin.OUT)
while True:
    distance = sensor.distance_cm()
    print('Distance:', distance, 'cm')
    sleep(1)
    if distance <= 50 and distance >=2:
        red.on()
        green.off()
        yellow.off()
    if distance > 50 and distance <= 100:
        red.off()
        green.off()
        yellow.on()
    if distance > 100:
        red.off()
        green.on()
        yellow.off()