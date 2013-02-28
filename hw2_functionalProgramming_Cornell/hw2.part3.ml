(*search engine. The term frequency of a term t in a document d is defined as the number of times that t appears in d. We will use TF to give more weight to documents that contain many occurrences of a given term mentioned in the search query*)

(*write a function tf: string list-> string-> float that takes in a document as a string list, and a term as a string, and returns the log-weighted TF as described above*)
let tf (lst: string list) (str: string):float = 
  let count =  List.fold_left ( fun acc x -> if x = str then acc+1 else acc) 0 lst in 1.0 +. log10 ( float_of_int count ) ;;
tf ["3110"; "is"; "fun"; "or"; "is"; "it"] "fun";;

(*The inverse document frequency of a term a is defined as N/df where N is the total number of documents, and df is the number of documents that a occurs in. We will use IDF to reduce the weight of terms which are very common and appear in many documents(e.g.,"the") and hence are of less use*)

(*write a function idf:string list list-> string->float that takes in the database(list of documents) and a term and returns the log-weighted IDF*)

let idf (lst: string list list) (str: string):float = 
  let n = List.length lst in
  let df = List.fold_left ( fun acc x -> if List.mem str x then acc+1 else acc ) 0 lst in
  log10 (( float_of_int n) /.(float_of_int df));;
idf [["Ocaml"; "is"; "fun"];["because";"fun";"is";"a"]; ["keyword"]] "fun";;
idf [["Ocaml"; "is"; "fun"];["because";"fun";"is"; "a"; "keyword"]] "fun";;

