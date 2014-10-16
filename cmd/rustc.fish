msg $chan $nick': '(echo '{"code":"'(echo $rest | sed 's/\\\\/\\\\\\\\/g' | sed 's/"/\\\\"/g')'"}' | curl -X POST -d @- -H 'Content-Type: application/json' 'http://play.rust-lang.org/evaluate.json')
