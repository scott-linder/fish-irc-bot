msg $chan "Yes, $nick, this is fish. I can "(find cmd/ -type f -follow | sed -n 's#^cmd/\(.*\).fish$#'$LEADER'\1#p' | tr \n ' ')
