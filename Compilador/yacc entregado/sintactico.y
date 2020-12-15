%{
 #include <stdio.h>
 #include <stdlib.h>
 extern int yylex(void);
 extern char *yytext;
 extern int yylineno;
 extern int l;
 extern int errores;
 extern FILE *yyin;
 void yyerror(char *s);
 extern FILE *ce,*sal;
%} 
%token PROGRAM
%token VAR
%token BEGI
%token END
%token id
%token dospuntos
%token tipod
%token cparentesis
%token pfor
%token aparentesis
%token igual
%token NUMEROS
%token punto_coma
%token Op_relacionales
%token op_unarios
%token llavea
%token cond_if
%token cond_else
%token llavec
%token mas
%token menos
%token otro
%token scan
%token print
%token comilla
%token porciento
%token letrad
%token letrac
%token letras
%token letralf
%token ampersand
%token coma
%start INICIO
%%
  INICIO: PROGRAM id VAR listaDeclaraciones BEGI listaProposiciones END|error id VAR listaDeclaraciones BEGI listaProposiciones END|PROGRAM error VAR listaDeclaraciones BEGI listaProposiciones END|PROGRAM id error listaDeclaraciones BEGI listaProposiciones END| PROGRAM id VAR listaDeclaraciones error listaProposiciones END|PROGRAM error error listaDeclaraciones BEGI listaProposiciones END;  
  listaDeclaraciones: declaracion | declaracion listaDeclaraciones ;
  declaracion: n2 dospuntos tipod punto_coma|error dospuntos tipod punto_coma|n2 error tipod punto_coma|n2 dospuntos error punto_coma|n2 dospuntos tipod error;
  listaProposiciones: Proposicion| Proposicion listaProposiciones;
  Proposicion: CicloFors|Asignacion|Lectura|Escritura|Estructura_Control;
  CicloFors: pfor aparentesis id igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|error aparentesis id igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor error id igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis error igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id error NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual error punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS error id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma error Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma id error NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma id Op_relacionales error punto_coma id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma id Op_relacionales NUMEROS error id  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma error  op_unarios cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  error cparentesis llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios error llavea listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis error listaProposiciones llavec|pfor aparentesis id igual NUMEROS punto_coma id Op_relacionales NUMEROS punto_coma id  op_unarios cparentesis llavea listaProposiciones error;
  Asignacion: id igual Exp punto_coma 
  |id igual Exp error|error igual Exp punto_coma|id error Exp punto_coma|id igual error punto_coma;
  
  n2: id {printf("%s\n",yytext);};

  Exp: Term
	|Exp mas Term
	|Exp menos Term ;
  Term: Factor
	|Term otro Factor;
  Factor: NUMEROS 
	|aparentesis Exp cparentesis;
  Lectura: scan aparentesis comilla P comilla W cparentesis punto_coma|error aparentesis comilla P comilla W cparentesis punto_coma|scan error comilla P comilla W cparentesis punto_coma|scan aparentesis error P comilla W cparentesis punto_coma|scan aparentesis comilla P error W cparentesis punto_coma|scan aparentesis comilla P comilla W error punto_coma|scan aparentesis comilla P comilla W cparentesis error;
  Escritura: print aparentesis comilla Cadena comilla cparentesis punto_coma|error aparentesis comilla Cadena comilla cparentesis punto_coma|print error comilla Cadena comilla cparentesis punto_coma|print aparentesis error Cadena comilla cparentesis punto_coma|print aparentesis comilla error comilla cparentesis punto_coma|print aparentesis comilla Cadena error cparentesis punto_coma|print aparentesis comilla Cadena comilla error punto_coma|print aparentesis comilla Cadena comilla cparentesis error;;
  Cadena: cad | cad Cadena;
  cad: PA|id |dospuntos |tipod |cparentesis |aparentesis |igual |NUMEROS| punto_coma |Op_relacionales |op_unarios |llavea| llavec |mas| menos |otro| ampersand |coma;
  P: PA| PA P;
  PA: porciento letrad  | porciento letrac  | porciento letralf | porciento letras |error ;
  W: WA | WA W;
  WA: coma ampersand id|error ;
  Estructura_Control: cond_if aparentesis Condicion cparentesis llavea listaProposiciones llavec| cond_else llavea listaProposiciones llavec|error aparentesis Condicion cparentesis llavea listaProposiciones llavec|cond_if error Condicion cparentesis llavea listaProposiciones llavec|cond_if aparentesis Condicion error llavea listaProposiciones llavec|cond_if aparentesis Condicion cparentesis error listaProposiciones llavec|cond_if aparentesis Condicion cparentesis llavea listaProposiciones error|error llavea listaProposiciones llavec|cond_else error listaProposiciones llavec|cond_else llavea listaProposiciones error;
  Condicion: n Op_relacionales n|n error n;
  n:
    id
    |NUMEROS
    |error;
%%
main() {
 int i,j,band;
 if ((ce = fopen("codigo.txt", "rt"))  == NULL){
	 printf("Cannot open input file.\n");
	 exit(1);
 }
 printf("\n");
 fprintf(sal," lexema      #token #linea\n\n");
 yyin=ce;
 yyparse();
 printf("\n      %d lineas compiladas",l);
 printf("\n      %d errores encontrados\n",errores);
 fclose(ce);
}
void yyerror(char *msg){
	//printf("%c\n",yytext[4]);
	printf("  %-15s %s linea: %d\n",yytext,msg,yylineno);
	errores++;
}