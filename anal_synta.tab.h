/* A Bison parser, made by GNU Bison 3.7.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_ANAL_SYNTA_TAB_H_INCLUDED
# define YY_YY_ANAL_SYNTA_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    PLUS = 258,                    /* PLUS  */
    MOINS = 259,                   /* MOINS  */
    FOIS = 260,                    /* FOIS  */
    TOK_DIV = 261,                 /* TOK_DIV  */
    PARENTHESE_GAUCHE = 262,       /* PARENTHESE_GAUCHE  */
    PARENTHESE_DROIT = 263,        /* PARENTHESE_DROIT  */
    BRACKET_GAUCHE = 264,          /* BRACKET_GAUCHE  */
    BRACKET_DROIT = 265,           /* BRACKET_DROIT  */
    NB_ENT = 266,                  /* NB_ENT  */
    DEBUT = 267,                   /* DEBUT  */
    LA_FIN = 268,                  /* LA_FIN  */
    AFFECT = 269,                  /* AFFECT  */
    DEUX_POINT_VIRGULE = 270,      /* DEUX_POINT_VIRGULE  */
    VERGULE = 271,                 /* VERGULE  */
    AFFICHAGE = 272,               /* AFFICHAGE  */
    variable_arti = 273,           /* variable_arti  */
    variable_identifi = 274        /* variable_identifi  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 19 "anal_synta.y"

        long nbval;
        char* texte;

#line 88 "anal_synta.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_ANAL_SYNTA_TAB_H_INCLUDED  */
