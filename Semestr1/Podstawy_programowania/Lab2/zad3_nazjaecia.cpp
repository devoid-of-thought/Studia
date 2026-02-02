#include <iostream>
#include <stdlib.h>
#include <chrono>
#include <thread>
using namespace std;
int main(){
    while(true){
    for(int i= 2;i<=8;i+=2){
        for(int d=0; d<i;d++){
             for(int c = 0;c<i;c++){
                cout<<"* ";
                }
        cout<<endl;
            }
        this_thread::sleep_for(chrono::milliseconds(500));
        system("clear");
        } 
    
    }
}