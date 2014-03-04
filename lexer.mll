{

  open Parser
  open Lexing

  exception Lexical_error of string

  let newline lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_lnum = pos.pos_lnum + 1; pos_bol = pos.pos_cnum;
        pos_cnum=0 }

}

let alpha = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']

rule token = parse
  | '=' { EQ }
  | "<>" { NEQ }
  | 'p' { P }
  | "cnf" { CNF }
  | digit+ as s {
    let i = try int_of_string s
      with
      | Failure s ->
	raise (Lexical_error ("illegal character: " ^ lexeme lexbuf))
    in
    INTEGER i }
  | '\n' { newline lexbuf; EOL }
  | eof { EOF }
  | [' ' '\t' '\r']+ { token lexbuf }
  | "c " [^'\n']* '\n' { newline lexbuf; token lexbuf }
  | _
      { raise (Lexical_error ("illegal character: " ^ lexeme lexbuf)) }

{

}
