% mycv.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mycv}[2015/12/29 A personal class for my cv. Requires biblatex and biber.]

\LoadClass{article}

\RequirePackage{iftex}
\RequireLuaTeX

% ------------------------------------------------------------------------------------------------
% OPTIONS
% ------------------------------------------------------------------------------------------------

\RequirePackage{kvoptions}

% Metadata options
\DeclareStringOption[{Adam Liter}]{name}
\DeclareStringOption[{adamlitercv}]{title}
\DeclareStringOption[{adam.liter@gmail.com}]{email}
\DeclareStringOption[{+1-952-807-5616}]{phone}
\DeclareStringOption[{msu.edu/\textasciitilde literada}]{website}
\DeclareStringOption[{https://msu.edu/~literada}]{websiteurl}
\DeclareStringOption[{222 Horton St, Lansing, MI 48912}]{address}
\DeclareStringOption[{adamliter}]{github}
\DeclareStringOption[{Adam Liter, cv, adamlitercv, vita, curriculum vitae, linguistics}]{keywords}

% Font options
\DeclareStringOption[{Adobe Garamond Pro}]{mainfont}
\DeclareStringOption[{Inconsolata}]{monofont}
\DeclareStringOption[{Italianno}]{titlefont}
\DeclareStringOption[{Raleway}]{headerfont}
\DeclareStringOption[{OpenSansEmoji}]{emojifont}

\ProcessKeyvalOptions*

% ------------------------------------------------------------------------------------------------
% METADATA
% ------------------------------------------------------------------------------------------------

\newcommand*{\myauthor}{\mycv@name}
\newcommand*{\mytitle}{\mycv@title}
\newcommand*{\myemail}{\mycv@email}
\newcommand*{\myphone}{\mycv@phone}
\newcommand*{\mywebsite}{\mycv@website}
\newcommand*{\mywebsiteurl}{\mycv@websiteurl}
\newcommand*{\myaddress}{\mycv@address}
\newcommand*{\mygithub}{\mycv@github}
\newcommand*{\mykeywords}{\mycv@keywords}

% ------------------------------------------------------------------------------------------------
% FONTS
% ------------------------------------------------------------------------------------------------

\RequirePackage{fontspec}
\setmainfont
  [
    Ligatures={
      TeX,
      Common
    },
    BoldFont={* Semibold}
  ]
  {\mycv@mainfont}
  
\setmonofont
  []
  {\mycv@monofont}

\newfontfamily\TitleFont
  [
    %Ligatures={
    %  TeX,
    %  Common
    %}
  ]
  {\mycv@titlefont}

\newfontfamily\HeaderFont
  [
    Ligatures={
      TeX,
      Common
    }
  ]
  {\mycv@headerfont}

\newfontfamily\EmojiFont{\mycv@emojifont}

\RequirePackage{fontawesome}

\newfontfamily\BulletFont[Scale=.8]{Linux Libertine O}

% ------------------------------------------------------------------------------------------------
% DOCUMENT STUFF
% ------------------------------------------------------------------------------------------------

\RequirePackage{amsmath}

\def\@maketitle{%
  \begin{center}
    {\Huge\TitleFont\myauthor}%
    \,%
    $\begin{cases}%
      \text{\PrintAddress}\\
      \text{\PrintPhone}\\
      \text{\PrintEmail}\\
      \text{\PrintWebsite}\\
      \text{\PrintGitHub}\\
    \end{cases}$%
  \end{center}%
  \vspace{-2\baselineskip}%
}

\RequirePackage{enumitem}

\setlist[itemize,1]{label=$\bullet$}
\setlist[itemize,2]{label=\BulletFont\raisebox{.25ex}{■}}

\RequirePackage
  [
    margin=1in
  ]
  {geometry}

\RequirePackage{parskip}

\RequirePackage{titlesec}

\titleformat{\section}
  {\HeaderFont\Large\scshape\raggedright}
  {\thesection}
  {1em}
  {}
  [\titlerule]
  
\titleformat{\subsection}
  {\HeaderFont\large\scshape\raggedright}
  {\thesubsection}
  {1em}
  {}
  
\titleformat{\subsubsection}
  {\HeaderFont\normalsize\scshape\raggedright}
  {\thesubsubsection}
  {1em}
  {}

% ------------------------------------------------------------------------------------------------
% HEADER AND FOOTER
% ------------------------------------------------------------------------------------------------

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\lhead{}
\chead{}
\rhead{}
\lfoot{Last updated: \today}
\cfoot{}
\rfoot{\thepage/\pageref{LastPage}}
\pagestyle{fancy}

% ------------------------------------------------------------------------------------------------
% FOR BIBLIOGRAPHIC STUFF
% ------------------------------------------------------------------------------------------------

\RequirePackage
  [american]
  {babel}
\RequirePackage{csquotes}
\RequirePackage
  [
    backend=biber,
    bibstyle=biblatex-sp-unified,% see https://github.com/semprag/biblatex-sp-unified
    maxbibnames=99,
    defernumbers=true,% for the new bibenvironment
    sorting=ydmdDdt
  ]
  {biblatex}

% New bibliography environment with years in the margins  
\defbibenvironment{bibliography}
  {\list
     {\iffieldequals{year}{\bibyear}
        {}
        {\printfield{year}%
         \savefield{year}{\bibyear}}}
     {\setlength{\leftmargin}{\bibhang}%
      \setlength{\itemindent}{-\leftmargin}%
      \setlength{\itemsep}{\bibitemsep}%
      \setlength{\parsep}{\bibparsep}}}
  {\endlist}
  {\item}
% Increase spacing between items a bit
\setlength{\bibparsep}{0.5ex}

% Don't print the year in the actual citation, just as the label
% (see the new bibenvironment immediately above)
\renewbibmacro*{date+extrayear}{}  
  
  % ------------------------------------------------------------------------------------------------
  % New sorting scheme for CV
  % ------------------------------------------------------------------------------------------------
  % Based on ynt sorting scheme of biblatex
  % Except:
  %  (i) don't sort on n(ame)
  %  (ii) ignore presort
  %  (iii) and do the following:
  %          sort by year, desecnding (yd);
  %          then by month, desecnding (md);
  %          then by day, descending (Dd);
  %          then by title (t)
  %
  % See also http://tex.stackexchange.com/a/46879/32888
  %
  \DeclareSortingScheme{ydmdDdt}{
    %\sort{
    %  \field{presort}
    %}
    %\sort[final]{
    %  \field{sortkey}
    %}
    \sort[direction=descending]{
      \field{sortyear}
      \field{year}
      \literal{9999}
    }
    \sort[direction=descending]{
      \field[padside=left,padwidth=2,padchar=0]{month}
      \literal{00}
    }
    \sort[direction=descending]{
      \field[padside=left,padwidth=2,padchar=0]{day}
      \literal{00}
    }
    \sort{
      \field{sorttitle}
      \field{title}}}
  % ------------------------------------------------------------------------------------------------
  % Always bold my name in the citation; see http://tex.stackexchange.com/a/73246/32888
  % ------------------------------------------------------------------------------------------------
  \RequirePackage{xpatch}

  \newbibmacro*{name:bold}[2]{%
    \def\do##1{\ifstrequal{#1, #2}{##1}{\bfseries\listbreak}{}}%
    \dolistloop{\boldnames}}

  \newcommand*{\boldnames}{}

  \xpretobibmacro{name:last}{\begingroup\usebibmacro{name:bold}{#1}{#2}}{}{}
  \xpretobibmacro{name:first-last}{\begingroup\usebibmacro{name:bold}{#1}{#2}}{}{}
  \xpretobibmacro{name:last-first}{\begingroup\usebibmacro{name:bold}{#1}{#2}}{}{}
  \xpretobibmacro{name:delim}{\begingroup\normalfont}{}{}

  \xapptobibmacro{name:last}{\endgroup}{}{}
  \xapptobibmacro{name:first-last}{\endgroup}{}{}
  \xapptobibmacro{name:last-first}{\endgroup}{}{}
  \xapptobibmacro{name:delim}{\endgroup}{}{}
	
  \forcsvlist{\listadd\boldnames}
    {%
      {Liter, Adam},{Liter, A.},{Liter, Adam R.},{Liter, Adam Robert}%
    }
  % ------------------------------------------------------------------------------------------------
  % New driver for @misc
  % ------------------------------------------------------------------------------------------------
  \DeclareFieldFormat[misc]{title}{\mkbibquote{#1}}
  \DeclareFieldFormat[misc]{titlecase}{\MakeSentenceCase*{#1}}
  \DeclareBibliographyDriver{misc}{%
    \usebibmacro{bibindex}%
    \usebibmacro{begentry}%
    \usebibmacro{author/translator+others}%
    \setunit{\labelnamepunct}\newblock
    \usebibmacro{title}%
    \newunit
    \printlist{language}%
    \newunit\newblock
    \usebibmacro{byauthor}%
    \newunit\newblock
    \usebibmacro{byeditor+others}%
    \newunit\newblock
    \printfield{eventtitle}%              conference
    \setunit{\addspace}%
    \printfield[parens]{eventtitleaddon}% conference acronym, if it exists
    \setunit{\addcomma\addspace}%
    \printfield{venue}%                   university and/or location of conference
    \newunit\newblock
    \usebibmacro{finentry}}

% ------------------------------------------------------------------------------------------------
% HYPERREF
% ------------------------------------------------------------------------------------------------

\RequirePackage{hyperref}
\hypersetup{
  unicode,
  pdftitle={\mytitle},
  pdfauthor={\myauthor},
  pdfkeywords={\mykeywords},
  pdfborder={0 0 0},
}

% ------------------------------------------------------------------------------------------------
% MACROS
% ------------------------------------------------------------------------------------------------

\RequirePackage{calc}
\RequirePackage{xcolor}

\newcommand*{\Colorhref}[2]{\href{#1}{\color{cyan}#2}}
\newcommand*{\PrintAddress}{\parbox[c]{\widthof{\faInbox}}{\resizebox{\widthof{\faInbox}}{!}{{\EmojiFont\char"1F40C}\faEnvelopeO}}\,\myaddress}
\newcommand*{\PrintPhone}{\faPhone\,\href{tel:\myphone}{\myphone}}
\newcommand*{\PrintEmail}{\faInbox\,\href{mailto:\myemail}{\myemail}}
\newcommand*{\PrintWebsite}{\faHome\,\href{\mywebsiteurl}{\mywebsite}}
\newcommand*{\PrintGitHub}{\faGithubSquare\,\href{https://github.com/\mygithub}{\mygithub}}

\endinput
% end mycv.cls