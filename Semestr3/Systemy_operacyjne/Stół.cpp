#include <iostream>
#include <thread>
#include <vector>
#include <ncurses.h>
#include <random>
#include <chrono>
#include <mutex>
#include <semaphore>

using namespace std;

// mutexy widelców
vector<mutex> widelec(5);

// mutex zapobiegający błędą wyświetlania
mutex printm;

//ilosć filozofów
const int N = 5;

// licznik jak bardzo zagłodzeni są filozofowie
int zagłodzenie[N];

// semafor zapobiegający rzuceniu się wszystkich filozofów na widelce
counting_semaphore<N-1> semaphore(N - 1);

// losowa liczba
size_t los(int min, int max) {
    thread_local std::mt19937 rnd(std::random_device{}()); // Thread-local random number generator.
    return std::uniform_int_distribution<>(min, max)(rnd);
}


    void filozof(int i) {
        while (true) {
            // Filozof skończył myśleć i jest głodny
            {
                lock_guard<mutex> lock(printm); // Ensure exclusive access to print operations.
                mvprintw(i, 0, "Filozof %d is hungry  %d ", i, zagłodzenie[i]);
                refresh();
            }

            // ograniczenie ilości filozofów jednocześnie jedzących
            semaphore.acquire();

            // zabranie widelcy, parzysty filozof bierze najpierw tego po swojej lewej stronie a nieparzysty odwrotnie by uniknąć sytuacji w ktorej trzymają tylko jeden widelec i nie chcą go zwolnić
            if (i % 2 == 0) {
                widelec[i].lock();
                widelec[(i + 1) % N].lock();
            } else {
                widelec[(i + 1) % N].lock();
                widelec[i].lock();
            }

            // filozof je
            {
                lock_guard<mutex> lock(printm);
                mvprintw(i, 0, "Filozof %d is eating   %d  ", i, zagłodzenie[i]);
                refresh();
            }

            // odczekanie czasu jedzenia
            this_thread::sleep_for(chrono::milliseconds(los(11, 17)));

            // odłożenie widelca
            widelec[i].unlock();
            widelec[(i + 1) % N].unlock();

            // zniesienie ograniczenia po skończonym jedzeniu
            semaphore.release();

            // Filozof myśli
            {
                lock_guard<mutex> lock(printm);
                mvprintw(i, 0, "Filozof %d is thinking %d", i, zagłodzenie[i]);
                refresh();
            }

            // odczekanie losowego czasu myślenia
            this_thread::sleep_for(chrono::milliseconds(los(6, 14)));

            // zwiększenie licznika głodu
            zagłodzenie[i]++;
        }
    }

int main() {
    initscr();
    curs_set(0);

    vector<thread> threads;

    // utworzenie filozofów
    for (size_t i = 0; i < N; ++i) {
        threads.emplace_back([i] { filozof(i); });
    }

    for (auto& t : threads) {
        t.join();
    }

    endwin();
    return 0;
}
