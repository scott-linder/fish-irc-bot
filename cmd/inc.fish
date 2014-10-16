. lib/karma.fish
if test $nick != $rest
    karma_modify $rest + 1
else
    karma_modify $rest - 2
end
