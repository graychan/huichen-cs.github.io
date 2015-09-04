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
%% @deftypefn {Function File} {@var{retval} =} computeic (@var{txt})
%%
%% @seealso{}
%% @end deftypefn

%% Author: Hui Chen <hchen@vsu.edu>
%% Created: 2014-10-09

function [ic] = computeic (txt)
    alphabet_size = 26;

    counter = zeros(1, alphabet_size);

    for i=1:length(txt)
        counter(txt(i) - 'A' + 1) = counter(txt(i) - 'A' + 1) + 1;
    end

    product = 0;
    for i=1:alphabet_size
        if counter(i) ~= 0
            product = product + (counter(i) / length(txt))* ((counter(i) - 1) / (length(txt) - 1));
        end
    end

    % ic = product / length(txt) / (length(txt) - 1);
    
    ic = product;
end
