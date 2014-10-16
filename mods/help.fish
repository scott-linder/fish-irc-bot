msg $chan "Yes, $nick, this is fish. I can "(find mods/ -type f -follow | sed -n 's#^mods/\(.*\).fish$#'$LEADER'\1#p' | tr \n ' ')
