(* Cycles in lists are not actually supported by sml,
   so this implementation, although is passes sml type
   inference, is only theoretical *)
fun start_loop_finder(nil)=false
|	start_loop_finder(x1::nil)=false
|	start_loop_finder (x1::x2::nil)=false
|	start_loop_finder (x1::x2::xs) = loop_finder(x1::x2::xs, x2::xs)

fun loop_finder(x::xs, x::xs) = true
|	loop_finder(x::xs, y::nil) = false
|	loop_finder(x::xs, nil) = false
|	loop_finder(x::xs, y::y1::ys) = loop_finder(xs, ys)

fun make_loop(xs) = make_loop_helper(xs, xs)

fun make_loop_helper(xs, y::nil) = y::xs
|	make_loop_helper(xs, y::ys) = make_loop_helper(xs, ys)