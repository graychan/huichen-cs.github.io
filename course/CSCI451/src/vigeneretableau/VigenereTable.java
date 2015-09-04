public class VigenereTable {
    private final int ALPHABET_SIZE = 26;
    private final int KEY_SPACE_SIZE = 26;

    public static void main(String[] args) {
        VigenereTable vt = new VigenereTable();
        vt.printTable();
    }

    private void printTable() {
        int alphabet[] = new int[ALPHABET_SIZE];
        int keyspace[] = new int[KEY_SPACE_SIZE];

        // initialize alphabet
        for (int i = 0; i < ALPHABET_SIZE; i ++) {
            alphabet[i] = i;
        }

        // initialize key space
        for (int j = 0; j < KEY_SPACE_SIZE; j ++) {
            keyspace[j] = j;
        }

        // output table header
        System.out.print("  ");
        for (int i = 0; i < ALPHABET_SIZE; i ++) {
            System.out.print((char)(alphabet[i] + 'A') + " "); 
        }
        System.out.println();

        // compute and output the row for a key letter
        for (int key = 0; key < KEY_SPACE_SIZE; key ++) {
            System.out.print((char)(key + 'A') + " "); 
            for (int letter = 0; letter < ALPHABET_SIZE; letter ++) {
                int ciphertext = (letter + key) % ALPHABET_SIZE;
                System.out.print((char)(ciphertext + 'A') + " ");
            }
            System.out.println();
        }
    }
}
