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
%% @deftypefn {Function File} {@var{retval} =} vigenere (@var{input1}, @var{input2})
%%
%% @seealso{}
%% @end deftypefn

%% Author: Hui Chen <hchen@hchen>
%% Created: 2014-10-10

function [out_text] = vigenere (in_text, key, option)
    if nargin < 2 || nargin > 3
        usage('vigenere(in_text, key [, option]');
    end

    alphabet_size = 26;
    key_length = length(key);
    text_length = length(in_text); 
    num_rounds = fix(ceil(text_length / key_length));
    key_index = kron(ones(1, num_rounds), 1:key_length);
    key_index = key_index(1:text_length);

    % fprintf(1, 'in_text = <%s> %d chars\n', in_text, length(in_text));
    % fprintf(1, 'key = <%s>\n', key);
    % fprintf(1, 'key_index = %d chars\n', length(key(key_index)));


    if nargin == 2 || option(1) == 'e'
        out_text = mod((in_text - 'A') + (key(key_index) - 'A'), alphabet_size) + 'A';
    elseif option(1) == 'd'
        out_text = mod((in_text - 'A') - (key(key_index) - 'A'), alphabet_size) + 'A';
    else
        usage('vigenere(in_text, key, option): option must be either encipher or decipher');
    end
end
