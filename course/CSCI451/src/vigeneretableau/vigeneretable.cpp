#include <iostream>
using namespace std;

const int ALPHABET_SIZE = 26;
const int KEY_SPACE_SIZE = 26;

int main()
{
    int alphabet[ALPHABET_SIZE];
    int keyspace[KEY_SPACE_SIZE];

    // initialize alphabet
    for (int i = 0; i < ALPHABET_SIZE; i ++) {
        alphabet[i] = i;
    }

    // initialize key space
    for (int j = 0; j < KEY_SPACE_SIZE; j ++) {
        keyspace[j] = j;
    }


    // output table header
    cout << "  ";
    for (int i = 0; i < ALPHABET_SIZE; i ++) {
        cout << char(alphabet[i] + 'A') << ' '; 
    }
    cout << endl;

    // compute and output the row for a key letter
    for (int key = 0; key < KEY_SPACE_SIZE; key ++) {
        cout << char(key + 'A') << ' '; 
        for (int letter = 0; letter < ALPHABET_SIZE; letter ++) {
            int ciphertext = (letter + key) % ALPHABET_SIZE;
            cout << char(ciphertext + 'A') << ' ';
        }
        cout << endl;
    }

    return 0;
}
