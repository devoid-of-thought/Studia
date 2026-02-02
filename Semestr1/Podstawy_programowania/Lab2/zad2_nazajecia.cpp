#include <iostream>
using namespace std;
void suma(){
    int wynik = 0;
    int a;
    do{
        cout<<"podaj liczbe: ";
        cin >> a;
        if(a>=-15 && a<=15){
            wynik += a;
        }
    } while(a!=99);
    cout<<"Suma wynosi:"<<wynik<<endl;
}
void euklides(){
    int a,b= -5;
    do {
    cout<<"wprowadz a: "<<endl;
    cin>> a;
    cout<<"wprowadz b: "<<endl;
    cin>> b;
    if (a>0 && b>0){
        break;
    }
    else{
        cout<<"Podaj dodatinie całkowite a i b"<<endl;
    }
    }while(a<0 || b<0);
    do {
        if (a>b){
            a-=b;
        }
        else{
            b-=a;
        }
    }while(a!=b);
    cout<<"NWD:"<<a<< endl;

}
void schodki(){
    int a;
    cout<<"wysokość schodków:";
    cin>>a;
    for(int i=a;i>=1;i--){
        for (int d = a;d>=i;d--){
            cout<<d<<" ";
        }
        cout<<endl;
    }
}
int main(){
    int a;
    do{
        cout<<"Wybierz akcje: \n1.Suma \n2.NWD \n3.Schodki\n4.Zakończ\n";
        cin>>a;
        if (a==1){
            suma();
        }
        else if(a==2){
            euklides();
        }
        else if( a==3){
            schodki();
        }
        else if(a!=4){
            cout<<"Error";
        }
    }while(a!=4);
}