(*list folding*)
(*write a function min2: int list -> int that returns the second-smallest element of a list, when put into sorted order. For full credit, use a fold function and do not sort the list. If the list contains 0 or 1 elements, raise an exception with a helpful message*)
let min2 (lst: int list):int = 
  match lst with 
  []-> raise (Failure "List is empty")
  | _::[]-> raise (Failure " Only one element in the list")
  | ht::ht1::tl-> let (x1,y) =  List.fold_left (fun acc x -> let (p1,p2) = acc in if x>=p1 then (p1,p2) else if x<= p2 then (p2,x) else (x,p2)) (if ht>ht1 then (ht,ht1) else (ht1,ht)) tl
  in x1;;
min2 [2100;4820; 3110; 4120];;

(*write a function conse_dedupe:('a->'a->bool)->'a list->'a list that removes consecutive duplicate values from a list.*)
let consec_dedupe (f:'a -> 'a -> bool)(lst:'a list):'a list =
  match lst with 
  []-> []
  | _::[]-> lst
  | ht::tl->
   let (x1,y) =  List.fold_left (fun acc x -> let (p1,p2) = acc in if f p1 x then acc else (x,p2@[x])) (ht,[ht]) tl 
   in y;;

consec_dedupe ( = ) [1;1;1;3;4;4;3];;

(*write a function prefixes: 'a list->('a list) list that returns a list of all non-empty prefixes of a list, ordered from shortest to longest*)
let prefixes (lst:'a list):'a list list =
  match lst with 
  []-> raise (Failure "List is empty")
  |x::[]-> [[x]] 
  |ht::tl-> 
  let (x1,y) = List.fold_left (fun acc x -> let (p1,p2) = acc in let newp= p1@[x] in (newp, p2@[newp])) ([ht],[[ht]]) tl in y;;
prefixes [1;2;3;4];;

(*write a function k_sublist: int list-> int -> int list. Given a list of integers lst and an integer k, the function k_sublist computes the contiguous sublist of length k whoes elements have the largest sum*)

let k_sublist (lst: int list) (k: int): int list = 
  let length = List.length lst in
  if length < k then raise ( Failure "List is too short" )
  else if length = k then lst
  else 
    match lst with
      hd::tl ->  let (_,_,_,_,result,_) = List.fold_left ( fun acc x ->  let (p1,p2,p3,p4,p5,p6) = acc in 
                                                           if p2<k then ( hd, p2+1, p3+x, p4@[x],p5@[x],p6+x ) 
                                                           else 
                                                             match p4 with hdd::tll -> 
                                                               let currentList = tll@[x] in 
                                                               let sumEndHere = p3-p1+x in 
                                                                  if sumEndHere > p6 then (hdd,p2,sumEndHere,currentList,currentList, sumEndHere) 
                                                                   else (hdd,p2,sumEndHere,currentList,p5,p6)
                                                             | []-> raise (Failure "Wrong here")) (hd,1,hd,[hd],[hd],hd) tl in result
    | []->[];;
k_sublist [1;2;3;4;-1;-6;100] 3;;

(*The powerset of a set A is the set of all subsets of A. Write a function powerset:'a list -> 'a list list such that powerset s returns the powerset of s, interpreting lists as unordered sets. You may assume there are no duplicate elements in s. More precisely, for every subset T of s, there is a list in powerset s that contains exactly the elemtents of T*)

let powerset (lst: 'a list):'a list list = 
  List.fold_left ( fun acc x -> acc @ List.map (fun d -> d@[x]) acc ) [[]] lst;;
powerset [1;2;3];;
