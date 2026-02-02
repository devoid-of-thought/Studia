import dht # type: ignore
from machine import Pin # type: ignore
import socket #type: ignore
import network # type: ignore
import time
import machine # type: ignore


def connect_wifi(ssid, password):
    sta_if = network.WLAN(network.STA_IF)
    ap_if = network.WLAN(network.AP_IF)

    ap_if.active(False)
    
    if not sta_if.active():
        sta_if.active(True)

    if not sta_if.isconnected():
        print("Connecting to network:", ssid)
        sta_if.connect(ssid, password)
        
        timeout = 10
        start = time.time()
        while not sta_if.isconnected():
            if time.time() - start > timeout:
                print("Failed to connect: timeout")
                return None
            time.sleep(1)
    
    print("Connected, network config:", sta_if.ifconfig())
    return sta_if.ifconfig()


def http_server():
    connect_wifi('Kapibara', 'Kapibara')
    sensor = dht.DHT11(Pin(2))
    TEMP = 0
    HUM = 0

    addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]

    s = socket.socket()
    s.bind(addr)
    s.listen(1)

    print('listening on', addr)

    while True:
        sensor.measure()
        TEMP = sensor.temperature()
        HUM = sensor.humidity()
        print('Temperature: %3.1f C' %TEMP)
        print('Humidity: %3.1f %%' %HUM)

        html = """<!DOCTYPE html>
        <html>
            <body>
                <h1>DHT11</h1>
                <p>Temperature: """ + str(TEMP) + """ C</p>
                <p>Humidity: """ + str(HUM) + """ %</p>
            </body>
        </html>
        """

        cl, addr = s.accept()
        print('client connected from', addr)

        cl_file = cl.makefile('rwb', 0)
        while True:
            line = cl_file.readline()
            if not line or line == b'\r\n':
                break

        cl.send('HTTP/1.0 200 OK\r\nContent-type: text/html\r\n\r\n')
        cl.send(html)
        cl.close()

if __name__ == '__main__':
    http_server()
