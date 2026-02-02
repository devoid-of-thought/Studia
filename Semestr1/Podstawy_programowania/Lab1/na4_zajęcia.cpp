#include <iostream>
#include <cmath>
int main(){
    double a,b,c;
    std::cout<<"a:";
    std::cin >> a;
    std::cout<<"b:";
    std::cin >> b;
    std::cout<<"c:";
    std::cin >> c;
    double delta = b*b - 4*c*a;
    if (a == 0){
        std::cout<<"Funkcja jest liniowa i ma miejsce zerowe w "<< (-b)/c<<"\n";
    }
    else {
        if (delta<0){
        std::cout<<"Nie ma miejsc zerowych"<<"\n";
    }
    else if(delta==0){
        std::cout<<"Ma jedno miejsce zerowe w " << (-b)/(2*a)<<"\n";
    }
    else{
        std::cout<<"Ma dwa miejsca zerowe w "<<((-b)-sqrt(delta))/(2*a)<< " i "<< ((-b)+sqrt(delta))/(2*a)<<"\n";
    }
    }
    
}