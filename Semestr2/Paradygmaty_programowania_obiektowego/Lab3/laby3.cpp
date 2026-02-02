#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <time.h>
#include <cmath>

using namespace std;

class Interfejs{
public:
    virtual void wyswietl() = 0;
};

int randomInt(int start, int range) {
    return (start + rand() % range);
}
class Foremny: public Interfejs{
    int bok;
    int ilosc;
    double pole(){
        double area =       0.25*ilosc*bok*bok*(cos(M_PI/ilosc))/sin(M_PI/ilosc);
        return area;
    }
public:
    void getter() {
        bok=(randomInt(5,195));
        ilosc= randomInt(3,11);
    }
    void wyswietl(){
        cout << "Ile boków: " << ilosc ;
        cout << " Długość jednego boku: " << bok ;
        cout << " Pole: " << pole() << endl;
    }
};
int main(){

    vector<Foremny> v;
    Foremny kształt;
    srand(time(NULL));
    for (int i = 0; i < 20; i++) {
        kształt.getter();
        v.push_back(kształt);
    }
    for (int i = 0; i < 20; i++) {
        v[i].wyswietl();
    }
}
    