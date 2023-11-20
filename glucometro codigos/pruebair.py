from machine import Pin, ADC
from time import sleep

ledir = Pin(4, Pin.OUT)

while True:
    ledir.value(1)
    sleep(2)
    ledir.value(0)
    sleep(2)