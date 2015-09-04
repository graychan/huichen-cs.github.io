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

%% -*- texinfo -*- 
%% @deftypefn {Function File} {@var{retval} =} guesskey (txt)
%%
%% @seealso{}
%% @end deftypefn

%% Author: Hui Chen <hchen@vsu.edu>
%% Created: 2014-10-12

function [phi_idx, sorted_phi] = guesskey (ciphertext, verbose)

    if nargin < 1 || nargin > 2
        usage('gusskey(txt [, verbose])');
    end

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

    %
    % initialize cyphertext character frequency
    %
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

    if nargin == 2 && verbose(1) == 'v'
        fprintf(1, '-------------------------------------\n');
        fprintf(1, '-------Correlation Coeefficient------\n');
        fprintf(1, '-------------------------------------\n');
        for i=1:size_of_alphabet
            fprintf(1, '%2d %c %10f\n', phi_idx(i), phi_idx(i) + 'a', sorted_phi(i));
        end
        fprintf(1, '\n\n');
    end

end
