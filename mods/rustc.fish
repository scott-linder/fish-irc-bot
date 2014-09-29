msg $chan $nick': '(echo '{"code":"'$rest'"}' | curl -X POST -d @- -H 'Content-Type: application/json' 'http://play.rust-lang.org/evaluate.json')
