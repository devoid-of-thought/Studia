#include <iostream>
using namespace std;
int suma(){
    int wynik = 0;
    int a;
    do{
        cout<<"podaj liczbe: ";
        cin >> a;
        if(a>=-15 && a<=15){
            wynik += a;
        }
    } while(a!=99);
    return wynik;
}
int main(){
    cout<< suma()<< endl;
}