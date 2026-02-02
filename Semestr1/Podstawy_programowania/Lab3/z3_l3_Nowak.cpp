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
void babel(int tablica[]){
    for(int i = 0; i<N;i++){
        for(int j = 0; j<N-i-1;j++){
            int te;
            if(tablica[j]>tablica[j+1]){
                te=tablica[j];
                tablica[j]=tablica[j+1];
                tablica[j+1]= te;
            }
        }
    }
}
int main(){
    int tablica[N];
    wprowadzrand(tablica);
    babel(tablica);
    wyprowadz(tablica);
    return 0;
}