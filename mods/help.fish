msg $chan "hello $nick, I am fish, the friendly interactive bot. I know how to: "(find mods/ -type f | sed -n 's#^mods/\(.*\).fish$#'$leader'\1#p' | tr \n ' ')
