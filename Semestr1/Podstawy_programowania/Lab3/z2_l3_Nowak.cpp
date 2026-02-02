#include <iostream>
#include <random>
using namespace std;
#define N 8
void wprowadzrand(int tablica[]){
    int down, up;
    cout<<"Podaj zakres: od:";
    cin>>down;
    cout<<"do:";
    cin>>up;
    for (int i=0;i<N;i++){
        random_device rd;
        default_random_engine generator(rd());
        uniform_int_distribution<int> distribution(down, up); 
        for (int i = 0; i < N; i++) {
            tablica[i] = distribution(rd); 
        }
    }
}
void wyprowadz(int tablica[]){
    for(int i = 0; i<N;i++){
        cout <<"tab["<<i<<"]=" << tablica[i]<< endl;
    }
}
void tobin(int tablica[]){
    for(int i = 0;i<N;i++){
        int tab[5] = {0};
        int b = tablica[i];
        if(tablica[i]<=30 && tablica[i]>=0){
            for(int i=0 ; b>0;i++){
                tab[i] = b%2;
                b = (b-b%2)/2;
            }
            cout<<tablica[i]<<":";
            for(int i = 4;i>=0;i--){
                cout<<tab[i];
            }
            cout<<endl;
    }
    }
}
int main(){
    int tablica[N];
    wprowadzrand(tablica);
    wyprowadz(tablica);
    tobin(tablica);
    return 0;
}