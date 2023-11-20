from machine import Pin, PWM, ADC
from time import sleep
import urandom

pwm_pin = PWM(Pin(4), 1000)
adc_pin = ADC(Pin(34))

while True:
    duty_cycle = urandom.getrandbits(10)
    pwm_pin.duty(duty_cycle)
    irval = adc_pin.read_uv()/1000
    print(irval)
    sleep(2)