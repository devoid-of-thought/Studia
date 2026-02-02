#include <iostream>
using namespace std;

class Osoba{
    private:
        string imie;
        int wiek;
    public:
        Osoba(string imie,int wiek){
            this -> imie = imie;
            this -> wiek = wiek;    
        }
        string getImie(){
            return imie;
        }
        int getWiek(){
            return wiek;
        }
        void show(){
            cout<< "Imie: " << getImie() << " wiek: " << getWiek() <<endl;
        }
        
    };

class Student: public Osoba{
    private:
        string indeks;
    public:
        Student(string imie,int wiek,string indeks): Osoba(imie, wiek){
            this -> indeks = indeks;
        }
        string getIndeks(){
            return indeks;
        }
        void show(){
            cout<< "Imie: " << getImie() << " wiek: " << getWiek()<<" indeks: "<< getIndeks()<<endl;
        }
};  


int main() {
    Osoba osoba1("Jan",20);
    Student student1("Maria", 16 ,"28082");
    osoba1.show();
    student1.show();
    return 0;

}