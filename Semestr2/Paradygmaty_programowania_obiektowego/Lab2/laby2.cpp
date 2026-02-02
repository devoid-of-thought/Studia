    #include <iostream>
    using namespace std;

    template <typename T>
    T maxymum(T x, T y){
        return (x > y) ? x : y; 
    }
    class Zespolone{
        protected:
            int a;
            int b;
        public:
            Zespolone(int realna = 0 ,int i = 0){
                a = realna;
                b = i;    
            }
            virtual void Wyświetl() {};
    };

    class nawetniewiem: public Zespolone{
        public:
            nawetniewiem() = default;
            nawetniewiem(int a, int b) : Zespolone(a, b){};
            nawetniewiem operator+ (nawetniewiem const& obj ){
                nawetniewiem liczba;
                liczba.a = a + obj.a;
                liczba.b = b + obj.b;
                return liczba;
            }
            bool operator> ( nawetniewiem const& obj){
                if (a>obj.a){
                    return true;
                }
                else if (obj.a>a){
                    return false;
                }
                if (b>obj.b){
                    return true;
                }
                else{
                    return false;
                }
            }


            void Wyświetl() {cout<< a << " + " << b<<" i"<< endl;}
    };

    int main(){
        nawetniewiem I1(1,5), I2(10,11);
        I1.Wyświetl();
        I2.Wyświetl();
        nawetniewiem I3 = I1+I2;
        I3.Wyświetl();
        maxymum<nawetniewiem>(I1,I2).Wyświetl();
        maxymum<nawetniewiem>(I2,I1).Wyświetl();
    }