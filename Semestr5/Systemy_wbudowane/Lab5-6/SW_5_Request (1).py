import network
import time
import socket
import random


SSID = 'Kapibara'
PASSWORD = 'Kapibara'

SERVER_IP = "192.168.1.101" 
SERVER_PORT = 80

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

connect_wifi(SSID,PASSWORD)

def send_req(expression):
    safe_expression = expression.replace(" ", "%20")
    path = f"/?rpn={safe_expression}"
    
    addr = (SERVER_IP, SERVER_PORT)
    s = socket.socket()
    try:
        s.connect(addr)
        request = f"GET {path} HTTP/1.0\r\nHost: {SERVER_IP}\r\n\r\n"
        s.send(request.encode('utf-8'))
        print(f"Wysłano: {expression}")
    except OSError as e:
        print(f"błąd:", e)    
    s.close()

send_req("10 5 + 7 * 25 - 20 /")