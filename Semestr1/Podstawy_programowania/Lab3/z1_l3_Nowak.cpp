#include <iostream>
using namespace std;
#define N 8
void wprowadz(int tablica[]){
    for(int i = 0; i<N;i++){
        cout <<"Wprowadź liczbe: ";
        cin>>tablica[i];
    }

}
void wyprowadz(int tablica[]){
    for(int i = 0; i<N;i++){
        cout <<"tab["<<i<<"]=" << tablica[i]<< endl;
    }
}
int suma(int tablica[]){
    int suma = 0;
    for(int i = 0; i<N;i++){
        suma += tablica[i];
    }
    return suma;
}
int max(int tablica[]){
    int max = 0;
    for(int i = 0; i<N;i++){
        if (max<tablica[i]){
            max = tablica[i];
        }
    }
    return max;
}
void przy3(int tablica[]){
    int tablicapomocnicza[max(tablica)+1] = {0};
    for(int i = 0; i<N;i++){
        tablicapomocnicza[tablica[i]]++;
    }
    for(int c = 0; c<sizeof(tablicapomocnicza)/sizeof(tablicapomocnicza[0]);c++){
        if (tablicapomocnicza[c]>=3){
            cout<< c <<":"<<tablicapomocnicza[c]<<endl;
        }
    }
}
int main(){
    int tablica[N];
    wprowadz(tablica);
    wyprowadz(tablica);
    cout<< "suma: "<<suma(tablica)<<endl;
    cout<< "max: "<<max(tablica)<<endl;
    przy3(tablica);
    return 0;
}