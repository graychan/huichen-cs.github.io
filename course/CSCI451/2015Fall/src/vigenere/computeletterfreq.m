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
%% @deftypefn {Function File} {@var{freq} =} computeletterfreq (@var{infile}})
%%
%% @seealso{}
%% @end deftypefn

%% Author: Hui Chen <hchen@vsu.edu>
%% Created: 2014-10-12

function [freq] = computeletterfreq (buf)
    % only deal with the English language
    alphabet_size = 26;
    freq = zeros(alphabet_size, 1); 

    for i=0:(alphabet_size-1)
        freq(i+1) = freq(i+1) + sum(buf == 'A' + i);
    end

    freq = freq / (sum(freq));

    bar(freq);
    set(gca, 'xtick', 1:26);
    set(gca, 'xticklabel', char((0:25)' + 'A'));
    title('Letter Frequencies of Ciphertext');
end
