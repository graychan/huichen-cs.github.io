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

%%
%% refrence: http://en.wikipedia.org/wiki/Longest_common_substring_problem
%%

%% -*- texinfo -*- 
%% @deftypefn {Function File} {@var{retval} =} findcommonsubstring (@var{ciphertext})
%%
%% @seealso{}
%% @end deftypefn

%% Author: Hui Chen <hchen@ubuntu>
%% Created: 2014-10-12

function [idx1st, idx2nd, lensubstr, gaps, eqmat] = findcommonsubstrings (ciphertext, verbose)
    if nargin < 1 || nargin > 2
        usage('findcommonsubstrings(ciphertext [, verbose])');
    endif

    len = length(ciphertext);

    if nargin == 2 && verbose(1) == 'v'
        ndigits = fix(ceil(log10(len)));
        fmtstring = sprintf('%%%dd\\t%%%dd\\t%%%dd\t%%%dd\t', ...
                        ndigits, ndigits, ndigits, ndigits);
        % fmtstring
    end

    eqmat = zeros(len, len);
    idx1st = zeros(1, len);
    idx2nd = idx1st;
    lensubstr = idx1st;
    gaps = idx1st;
    nstrings = 0;
    z = 0;
    for i=1:len
        for j=1:len
            if ciphertext(i) == ciphertext(j) 
                if i == 1 || j == 1
                    eqmat(i, j) = 1;
                else
                    eqmat(i, j) = eqmat(i - 1, j - 1) + 1;
                end
            else
                eqmat(i, j) = 0;
                % common string
                if i > 1 && j > i && eqmat(i - 1, j - 1) > 1 && j - i + 1 > eqmat(i - 1, j - 1)

                    nstrings = nstrings + 1;
                    idx1st(nstrings) = i - eqmat(i - 1, j - 1);
                    idx2nd(nstrings) = j - eqmat(i - 1, j - 1);
                    lensubstr(nstrings) = eqmat(i - 1, j - 1);
                    gaps(nstrings) = idx2nd(nstrings) - idx1st(nstrings);

                    if nargin == 2 && verbose(1) == 'v'
                        if nstrings == 1
                            fprintf(1, 'Start\tEnd\tLen\tGap\tLetters\n');
                        end
                        fprintf(1, ...
                            fmtstring, ...
                            idx1st(nstrings), ...
                            idx2nd(nstrings), ...
                            lensubstr(nstrings), ...
                            gaps(nstrings));
                        for k=(i - eqmat(i - 1, j - 1)):(i-1)
                            fprintf(1, '%c', ciphertext(k));
                        end
                        fprintf(1, '\n');
                    end
                end
            end
        end
    end
    if nstrings > 0
        idx1st = idx1st(1:nstrings);
        idx2nd = idx2nd(1:nstrings);
        lensubstr = lensubstr(1:nstrings);
        gaps = gaps(1:nstrings);
    else
        idx1st = [];
        idx2nd = [];
        lensubstr = [];
        gaps = [];
    end
end
