from machine import Pin, ADC
from time import sleep

lm335 = Pin(19, Pin.OUT)
motor_dc = Pin(5, Pin.OUT)

adc_pin = ADC(Pin(33), atten=ADC.ATTN_11DB)

attenv  = 2450 / 1000
final = 0
while True:
    for _ in range(10):
        lm335.value(1)
        valor = adc_pin.read_uv() / 1000
        kelvin = (valor / 10) * 2
        celsius = (kelvin - 273.15) - 1.25
        final = celsius + final
    temp = final / 10
    final = 0
    print(temp)
    if (temp<=36 or temp>=37.5):
        motor_dc.value(1)
    else:
        motor_dc.value(0)
    sleep (2)
    
    
    