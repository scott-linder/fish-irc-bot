set -l to_say $rest
if test -z $to_say
    set to_say (fortune -so | tr \n\t '  ')
end
msg $chan '><{{{*> -- ( '$to_say')'
