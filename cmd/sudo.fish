if contains $nick $ADMINS
    msg $chan $nick': OK'
else
    msg $chan $nick': User not in sudoers file. This incident will be reported.'
end
