#include <iostream>
#include <cmath>
#include <iomanip>
int main(){
    double a,b,c,d;
    std::cout<<"a:";
    std::cin >> a;
    std::cout<<"b:";
    std::cin >> b;
    std::cout<<"c:";
    std::cin >> c;
    d=4;
    double delta = b*b - 4*c*a;
    if (a==0){
        if (b==0){
            if (c==0){
                std::cout<<"f(x)=0"<<"\n"<<"funkcja jest stała i ma nieskończenie wiele miejsc zerowych"<<"\n";
            }
            else {
                std::cout<<"f(x)="<<c<<"\n"<<"funkcja jest stała i nie ma miejsc zerowych"<<"\n";
            }

        }
        else{
            if (b>=0){
                std::cout<<"f(x)="<<b<<"x+"<<c<<"\n";
            }
            else{
                std::cout<<"f(x)="<<b<<"x"<<c<<"\n";
            }
            std::cout<<"Funkcja jest liniowa i ma miejsce zerowe w"<<std::setprecision(d)<< (-b)/c << "\n";
        }
    }
    else {
        if (b>=0){
            std::cout<<a<<"x²+"<<b<<"x";
            if (c>=0){
                std::cout<<"+"<<c<<"\n";
            }
            else{
                std::cout<<c<<"\n";
            }
        }
        else{
            std::cout<<a<<"x²"<<b<<"x";
            if (c>=0){
                std::cout<<"+"<<c<<"\n";
            }
            else{
                std::cout<<c<<"\n";
            }
        }
    if (delta<0){
        std::cout<<"Funkacja jest kwadratowa i Nie ma miejsc zerowych"<<"\n";
    }
    else if(delta==0){
        std::cout<<"Funkacja jest kwadratowa i Ma jedno miejsce zerowe w " <<std::setprecision(d)<< (-b)/(2*a)<<"\n";
    }
    else{
        std::cout<<"Funkacja jest kwadratowa i Ma dwa miejsca zerowe w "<<std::setprecision(d)<<((-b)-sqrt(delta))/(2*a)<< " i "<< ((-b)+sqrt(delta))/(2*a)<<"\n";
    }
    }
    
}