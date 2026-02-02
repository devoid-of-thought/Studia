#include <iostream>

int main(){
    double a,b;
    char c;
    std::cout<<"Podaj dwie liczby"<< std::endl;
    std::cout<<"a:";
    std::cin>>a;
    std::cout<<"b:";
    std::cin>>b;
    std::cout<<"Podaj operator (+,=,*,/):";
    std::cin>>c;
    switch(c){
        case '+':
            std::cout << a+b;
            break;
        
        case '-':
            std::cout<<a-b<<"\n";
            break;
        
        case '*':
            std::cout<<a*b<<"\n";
            break;
        
        case '/':
            if (b==0){
                std::cout<<"Nie dziel przez zero"<<std::endl;
                break;
            }
            else{
                std::cout<<a/b;
                break;
            }
        default:
            std::cout<<"Niepoprawny operator";
        
    }   

}