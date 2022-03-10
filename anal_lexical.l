%{
/*on fait l'inclusion de tous les bibliotheque qu'on va utiliser par la suite dans notre code tel que printf ect ...*/
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include "anal_synta.tab.h"
int yylex(void);
void yyerror(char*);
/*cette variable va nous aider a savoir le nombre de ligne liser dans un programme est dans le cas ou on 
trouve une erreur on va indique ou il existe*/
unsigned int nb_ligne=1;
/*cette variable on la initialiser par false et si on trouve une erreur lexical on va la affecter true 
et puis on va voir est qu'il y a une erreur */
bool error_lexical=false;
 
%}
 
%option noyywrap
 
NBENT [0-9]+
IDENT U|V|W|X|Y

/*si on trouve un nombre dans un programme on va le stocke dans le champs valeur */
/*la fonction atoi est utiliser pour la conversion vers un entier */ 
/*si on trouve un identificateur on va le stocke dans le champs texte de la stracture yyllval*/
/* pour yylval notre l’analyseur lexical stocke dans cette variable les attributs de l’unité
lexicale reconnue . L’analyseur syntaxique récupère ces attributs en lisant cette variable.*/

%%
 

{NBENT} {
        yylval.nbval = atoi(yytext);
        return NB_ENT;
}
{IDENT} {
        yylval.texte = yytext;
        return variable_identifi;
}

"BEGIN"      {return DEBUT;}
 
"FIN."      {return LA_FIN;}

"afficher"      {return AFFICHAGE;}
 
":="             {return AFFECT;}
"+"             {return PLUS;}
"-"             {return MOINS;}
"*"             {return FOIS;}
"("             {return PARENTHESE_GAUCHE;}
")"             {return PARENTHESE_DROIT;}
"["             {return BRACKET_GAUCHE;}
"]"             {return BRACKET_DROIT;}
";"             {return DEUX_POINT_VIRGULE;}
","             {return VERGULE;}
"\n"            {nb_ligne++;}



 
" "|"\t" {}
 
. {
        fprintf(stderr,"\t il y a une error au niveau d'un lexemes dans la ligne %d. Il s'agit de %s et comporte %d lettre(s)\n",nb_ligne,yytext,yyleng);
        error_lexical=true;
        return yytext[0];
}
 
%%