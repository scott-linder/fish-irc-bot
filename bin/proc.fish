. lib/file.fish
msg $chan (cat /proc/(echo %self)/(sanitize_path $rest) | tr \n ' ')
