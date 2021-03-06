set code "\
#![allow(dead_code, unused_variables)]\
#![allow(unused_features)]\
fn show<T: std::fmt::Debug>(e: T) { println!(\"{:?}\", e) }\
fn main() {\
    show({\
        $rest\
    });\
}\
"
msg $chan (echo $code \
    | python3 -c 'import json; print(json.dumps({"code": input()}))' \
    | curl --insecure -X POST -d @- -H 'Content-Type: application/json' 'https://play.rust-lang.org/evaluate.json' \
    | python3 -c 'import json; print(json.loads(input())["result"]);')
