#include <iostream>
using namespace std;
char zamiana(char znak){
    if (znak<=90 and znak>=65){
        znak+=32;
    }
    else if (znak>= 97 && znak<=122){
        znak-=32;
    }
    return znak;

}
int main(){
    char znaki[15];
    cin.getline(znaki,15);
    int ilosc = 0;
    for(int i =0;i<=15 && znaki[i] != '\0';i++){
        cout<<znaki[i];
        ilosc++;
    }
    cout<<endl;
    cout<<ilosc<<endl;
    for(int i =0;i<=15 && znaki[i] != '\0';i++){
        znaki[i] = zamiana(znaki[i]);
        cout<<znaki[i];
    }
    return 0;


}