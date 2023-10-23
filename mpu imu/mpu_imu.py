from imu import MPU6050
from time import sleep
from machine import Pin, I2C, RTC, SoftI2C

i2c = SoftI2C(sda=Pin(21), scl=Pin(22), freq=400000)
imu = MPU6050(i2c)

rtc = RTC()
rtc.datetime((2023, 10, 23, 14, 27,0,0,0))
rtc.datetime()

info_actividad = {}



while True:
    accel_list = [['x'], ['y'],['z']]
    gyro_list = [['x'], ['y'],['z']]
    for _ in range (15):
        ax=round(imu.accel.x,2)
        ay=round(imu.accel.y,2)
        az=round(imu.accel.z,2)
        gx=round(imu.gyro.x)
        gy=round(imu.gyro.y)
        gz=round(imu.gyro.z)
        
        accel_list[0].append(ax)
        accel_list[1].append(ay)
        accel_list[2].append(az)
        gyro_list[0].append(gx)
        gyro_list[1].append(gy)
        gyro_list[2].append(gz)
        sleep(0.1)
    
    delta_accel_x = accel_list[0][15] - accel_list[0][1]
    delta_accel_y = accel_list[1][15] - accel_list[1][1]
    delta_accel_z = accel_list[2][15] - accel_list[2][1]
    delta_gyro_x = gyro_list[0][15] - gyro_list[0][1]
    delta_gyro_y = gyro_list[1][15] - gyro_list[1][1]
    delta_gyro_z = gyro_list[2][15] - gyro_list[2][1]
    
    
    '''print("                  ax",ax,"\t","ay",ay,"\t","az",az,"\t","gx",gx,"\t","gy",gy,"\t","gz",gz,"\t","        ",end="\r")'''
    
    if ((delta_accel_x <= -0.98) and(delta_accel_y < 0.22) and (delta_accel_z <= -0.98) and(delta_gyro_y >= 0)):
        print("Trip")
        estado = "Tropiezo"
        fecha_hora = RTC.now()
        diccionario_temporal = {'dia y hora': fecha_hora, 'estado': estado}
        diccionario [fecha_hora] = diccionario_temporal
    
    elif ((delta_accel_x >= 0.98) and(delta_accel_y < 0.22) and (delta_accel_z <= -0.98) and(delta_gyro_y >= 0)):
        print("Slip")
        estado = "Resbalon"
        fecha = rtc.now([0],[1],[2])
        hora = rtc.now([3],[4])
        print (fecha)
        print(hora)
        diccionario_temporal = {'dia y hora': fecha_hora, 'estado': estado}
        diccionario [fecha_hora] = diccionario_temporal
    
    elif ((ax == -0.98) and (ay >= -0.02) and (az == 0.00) and (gy < 0)):
        print('fall')
        estado = "Tropiezo"
        fecha_hora = rtc.now()
        diccionario_temporal = {'dia y hora': fecha_hora, 'estado': estado}
        diccionario [fecha_hora] = diccionario_temporal
    
    else:
        print('Estado normal')
        estado = "Normal"
        fecha= rtc.now([0],[1],[2])
        hora = rtc.now ([3], [4])
        diccionario_temporal = {'dia y hora': fecha_hora, 'estado': estado}
        diccionario [fecha_hora] = diccionario_temporal
    
    
    sleep(2)