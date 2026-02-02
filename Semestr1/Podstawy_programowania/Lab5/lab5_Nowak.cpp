#include <iostream>
#include <fstream>
#include <string>
using namespace std;
struct student{
    int numerid;
    string imie;
    string nazwisko;
    char plec;
    string dataurodzenia;
};
void otwórz(const string& file, ofstream& plikwyjscia ){

        plikwyjscia.open(file);
        if (plikwyjscia.is_open()){
            cout<<"plik został otworzony";
        }

}
void zapisz(const string& file,string newplik){
    ifstream plikwejscia(file);
    ofstream nowyplik{newplik};
    string line;
    if (plikwejscia.is_open() && nowyplik.is_open()){
        while (getline(plikwejscia, line)) { 
            nowyplik << line << "\n"; 
        } 
    }
}
void pokaz(const string& file) {
    ifstream plik(file);
    if (plik.is_open()) {
        student s;
        while (plik >> s.numerid >> s.imie >> s.nazwisko >> s.plec >> s.dataurodzenia) {
            cout << s.numerid << " " << s.imie << " " << s.nazwisko
                 << "  " << s.plec << " " << s.dataurodzenia << endl;
        }
        plik.close();
}
}
void dodaj(const string& file) {
    ofstream plik(file, ios::app);  // Open the file in append mode
    student s;
    cout << "ID: ";
    cin >> s.numerid;
    cout << "Imie: ";
    cin >> s.imie;
    cout << "Nazwisko: ";
    cin >> s.nazwisko;
    cout << "Płeć: ";
    cin >> s.plec;
    cout << "Data Urodzenia: ";
    cin >> s.dataurodzenia;
    if (plik.is_open()) {
        plik << s.numerid << " " << s.imie << " " << s.nazwisko << " " << s.plec << " " << s.dataurodzenia << endl;
        cout << "Element Dodany" << endl;
        plik.close();
    } else {
        cerr << "Nie można otworzyć pliku" << endl;
    }
}
int main(){
    const string file = "database.txt";
    const string newplik = "nowyplik.txt";
    ofstream plikwyjscia;
    int wybór=999;
    while (wybór!=0){
        cout<<"wybierz opcje: \n0.zakończ\n1.wczytaj plik \n2.Pokaż\n3.zapisz\n4.Dodaj element\n";
        cin>>wybór;
        switch(wybór){
            case 1:
                otwórz(file,plikwyjscia);
                break;
            case 2:
                pokaz(file);
                break;

            case 3:
                zapisz(file,"nowyplik.txt");
                break;
            case 4:
                dodaj(file);
                break;
            
        }
    }
}