#include <iostream>
using namespace std;
char zamiana(char znak){
    if (znak<=90 and znak>=65){
        znak+=32;
    }
    return znak;

}
void histogram(string tekst){
    int litery[26] = {0};
    int pomocnicza; 
    for (int i = 0; i<=tekst.size();i++){
        tekst[i] = zamiana(tekst[i]);
        pomocnicza = tekst[i]-97;
        litery[pomocnicza]++;
    }
    for( int i = 0;i<26;i++){
        if(litery[i]!=0){
            cout<<char(i+'a')<< " ";
            for(int j = 0; j<litery[i];j++){
                cout<< "#";
            }
            cout<<endl;
        }
    }

}
int main(){
    string tekst = "Dobrze widzi się tylko sercem, najważniejsze jest niewidoczne dla oczu";
    histogram(tekst);
}