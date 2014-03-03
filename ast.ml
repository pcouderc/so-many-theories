type equation =
| Neq of int * int
| Eq of int * int
type clause = equation list
type clauses = clause list
type cnf = int * int * clauses
type sat_var =
| Var of int
| Not of int
type operation = Op of int * int
type bcnf = sat_var list list
type system = (operation * int) list * bcnf


let string_of_sat_var v =
  match v with
  | Not i -> "!" ^ string_of_int i
  | Var i -> string_of_int i
  

let string_of_system (_, bcnf) = 
  (* String.concat "\n" (List.map ) *)
  String.concat "\n" @@
    List.map (fun disj ->
      String.concat " " (List.map string_of_sat_var disj)) bcnf
