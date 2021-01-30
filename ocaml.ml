(* let listIterator list =
    let rec iterate = function
    | [] -> []
    | head :: tail -> print_string head; print_string ";"; iterate tail 
    in iterate list
;; *)

let getWord (l,_) = l;; (* Returns the 2nd position of the tuple (word) *)
let getBin (_,b) = b;; (* Returns the 1st position of the tuple (bin) *)

let convert (l,b)=([(Char.escaped l)],b);; (* Returns the 1st position of the tuple in a list with a string *)
let convertList list = (* Returns the list with convert in all tuples *)
    let rec convert_iterate save = function
    | [] -> save
    | head :: tail -> convert_iterate (save@[(convert head)]) tail 
    in convert_iterate [] list
;;

let printWord list = (* Prints every word in the list *)
    print_string "[";
    let rec iterate = function
    | [] -> []
    | head :: tail -> print_string head; print_string ";"; iterate tail 
    in iterate list;
    print_string "]";
;;

let printBin list = (* Prints every Bin in the list *)
    print_string "[";
    let rec iterate = function
    | [] -> []
    | head :: tail -> print_int head; print_string ";"; iterate tail 
    in iterate list;
    print_string "]";
;;

let result [r1;r2] = (getBin r1,getWord r1,getWord r2);;
let print_result (a,b,c) = print_string "("; printBin a; print_string "---->";printWord b;print_string ";";printWord c; print_string ")\n";;

let printWordList list = 
    print_string "[";
    let rec iterate = function
    | [] -> []
    | head :: tail -> printWord (getWord head); print_string ";"; iterate tail 
    in iterate list;
    print_string "]\n";
;;

let printBinList list = 
    print_string "[";
    let rec iterate = function
    | [] -> []
    | head :: tail -> printBin (getBin head); print_string ";"; iterate tail 
    in iterate list;
    print_string "]\n";
;;



let printCodList list = 
    print_string "[";
    let rec iterate = function
    | [] -> []
    | head :: tail ->  printWord (getWord head);print_string "->";printBin (getBin head);print_string ";"; iterate tail 
    in iterate list;
    print_string "]\n";
;;


let merge (word_1,bin_1) (word_2,bin_2) = [(word_1@word_2),(bin_1@bin_2)];;

(*loop interior que faz a concatnação de um elemento da lista com todos os elementos da lista*)


let rec listHeader = function
	| [] -> ([], [])
	| head :: tail -> head
;;


let loop_append list cod prev = 
    let rec loop_append_iterate = function
    | [] -> prev
    | head :: tail -> loop_append_iterate tail@prev@(merge cod head)
    in loop_append_iterate list
;;

let loop_merge list list_null = 
    let rec loop_merge_iterate save = function
    | [] -> save
    | head :: tail ->  loop_merge_iterate (save@(loop_append list head list_null)) tail
    in loop_merge_iterate list_null list
;;

(*juntar as listas*) (*save ==list2*)
let list_merge list1 list2 = 
    let rec list_merge_iterate save = function
    | [] -> save
    | head :: tail ->  if List.mem head list2 then list_merge_iterate save tail

    else list_merge_iterate (save@[head]) tail
    in list_merge_iterate list2 list1
;;

(*same *) (*corrigir a e ac para a e c*)
let process list save cod =     
    let rec process_iterate cod = function
    | [] -> save
    | head :: tail -> if getBin cod = getBin head && getWord cod <> getWord head  
    then (if save = [] then [cod;head] 
    else if List.length (getWord cod) < List.length (getWord (listHeader save))
    then [cod;head] 
    else if List.length (getWord cod) = List.length (getWord (listHeader save)) && 
            List.length (getBin cod) < List.length (getBin (listHeader save))
        then [cod;head] 
        else process_iterate cod tail) 

    else process_iterate cod tail

    in process_iterate cod list
;;
(*same cod*)

let is_ambigous list = 
    let rec is_ambigous_iterate save = function
    | [] -> save
    | head :: tail ->  is_ambigous_iterate (process list save head) tail 
    in is_ambigous_iterate [] list
;;

let rec main list = if is_ambigous list <> [] then is_ambigous list 
    
    else main (list_merge list (loop_merge list []))
;;

let ex1 =
	[('a', [0;1;0;]);
	('c', [0;1]);
	('j', [0;0;1]);
	('l', [1;0]);
	('p', [0]);
	('s', [1]);
	('v', [1;0;1])]
;;

let ex2 = 
	[('a', [0;1;1;0]);
    ('b', [0;1;1;1;1;1]);
    ('c', [1;1;0;0;1;1;1;1]);
    ('f', [1;0;1;1;1;0]);
    ('j', [0;1;0]);
    ('l', [0;1;0;0]);
    ('r', [0;1;1;1;0])]
;;

let test = 
    [(["a"],  [0;0;0;1]);
    (["b"], [0;1]);
    (["c"], [0;0;0;1]);]
;;

(*printCodList (is_ambigous lista);;*)
(*printCodList (loop_append lista (["b"], [0;1]) []);;*)
(*printCodList (list_merge lista (loop_merge lista []));;*)
print_result (result (main (convertList ex1)));;
