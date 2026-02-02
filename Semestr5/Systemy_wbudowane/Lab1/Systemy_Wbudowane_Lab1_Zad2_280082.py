from machine import Pin
from utime import sleep

while True:
    print("Podaj wyraz: ")
    wyr = str(input())
    wyr = wyr.lower()
    je = True
    for i in range(abs(len(wyr)/2)+1):
        if(wyr[i]!=wyr[(-i-1)]):
            je =False
            break
    if je ==True:
        print("Wyraz jest palindromem")
    else:
        print("Wyraz nie jest palindromem")



