% Journal of Data Science document class file
% v0.1.0 for LaTeX 2e
%
% Copyright (C) 2020 Journal of Data Science Editorial Office
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jds}[2020/04/11 v0.1.0 Journal of Data Science document class]

% options
\newif\if@review
\newif\if@inpress
\newif\if@discussion
\newif\if@chinese

% defaults
\@reviewtrue
\@inpressfalse
\@discussionfalse
\@chinesefalse

% only one of review and inpress can be true
\DeclareOption{review}{\@reviewtrue \@inpressfalse}
\DeclareOption{inpress}{\@reviewfalse \@inpresstrue}
\DeclareOption{discussion}{\@discussiontrue}
\DeclareOption{chinese}{\@chinesetrue \@discussiontrue}

% other options from article.cls
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}

\ProcessOptions

\if@review
\LoadClass[12pt,twoside]{article}
\RequirePackage{setspace}
\doublespacing
% \renewcommand{\baselinestretch}{1.8}
\RequirePackage[left=1in,right=1in,top=1in,bottom=1in]{geometry}
% end of \if@review
\else
\LoadClass[11pt,twoside]{article}
\RequirePackage[left=1.1in,right=1.1in,top=1.1in,bottom=1.1in]{geometry}
% end of \if@inpress
\fi

\if@discussion
\gdef\disfirstpage{0}
\fi

\if@chinese
\RequirePackage[UTF8]{ctex}
\RequirePackage{xeCJK}
\fi

%% reference: biom.cls for short title
\def\title{\@ifnextchar [{\@titletwo}{\@titleone}}
\def\@titletwo[#1]#2{\gdef\@title{{#2}}\gdef\@shorttitle{{#1}}}
\def\@titleone#1{\gdef\@title{{#1}}\gdef\@shorttitle{{#1}}}

%% revised maketitle of article.cls
%% without resetting title etc
\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    % \if@twocolumn
    %   \ifnum \col@number=\@ne
    %     \@maketitle
    %   \else
    %     \twocolumn[\@maketitle]%
    %   \fi
    % \else
    \if@discussion
      %% for discussion, only show first page header style once
      \if\disfirstpage0
        \thispagestyle{firstpage}
        \gdef\disfirstpage{1}
      \else
        \thispagestyle{fancy}
      \fi
    \else
      \newpage
      \thispagestyle{firstpage}
    \fi
    %% Prevents figures from going at top of page.
    \global\@topnum\z@
    \@maketitle
    % \fi
    \@thanks
  \endgroup
  %% reset all default counters
  \setcounter{part}{0}
  % \setcounter{chapter}{0}
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \setcounter{subsubsection}{0}
  \setcounter{paragraph}{0}
  \setcounter{subparagraph}{0}
  % \setcounter{page}{0}
  \setcounter{figure}{0}
  \setcounter{table}{0}
  \setcounter{footnote}{0}
  \setcounter{mpfootnote}{0}
  % for the enumerate environment
  \setcounter{enumi}{0}
  \setcounter{enumii}{0}
  \setcounter{enumiii}{0}
  \setcounter{enumiv}{0}
  % for the eqnarray environment
  \setcounter{equation}{0}
  %% reset thanks
  \global\let\@thanks\@empty
}
\def\@maketitle{%
  \if@discussion
  % do nothing
  \else
    \newpage
  \fi
  % \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\Large\textbf\@title \par}%
    \vskip 1.5em%
    {\normalsize
      \lineskip0.5em%
      \begin{tabular}[t]{c}%
        \baselineskip0.5em
        \@author
      \end{tabular}\par}%
    % \vskip 0.5em%
    % {\large \@date}%
  \end{center}%
  % \par
  % \vskip 0.5em
}

\renewenvironment{abstract}
{%
  % \@beginparpenalty\@lowpenalty
  \begin{center}%
    \ifnum\value{page}=1
      \bfseries Abstract
    \else
      \bfseries \abstractname
    \fi
    % \@endparpenalty
  \end{center}
}
{\par}

\newcommand\keywordsname{
  \gdef\@keywordsname{Keywords}
  \if@chinese
    \ifnum\value{page}>1
    \gdef\@keywordsname{关键词}
    \fi
  \fi
}
\newenvironment{keywords}
{\keywordsname\medskip\noindent\textbf{\@keywordsname}\,\begin{itshape}}
{\end{itshape}}


\newcommand\shorttitle{\gdef\@shorttitle}
\newcommand\jdsreceived{\gdef\@jdsreceived}
\newcommand\jdsaccepted{\gdef\@jdsaccepted}
\shorttitle{}
\jdsreceived{April, 2020}
\jdsaccepted{May, 2020}


% packages
\RequirePackage{graphicx}
\RequirePackage{color}

%% need cm-super package for a better font looking
\RequirePackage[T1]{fontenc}

\RequirePackage[colorlinks=true,citecolor=blue]{hyperref}
\RequirePackage[authoryear,round]{natbib}
\RequirePackage{lastpage}

\RequirePackage{enumitem}
\setlist{nosep}

\RequirePackage[noblocks]{authblk}
\setlength{\affilsep}{0.5em}
\renewcommand\Authfont{\sc} %\bf\scshape}
\renewcommand\Affilfont{\mdseries\slshape\small}

% for running head of author information
\gdef\runningauthors{%
  \begingroup
  \let\thanks\@gobble% ignore \thanks
  \let\footnote\@gobble% ignore \footnote
  \let\textsuperscript\@gobble% ignore protected \textsuperscript
  \expandafter\let\csname textsuperscript \endcsname\@gobble
  \let\Authfont\relax% do not use a special font
  \if@chinese
    \def\Authand{和}
  \else
    \def\Authand{ and }
  \fi
  \AB@authlist% show them all
  \endgroup
}
\newcommand\shortauthors{\gdef\@shortauthors}
\shortauthors{\runningauthors}

\if@discussion
\RequirePackage{subfiles}
\RequirePackage{bibunits}
\defaultbibliographystyle{chicago}
\RequirePackage{etoolbox}
\AtEndPreamble{
  \ifx\@shortauthors\empty
    \shortauthors{\runningauthors}
  \else
  \relax
  \fi
}
\def\jdsrule{
  \newdimen\spaceleft
  \spaceleft=\dimexpr\textheight-\pagetotal\relax
  \if@chinese
  \newpage
  \if@chinese
    \renewcommand\Authand{和}
    \renewcommand\Authands{, 以及}
  \fi
  \else
    \ifdim\spaceleft>20\baselineskip
    \bigskip
    \noindent\rule{\textwidth}{1.5pt}
    \else
    \newpage
    \fi
  \fi
  % reset author and affiliation block
  \global\let\AB@authors\@empty
  \global\let\AB@authlist\@empty
  \global\let\AB@affillist\@empty
  \setcounter{authors}{0}
}
\fi

% \RequirePackage{amsmath}
% \numberwithin{equation}{section}

\newcommand\jdsvolume{\gdef\@jdsvolume}
\jdsvolume{xx}

\newcommand\jdsissue{\gdef\@jdsissue}
\jdsissue{xx}

\newcommand\jdsmonth{\gdef\@jdsmonth}
\jdsmonth{July}

\newcommand\jdsyear{\gdef\@jdsyear}
\jdsyear{2020}

\newcommand\jdsdoi{\gdef\@jdsdoi}
\jdsdoi{xx.xxxx/xxxxxxxx}

% defaults
\title{My JDS Paper Title}
\def\@shorttitle{\@title}

%% define header and footer
\RequirePackage{fancyhdr}
\setlength{\headheight}{24pt}
\pagestyle{fancy}
\fancyhead{} % clear all header fields
\fancyhead[CO]{\textit \@shorttitle}
\fancyhead[CE]{\textit \@shortauthors}
\fancyhead[LE,RO]{\thepage}
\fancyfoot{} % clear all footer fields
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{firstpage}{%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyhf{}%
  \fancyhead[L]{\footnotesize {\scshape Journal of Data Science}
    \@jdsvolume\ (\@jdsissue),
    \thepage--\pageref*{LastPage}\\
    \@jdsmonth\ \@jdsyear
  }
  \fancyhead[R]{\footnotesize DOI:\ \@jdsdoi\\}
  \fancyfoot[LE,RO]{\thepage}% number of the first page
  \fancyfoot[RE,LO]{\footnotesize
    Received \@jdsreceived; Accepted \@jdsaccepted}
}

\if@review
\RequirePackage[pagewise,mathlines]{lineno}
\linenumbers*[1]
%% patches to make lineno work better with amsmath
\newcommand*\patchAmsMathEnvironmentForLineno[1]{%
  \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
  \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
  \renewenvironment{#1}%
  {\linenomath\csname old#1\endcsname}%
  {\csname oldend#1\endcsname\endlinenomath}}%
\newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
  \patchAmsMathEnvironmentForLineno{#1}%
  \patchAmsMathEnvironmentForLineno{#1*}}%
\AtBeginDocument{%
  \patchBothAmsMathEnvironmentsForLineno{equation}%
  \patchBothAmsMathEnvironmentsForLineno{align}%
  \patchBothAmsMathEnvironmentsForLineno{flalign}%
  \patchBothAmsMathEnvironmentsForLineno{alignat}%
  \patchBothAmsMathEnvironmentsForLineno{gather}%
  \patchBothAmsMathEnvironmentsForLineno{multline}%
}
\fi

\setlength{\parskip}{0ex plus0.1ex minus0.1ex}
\setlength{\parindent}{2em}
\setlength{\bibsep}{0em}

%% taken and modified from jss.dtx
\let\code\texttt
\let\proglang\textsf
\newcommand{\pkg}[1]{{\fontshape{it}\selectfont #1}}



\endinput
