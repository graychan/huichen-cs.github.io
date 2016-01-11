alphabet = 0:25;
keys = 0:25;

fprintf('  ');
fprintf('%c ', char(alphabet+65));
fprintf('\n');
for key=keys
    fprintf('%c ', char(key+65));
    ciphertext = mod(alphabet + key, 26);
    fprintf('%c ', char(ciphertext+65));
    fprintf('\n');
end