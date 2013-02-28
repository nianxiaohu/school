(*function cond_dup takes in a list and preciate and duplicate all elements which satisfy all condition expressed in the predicate*)
(*#use "hw1.part3.ml" *)
let rec cond_dup (lst: 'a list) (f: 'a -> bool): 'a list = 
  match lst with
  []->[] 
  | ht::tl -> if f ht then (ht::[ht])@(cond_dup tl f) else ht::cond_dup tl f ;;
cond_dup [3;4;5] (fun x-> x mod 2 = 1 );;

(*function n_times:('a->'a)*int*'a -> 'a such that n_times(f,n,v) applies f to v n times*)
let rec n_times (f,n,v) =
  if n = 0 
  then v
  else n_times(f,n-1, f v);;
n_times ((fun x-> x+1), 50, 0);;

(*function range: int -> int -> int list such that range num1 num2 returns an ordered list of all integers from num1 to num2 inclusive*)
let rec range (num1:int) (num2:int): int list = 
  if num2 < num1 then raise ( Failure "num2 < num1" )
  else if num1 = num2 then [num2] else num1::range (num1+1) num2;;
range 2 5;;

(*function zipwith:('a->'b->'c)->'a list->'b list->'c list such that zipwith f l1 l2 generates a list whose ith element is obtained by applying f to the ith element of l1 and the ith element of l2. If the lists have different lengths, the extra arguments in the longer list should be ignored. For example, zipwith (+) [1;2;3] [4;5]=[5;7]*)
let rec zipwith (f:'a->'b->'c) ( lst1: 'a list )( lst2: 'b list): 'c list = 
  match (lst1,lst2) with
  ([],_)->[]
  |(_,[])->[]
  |(ht1::tl1, ht2::tl2) -> f ht1 ht2 :: zipwith f tl1 tl2;;
zipwith ( * ) [1;2;3] [4;5];;

let hyp a b =
  let d x = (x,x) in
  let u (x1,x2) f = f x1 x2 in
  let p f x = f x in
  p sqrt (u (u (d a) ( *. ), u (d b)( *. ))( +. ));;
hyp 3.0 4.0;;

(*write a function buckets: ('a -> 'a->bool) -> 'a list -> 'a list list that partitions a list into equivalence classes. That is, buckets equiv lst should return a list of lists where each sublist in the result contains equivalent elements, where two elements are considered equivalent if equiv returns true.*)

let buckets (f:'a->'a->bool) (lst:'a list): 'a list list =
  let rec find (find_f: 'a->'a->bool)(find_ht: 'a) (find_acc:'a list list):'a list list = 
    match find_acc with
    []-> [[find_ht]]
    | head::tail -> match head with h::_-> if f h find_ht then (find_ht::head)::tail else head::(find f find_ht tail)
  in
  let rec parse (parse_f: 'a->'a->bool) (parse_lst:'a list) (parse_acc: 'a list list): 'a list list = 
    match parse_lst with
    [] -> parse_acc
    | ht::tl -> parse f tl (find f ht parse_acc) 
  in 
  match lst with 
  []->[]
  | ht::tl -> parse f tl [[ht]];;
buckets ( = ) [1;2;3;4];;
buckets ( = ) [1;2;3;4;2;3;4;3;4];;
buckets (fun x y -> ( = ) (x mod 3) (y mod 3) ) [1;2;3;4;5;6];;

