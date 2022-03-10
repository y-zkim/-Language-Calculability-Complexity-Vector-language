%{
 
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "anal_synta.tab.h"
#include <string.h>
int yylex(void);
void yyerror(char*);
bool error_syntaxical=false;
extern unsigned int nb_ligne;
extern bool error_lexical;


%}
/* « %union » est structure contenant les attributs d’un symbole (terminal ou variable) et elle permet de changer les types de ces deux variables */


%union {
        long nbval;
        char* texte;
}
 
/*dans cette partie du code on a les Informations sur les opérateurs afin de  spécifier un operateur devant l'autre selon sa position: */
 
%left                   PLUS        MOINS     /* +- */
%left                   FOIS         TOK_DIV         /* /* */
%left                   VERGULE
%right                  PARENTHESE_GAUCHE        PARENTHESE_DROIT       /* () */
%right                  BRACKET_GAUCHE        BRACKET_DROIT        /* [] */


 
/* Dans la partie %type permet de déclarer les noms et les types des symboles non terminaux */
 
%type<texte>            terme
%type<texte>            debut_de_prog
%type<texte>            fin_de_prog
%type<texte>            instruction
%type<texte>            IDENT
%type<texte>            exp_arithm
%type<texte>            affectation
%type<texte>            affichage
%type<texte>            expression
%type<texte>            identificateur
%type<texte>            multiplication
%type<texte>            differance
%type<texte>            addition
 
/* Dans cette partie on cite les terminaux de notre grammaire qui sont deja decrit dans la partie grammaire */

%token<texte>           NB_ENT
%token                  DEBUT       /* BEGIN */
%token                  LA_FIN        /* FIN. */
%token                  AFFECT     /* := */
%token                  DEUX_POINT_VIRGULE      /* ; */
%token                  VERGULE        /* , */
%token                  AFFICHAGE    /* afficher */
%token<texte>           variable_arti        /* variable arithmetique */
%token<texte>           variable_identifi       /* variable identificateur */
 
%%
 
/* nous n'avons pas utliser la clause %start car on a definie les axiomes ici (les non terminaux de notre grammaire)  */
/* Dans la suite du programme on va utliser strcat  pour faire la concaténation des expression afin de les afficher si on 
veut ou pour un traitement quelconque */


terme:           %empty{}/* s'il y a une ligne vide on l'ingnore*/
                |
                /* si on trouve un terme puis une instruction on va aller vers la partie des instruction s'il existe on va afficher se message */
                terme instruction{
                        printf("Reponse : [+] [L'instruction est valider]\n");
                }
                |
                /* si on a pas trouve une instruction valider qui est decrit dans notre analyseur syntaxique on affiche erreur*/
                terme error{
                        fprintf(stderr,"\til y a une error  de syntaxe au niveau la ligne %d.\n",nb_ligne);
                        error_syntaxical=true;/* on cas d'une erreur on change la valeur de la bool error_syntaxical*/
                };
            

instruction:    affectation{
                        printf("\tC'est une Affectation\n");/* si on trouve une affectation " := " l'affectation est decrit par la suite*/
                }
                |
                affichage{
                         printf("\tC'est un Affichage\n");/* si on trouve un affichage  " fonction afficher(..)" */
                }
                |
                debut_de_prog{
                         printf("\tC'est le debut du notre programme\n");/* si on trouve un debut de programme " BEGIN" */
                }
                |
                fin_de_prog{
                        printf("\tC'est la fin du notre programme\n");/* si on trouve une fin de programme " FIN." */
                };
 
 
IDENT           : variable_identifi{
                                printf("\t\t\tVariable %s\n",$1);
                                $$=strdup($1);
                                
                        };
                        
exp_arithm :  variable_arti{
                                printf("\t\t\tVariable %s\n",$1);
                                $$=strdup($1);
                        };                                           
 
affectation:    IDENT AFFECT identificateur DEUX_POINT_VIRGULE{
                        printf("\t\tAffectation a la variable %s\n",$1);
                }
                |
                IDENT AFFECT expression DEUX_POINT_VIRGULE{
                        printf("\t\tAffectation a l'identificateur %s\n",$1);
                };
                

affichage:      AFFICHAGE identificateur DEUX_POINT_VIRGULE{
                        printf("\t\tAffichier l'expression %s\n",$2);
                /* ici c'est on trouve un affichage */        
                };
                
debut_de_prog:          DEBUT {
                        printf("\t\tOn commance notre programme\n");
                        /* ici c'est on trouve un debut de programme */ 
                };
                
fin_de_prog:            LA_FIN {
                        printf("\t\tC'est la fin de notre programme\n");
                        /* ici c'est on trouve une fin */ 
                };
                
                
 
identificateur  :      expression  FOIS identificateur {
                       /* si on trouve un produit scalaire 5 * vecteur */
                                        printf("\t\t\tUn produit scalaire\n");
                                        $$=strcat(strcat(strdup($1),strdup("*")),strdup($3));
                                        printf("\t\t  %s\n", $$);
                                }
                                |
                                IDENT{
                                        $$=strdup($1);
                                }
                                |
                                addition {
                                }
                                |
                                differance{
                                }
                                |
                                multiplication{
                                }
                                |
                                PARENTHESE_GAUCHE identificateur PARENTHESE_DROIT{
                                        $$=strcat(strcat(strdup("("),strdup($2)),strdup(")"));
                                        printf("\t\t\t Identificateur entre les parentheses %s\n",$$);
                                        /* on afficher identificateur entre les () */
                                };
                            
 
expression :        NB_ENT {
                                        printf("\t\t\tEntier : %ld\n",$1);
                                        /* on fait la conversion du tokens nombre. puis parce qu'on sait pas la longeur de nombre entre on 
                                        fait alloer de la memoire puis le converter puis le concaténe .*/
                                        int length=snprintf(NULL,0,"%ld",$1);
                                        char* str=malloc(length+1);
                                        snprintf(str,length+1,"%ld",$1);
                                        $$=strdup(str);
                                        free(str);
                                }
                                |
                                exp_arithm{
                                        $$=strdup($1);
                                }
                                |
                        //dans le cas ou la valeur entre et negative on teste si on a un signe - puis une expression exemple -5
                                MOINS expression{
                                        printf("\t\t\t ENTIER negative\n");
                                        $$=strcat(strcat(strdup("-"),strdup($2)),strdup(","));
                                }
                                |
                        //dans le cas ou on a une expression qui comme de suite [5,...
                                expression VERGULE expression{
                                        printf("\t\t\t  Entier qui se trouver entre [ et ,\n");
                                        $$=strcat(strcat(strdup($1),strdup(",")),strdup($3));
                                }
                                |
                        //dans le cas ou on a une expression qui entre deux virgule ...,5,...
                                VERGULE expression VERGULE{
                                        printf("\t\t\t  Entier entre deux vergule , ,\n");
                                        $$=strcat(strcat(strdup("{-"),strdup($2)),strdup(","));
                                }
                                |
                        //dans le cas ou on a une expression qui entre deux virgule et BRACKET DROITe comme ...,6]
                                VERGULE expression BRACKET_DROIT{
                                        printf("\t\t\t  Entier qui se trouve entre , et ] \n");
                                        $$=strcat(strcat(strdup(","),strdup($2)),strdup("}"));
                                }
                                |
                        //dans le cas ou on a une expression qui entre  les deux  comme [2,6]        
                                BRACKET_GAUCHE expression BRACKET_DROIT{
                                        printf("\t\t\t Entier entre les [ ] \n");
                                        
                                        $$=strcat(strcat(strdup("{"),strdup($2)),strdup("}"));
                                };
                                
    
                               
/* Dans le cas de l'addition de deux identificateur exmpel U + V */ 
addition :  identificateur PLUS identificateur {printf("\t\t\taddition\n");$$=strcat(strcat(strdup($1),strdup("+")),strdup($3));};
/* Dans le cas de la differance */
differance: identificateur MOINS identificateur{printf("\t\t\tdifference\n");$$=strcat(strcat(strdup($1),strdup("-")),strdup($3));};
/* Dans le cas de la multiplication */
multiplication: identificateur FOIS identificateur{printf("\t\t\tmultiplication par scalaire \n");$$=strcat(strcat(strdup($1),strdup("*")),strdup($3));};
 
%%
 
/* Dans notre fonction main on utiliser la fonction yyparse() qui va aussi appelle à chaque
fois la fonction « yylex() » pour obtenir le prochain lexème de l’entrée. */
 
int main(void){
        printf("Bonjour dans l'analyseur syntaxique du langage VECTEUR realiser par LEMLIH ET ZKIM ENCADRE PAR M.DARGHAM ABDELMAJID :\n");
        yyparse();
        printf("Le resultat de l'analyse syntaxique de ton programme :\n");
        if(error_lexical){
                printf("\t   il y a des erreur dans les  lexemes  qui ne font pas partie du lexique du langage ! \n");
                printf("\t   il y a des erreur dans l'analyse lexicale \n");
        }
        else{
                printf("\t [+] [l'analyseur lexicale termine sans aucun probleme]  ! \n");
        }
        if(error_syntaxical){
                printf("\t il y a des phrases sont syntaxiquement incorrectes ! \n");
                printf("\t des erreur dans l'analyse lexicale \n");
        }
        else{
                printf("\t [+] [l'analyseur syntaxique termine sans aucun probleme] ! \n");
        }
        return EXIT_SUCCESS;
}
/*la fonction « yyerror() » pour être invoquée automatiquement lorsqu’une erreur syntaxique est rencontrée.*/   
/*alors dans le cas d'erreur on utilise la valeur de la varibale nb_ligne pour indique ou il existe exacement*/

void yyerror(char *s) {
        fprintf(stderr, "il y a une erreur de syntaxe a la ligne %d: %s\n", nb_ligne, s);
}
