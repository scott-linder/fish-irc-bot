set code "\
#![feature(asm, non_ascii_idents, simd, thread_local, unsafe_destructor)]\
#![allow(dead_code, unused_variables, unstable)]\
extern crate arena;\
extern crate libc;\
extern crate regex;\
fn main() {\
    let r = {\
        $rest\
    };\
    println!(\"{:?}\", r)\
}\
"
msg $chan (echo $code \
    | python3 -c 'import json; print(json.dumps({"code": input()}))' \
    | curl -X POST -d @- -H 'Content-Type: application/json' 'http://play.rust-lang.org/evaluate.json' \
    | python3 -c 'import json; print(json.loads(input())["result"]);')
