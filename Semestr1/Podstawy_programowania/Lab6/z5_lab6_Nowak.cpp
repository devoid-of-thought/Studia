#include <iostream>
using namespace std;
struct Kolejka{
	struct Student{
		int nr_indeksu;
		string imie;
		string nazwisko;
		char plec;
		string data_urodzenia;
		Student* nastepny;
		Student(int nr_indeksu, string imie, string nazwisko,char plec, string data_urodzenia){
			this-> nr_indeksu=nr_indeksu;
			this->imie=imie;
			this->nazwisko=nazwisko;
			this->plec=plec;
			this->data_urodzenia=data_urodzenia;
			this->nastepny=nullptr;
		}
	};
	Student* pierwszy = nullptr;
	Student* ostatni = nullptr;
	void dodawanie(int numer, string imie, string nazwisko, char plec, string data_urodzenia){
		Student *temp = new Student( numer, imie, nazwisko, plec, data_urodzenia );
		if (!pierwszy) pierwszy = temp;
		if (ostatni) ostatni->nastepny = temp;	
		ostatni = temp;
	}
	void usuwanie(int opt = 1){
		if(!pierwszy){
			if(opt==1) 
				cout<<"Nie ma studentów"<<endl;
			return;
		}
		Student* usun = pierwszy;
		pierwszy=pierwszy->nastepny;
		delete usun;
		if(opt==1){
			cout<<"ususnieto studenta z kolejki"<<endl;
		}
	}
	void wyświetl(){
		if (!pierwszy){
			cout<<"Nie ma żadnego studenta"<<endl;
			return;
		}
		Student* obecny = pierwszy;
		do{
			cout<<"Nr indeksu: "<< obecny->nr_indeksu<<",Imie: "<<obecny->imie<<",Nazwisko: "<< obecny->nazwisko<< ",Płeć: "<<obecny->plec<<",Data Urodzenia: "<<obecny->data_urodzenia<<endl;
			obecny = obecny->nastepny;
		}while(obecny);

	}
	void wyświetl_po_indeksie(){
		int szukany_indeks;
		int wartość;
		wartość = 0;
		if (!pierwszy){
			cout<<"Nie ma żadnego studenta"<<endl;
			return;
		}
		cout<<"Podaj indeks który chcesz wyświetlić:"<<endl;
		cin>>szukany_indeks;
		Student* obecny = pierwszy;
		do{
			if (szukany_indeks!=wartość){
				wartość++;
			}
			else{
				cout<<"Nr indeksu: "<< obecny->nr_indeksu<<",Imie: "<<obecny->imie<<",Nazwisko: "<< obecny->nazwisko<< ",Płeć: "<<obecny->plec<<",Data Urodzenia: "<<obecny->data_urodzenia<<endl;
				break;
		}
		obecny = obecny->nastepny;
		}while(obecny);
	}
};

int main(){
	Kolejka studenci;
	int nr_indeksu;
	string imie;
	string nazwisko;
	char plec;
	string data_urodzenia;
	int wybor;
	int indeks;
	do{
		cout<<"Menu \n1.Dodawanie \n2.Usuwanie \n3.Wyswietlanie \n4.Wyświetl po indeksie \n0.Wyjscie " << endl;
		cin >> wybor;
			switch(wybor){
				case 1:
					cout<<"Podaj Nr_indeksu:"<<endl;
					cin>>nr_indeksu;
					cout<<"Podaj Imię: "<<endl;
					cin >> imie;
					cout<<"Podaj Nazwisko;"<<endl;
					cin>>nazwisko;
					cout<<"Podaj Plec: "<<endl;
					cin>>plec;
					cout<<"Podaj Date Urodzenia: "<<endl;
					cin>>data_urodzenia;
					studenci.dodawanie(nr_indeksu,imie,nazwisko, plec,data_urodzenia);
					break;
				case 2:
					studenci.usuwanie();
					break;
				case 3:
					studenci.wyświetl();
					break;
				case 4:
					studenci.wyświetl_po_indeksie();
					break;
				case 0:
					break;
				default:
					cout << "Wybierz poprawna opcje" << endl;
				break;
			}


	}while(wybor!=0);
}