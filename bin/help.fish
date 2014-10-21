msg $chan "Yes, $nick, this is fish. I can "(find bin/ -type f -follow | sed -n 's#^bin/\(.*\).fish$#'$LEADER'\1#p' | tr \n ' ')
