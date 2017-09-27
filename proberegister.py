import time
import serial

ser = serial.Serial()
ser.port = "/dev/ttyS3"
ser.baudrate = 38400
ser.parity=serial.PARITY_NONE
ser.stopbits=serial.STOPBITS_ONE
ser.bytesize=serial.EIGHTBITS

try:
	ser.open()
except Exception, e:
	print("error open serial port: " + str(e))
	exit()

ser.isOpen()

d = raw_input("Which Netrounds Account do you want to register the TA to?" + '\r\n' + ">>")
n = raw_input("What du you want to call the TA?" + '\r\n' + ">>")

ser.write("root" + '\r\n')
time.sleep(1)
ser.write("27mars27mars" + '\r\n')
time.sleep(2)
ser.write("""genalyzer_register --unregister""" + '\r\n')
time.sleep(2)
ser.write("genalyzer_register --server login.netrounds.com --domain " + d + " --email proberegister@netrounds.com --password Registrera1 --name " + n + '\r\n')

out = ser.read()
	
if out == '':
	ser.close()
	exit()

else:
	print('\r\n' + "Success!" + '\r\n')
	ser.close
	exit()