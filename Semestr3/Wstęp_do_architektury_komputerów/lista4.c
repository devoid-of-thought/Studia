#include <stdio.h>
#include <limits.h>
#include <float.h>

int main() {
    printf("Minimalna wartość signed char: %d\n", SCHAR_MIN);
    printf("Maksymalna wartość signed char: %d\n", SCHAR_MAX);
    printf("Minimalna wartość unsigned char: %u\n", 0);
    printf("Maksymalna wartość unsigned char: %u\n", UCHAR_MAX);
    printf("Minimalna wartość short: %d\n", SHRT_MIN);
    printf("Maksymalna wartość short: %d\n", SHRT_MAX);
    printf("Minimalna wartość unsigned short: %u\n", 0);
    printf("Maksymalna wartość unsigned short: %u\n", USHRT_MAX);
    printf("Minimalna wartość int: %d\n", INT_MIN);
    printf("Maksymalna wartość int: %d\n", INT_MAX);
    printf("Minimalna wartość unsigned int: %u\n", 0);
    printf("Maksymalna wartość unsigned int: %u\n", UINT_MAX);
    printf("Minimalna wartość long: %ld\n", LONG_MIN);
    printf("Maksymalna wartość long: %ld\n", LONG_MAX);
    printf("Minimalna wartość unsigned long: %d\n", 0);
    printf("Maksymalna wartość unsigned long: %lu\n", ULONG_MAX);
    printf("Minimalna wartość long long: %lld\n", LLONG_MIN);
    printf("Maksymalna wartość long long: %lld\n", LLONG_MAX);
    printf("Minimalna wartość unsigned long long: %d\n", 0);
    printf("Maksymalna wartość unsigned long long: %llu\n", ULLONG_MAX);
    //1
    int l_1 = INT_MAX;
    int wynik1 = l_1 + l_1;
    printf("Dodawanie %d + %d: %d\n", l_1, l_1, wynik1 );
    //2
    int l2_1 = 33;
    int l2_2 = 7;
    int wynik2 = l2_1 / l2_2;
    printf("Dzielenie %d / %d: %d\n", l2_1, l2_2, wynik2);
    //3
    int l3_1 = 76;
    unsigned int l3_2 = 352;
    int wynik3 = l3_1 * l3_2;
    printf("Mnożenie %d * %u: %d\n", l3_1, l3_2, wynik3);
    //4
    long int wynik4 = l_1 * l_1;
    printf("Mnożenie %d* %d: %ld\n", l_1, l_1, wynik4);
    //5
    int l5_1 = 15000;
    int l5_2 = 2430;
    short wynik5 = l5_1 * l5_2;
    printf("Mnożenie %d * %d: %hd\n", l5_1, l5_2, wynik5);
    //6
    unsigned int l6_1 = 4;
    unsigned int l6_2 = 6;
    int wynik6 = l6_1 - l6_2;
    printf("Odejmowanie %u - %u: %d\n", l6_1, l6_2, wynik6);\
    //7
    int l7_1 = 15;
    float l7_2 = 6.66;
    int wynik7 = l7_1 + l7_2;
    printf("Dodawanie %d + %f: %d\n", l7_1, l7_2, wynik7);
    //8
    float wynik8 = l7_1 + l7_2;
    printf("Dodawanie %d + %f: %f\n", l7_1, l7_2, wynik8);
    //9
    float l9_1 = 6.66;
    float l9_2 = 34.21;
    int wynik9 = l9_1 * l9_2;
    printf("Mnożenie %f * %f: %d\n", l9_1, l9_2, wynik9);
    //10
    float l10_1 = FLT_MAX;
    float l10_2 = FLT_MAX;
    long int wynik10 = l10_1 * l10_2;
    printf("Mnożenie %f * %f: %ld\n", l10_1, l10_2, wynik10);
    //11
    char l11_1 = 'A';
    char l11_2 = 'Z';
    int wynik11 = l11_1 * l11_2;
    printf("Mnożenie %c * %c: %d\n", l11_1, l11_2, wynik11);
    //12
    unsigned int wynik12 = l11_1 - l11_2;
    printf("Odejmowanie %c - %c: %u\n", l11_1, l11_2, wynik12);
    //13
    int wynik13 = l11_1 - l11_2;
    printf("Odejmowanie %c - %c: %d\n", l11_1, l11_2, wynik13);
    //14
    float wynik14 = l11_1 - l11_2;
    printf("Odejmowanie %c - %c: %f\n", l11_1, l11_2, wynik14);
    //15
    double l15_1 = 33.34568;
    double l15_2 = 2.515138;
    short int wynik15 = l15_1 + l15_2;
    printf("Dodawanie %f + %f: %hd\n", l15_1, l15_2, wynik15);
    return 0;
}
