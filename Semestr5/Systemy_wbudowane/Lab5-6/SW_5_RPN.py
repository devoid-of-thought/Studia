import machine # type: ignore
from machine import Pin # type: ignore
import socket #type: ignore
import network # type: ignore
import time
import re


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

def calculate_RPN_string(rpn_string: str):
    known_operators = ['+', '-', '*', '/']
    rpn_stack = []
    try:
        for element in rpn_string.split(' '):
            if element not in known_operators:
                rpn_stack.insert(0, element)
            else:
                if len(rpn_stack) < 2:
                    return "Invalid RPN string - operator needs 2 numbers"
                b = float(rpn_stack.pop(0))
                a = float(rpn_stack.pop(0))

                if element == '+':
                    value = a + b
                elif element == '-':
                    value = a - b
                elif element == '*':
                    value = a * b
                elif element == '/':
                    value = a / b
                else:
                    value = ""

                rpn_stack.insert(0, str(value))
        return rpn_stack.pop(0)
    except ValueError:
        return "ValueError occured, invalid RPN string"
    

def http_server():
    addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]

    s = socket.socket()
    s.bind(addr)
    s.listen(1)

    print('listening on', addr)

    html = """<!DOCTYPE html>
    <html>
        <body>
            <h1>Reverse Polish Notation Calculator</h1>
            <p>Reverse Polish Notation : %s</p>
            <p>Result: %s</p>
        </body>
    </html>
    """

    input_data = "Nothing"
    result = "No input"

    while True:
        cl, addr = s.accept()
        print('client connected from', addr)
        cl_file = cl.makefile('rwb', 0)
        request_line = b""

        while True:
            line = cl_file.readline()
            if not line or line == b'\r\n':
                break
            if line.startswith(b'GET'):
                request_line = line

        req_str = str(request_line, 'utf-8')

        if '/?rpn=' in req_str:
            path = req_str.split(' ')[1]
            input_data = path.split('=')[1].replace('%20', ' ')
            result = calculate_RPN_string(input_data)
            print("input_data=" + input_data)
            print("result=" + result)
            print()

        response = html % (input_data, result)

        cl.send('HTTP/1.0 200 OK\r\nContent-type: text/html\r\n\r\n') # type: ignore
        cl.send(response) # type: ignore
        cl.close()


if __name__ == '__main__':
    connect_wifi('Kapibara', 'Kapibara')
    http_server()
