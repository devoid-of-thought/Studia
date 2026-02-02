from machine import Pin
from utime import sleep
from math import sqrt


while True:
    print("Podaj współczynniki:")
    print("a:")
    a = int(input())
    print("b:")
    b = int(input())
    print("c:")
    c = int(input())
    delta = b*b -4*a*c
    if (delta > 0):
        p1 = (-b+sqrt(delta))/(2*a)
        p2 = (-b-sqrt(delta))/(2*a)
        print("Pierwiastki to : ",p1," ", p2 )
    elif (delta == 0):
        print("Pierwiastek to: ", (-b)/(2*a) )
    else:
        print("Nie ma żadnych pierwiastków")
    print("Czy chcesz ponownie wykonać obliczenia: wpisz Tak lub Nie")
    wy = str(input())
    if (wy != "Tak"):
        break


