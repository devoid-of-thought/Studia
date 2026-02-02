#include <iostream>
#include <cmath>
#include <random>
using namespace std;
int zakres(){
    int down=16, up=32;
    random_device rd;
    default_random_engine generator(rd());
    uniform_int_distribution<int> distribution(down, up);
    return distribution(rd); 
}
int main(){
    int wielkość = zakres();
    int* tablica = new int[wielkość];
    for(int i = 0;i<=wielkość;i++){
        tablica[i]=pow(2,i);
        cout<<"["<<i<<"]"<<" 2^"<<i<<" = "<<tablica[i]<<"\n";
    }
}

