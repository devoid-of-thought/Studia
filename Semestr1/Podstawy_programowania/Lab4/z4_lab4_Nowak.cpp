#include <iostream>
using namespace std;
void append(int*& tablica,int& wielkość, int& rozmiar, int wartość){
    if (rozmiar>=wielkość){
        wielkość*=2;
        int* nowatablica = new int[wielkość];
        copy(tablica,tablica+rozmiar,nowatablica);
        delete[] tablica;
        tablica = nowatablica;
    }
    tablica[rozmiar++]=wartość;
}
void usuńztablicy(int*& tablica,int& rozmiar, int element){
    if (element<0 || element>rozmiar){
        cout<<"Nie ma takiego indeksu";
        return;
    }
    for (int i = element; i < rozmiar-1;i++){
        tablica[i]=tablica[i+1];
    }
    rozmiar--;

}
void wyświetltablice(int*& tablica,int& rozmiar){
    for ( int i = 0; i<rozmiar;i++){
        cout<<tablica[i]<<endl;
    }
    cout<<"Rozmiar tablicy: "<<rozmiar<<endl;

}
int main(){
    int pierwotnawielkość = 4;
    int rozmiar = 0;
    int count;
    int wartość;
    int* tablica = new int[pierwotnawielkość];
    cout<<"Ile chcesz wprowadzić danych: ";
    cin>> count;
    for (int i =0; i<count;i++){
        cout<<"Wprowadź: ";
        cin>>wartość;
        append(tablica,pierwotnawielkość,rozmiar,wartość);
        cout<<"W tablicy jest: "<< pierwotnawielkość<< " i z nich jest wolnych: "<<pierwotnawielkość-rozmiar<<endl;
          }
    wyświetltablice(tablica,rozmiar);
    cout<<"Co chcesz usunąć? ";
    int indeks;
    cin>>indeks;
    usuńztablicy(tablica,rozmiar,indeks);
    wyświetltablice(tablica,rozmiar);
    

}