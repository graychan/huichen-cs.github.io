%% Copyright (C) 2014 Hui Chen
%% 
%% This program is free software; you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 3 of the License, or
%% (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License
%% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%% Author: Hui Chen <hchen@vsu.edu>
%% Created: 2014-10-11


size_of_alphabet = 26;

%
% initialize English character frequency
%
letter_freq_eng = [
0.080
0.015
0.030
0.040
0.130
0.020
0.015
0.060
0.065
0.005
0.005
0.035
0.030
0.070
0.080
0.020
0.002
0.065
0.060
0.090
0.030
0.010
0.015
0.005
0.020
0.002
];

fprintf(1, '-------------------------------------\n');
fprintf(1, '-----Letter Frequency of English-----\n');
fprintf(1, '-------------------------------------\n');
for i=1:size_of_alphabet
    fprintf(1, '%c %10f\n', 'a' + i - 1, letter_freq_eng(i));
end
fprintf(1, '\n\n');



%
% initialize cyphertext character frequency
%
ciphertext = input('Enter ciphertext: ', 's');
% ciphertext = 'KHOOR ZRUOG';
freq_letter_ciphertext  = zeros(26, 1);

num_of_chars = 0;
for i=1:length(ciphertext)
    if ~ isspace(ciphertext(i))
        if isstrprop(ciphertext(i), 'upper')
            freq_letter_ciphertext(ciphertext(i) - 'A' + 1) = ...
                freq_letter_ciphertext(ciphertext(i) - 'A' + 1) + 1;
            num_of_chars = num_of_chars + 1;
        else
            fprintf(1, 'Error: not all letters are upper case!\n');
            return;
        end
    end
end
freq_letter_ciphertext = freq_letter_ciphertext / num_of_chars;


fprintf(1, '-------------------------------------\n');
fprintf(1, '---Letter Frequency in Cipher Text---\n');
fprintf(1, '-------------------------------------\n');
for i=1:length(freq_letter_ciphertext)
    fprintf(1, '%c %10f\n', 'a' + i - 1, freq_letter_ciphertext(i));
end
fprintf(1, '\n\n');



%
% compute and sort correlation coefficients
%
phi = zeros(size_of_alphabet, 1);
for i=0:size_of_alphabet-1
    idx = mod((0:size_of_alphabet-1) - i, size_of_alphabet) + 1;
    phi(i+1) = sum(letter_freq_eng(idx) .* freq_letter_ciphertext);
end

[sorted_phi, phi_idx] = sort(phi, 1, 'descend');
phi_idx = phi_idx - 1;

fprintf(1, '-------------------------------------\n');
fprintf(1, '-------Correlation Coeefficient------\n');
fprintf(1, '-------------------------------------\n');
for i=1:size_of_alphabet
    fprintf(1, '%2d %c %10f\n', phi_idx(i), phi_idx(i) + 'a', sorted_phi(i));
end
fprintf(1, '\n\n');

%
% try keys with correlation coefficients from high to low
%
fprintf(1, '-------------------------------------\n');
fprintf(1, '----Decryption using guessed key-----\n');
fprintf(1, '-------------------------------------\n');
plaintext = blanks(length(ciphertext));
for key=phi_idx'
    fprintf(1, 'Trying key = %d\n', key);
    for i=1:length(ciphertext)
        if ~ isspace(ciphertext(i))
            plaintext(i) = mod(ciphertext(i) - 'A' - key, size_of_alphabet) + 'A';
        else
            plaintext(i) = ciphertext(i);
        end
    end
    fprintf(1, 'Guessed plaintext: %s\n', plaintext);
    while (1) 
        yn = input('Correct guess? (Y/N): ', 's');
        if yn == 'Y' || yn == 'y' || yn == 'N' || yn == 'n'
            break;
        end
    end
    if yn == 'Y' || yn == 'y'
        break;
    end
end

