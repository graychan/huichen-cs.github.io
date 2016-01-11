#include <stdio.h>

#define ALPHABET_SIZE   26
#define KEY_SPACE_SIZE  26
int main()
{
    int alphabet[ALPHABET_SIZE];
    int keyspace[KEY_SPACE_SIZE];
    int i, j, key, letter, ciphertext;

    // initialize alphabet
    for (i = 0; i < ALPHABET_SIZE; i ++) {
        alphabet[i] = i;
    }

    // initialize key space
    for (j = 0; j < KEY_SPACE_SIZE; j ++) {
        keyspace[j] = j;
    }


    // output table header
    printf("  ");
    for (i = 0; i < ALPHABET_SIZE; i ++) {
        printf("%c ", alphabet[i] + 'A');
    }
    printf("\n");

    // compute and output the row for a key letter
    for (key = 0; key < KEY_SPACE_SIZE; key ++) {
        printf("%c ", key + 'A'); 
        for (letter = 0; letter < ALPHABET_SIZE; letter ++) {
            ciphertext = (letter + key) % ALPHABET_SIZE;
            printf("%c ", ciphertext + 'A');
        }
        printf("\n");
    }

    return 0;
}
