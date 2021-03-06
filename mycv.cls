% mycv.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mycv}[2015/12/29 A personal class for my cv. Requires biblatex and biber.]

\LoadClassWithOptions{article}

\RequirePackage{iftex}
\RequireLuaTeX

% ------------------------------------------------------------------------------------------------
% OPTIONS
% ------------------------------------------------------------------------------------------------

\RequirePackage{kvoptions}

% Metadata options
\DeclareStringOption[{Adam Liter}]{name}
\DeclareStringOption[{adamlitercv}]{title}
\DeclareStringOption[{io@adamliter.org}]{email}
\DeclareStringOption[{+1-952-807-5616}]{phone}
\DeclareStringOption[{adamliter.org}]{website}
\DeclareStringOption[{http://adamliter.org}]{websiteurl}
\DeclareStringOption[{Department of Linguistics\\1401 Marie Mount Hall\\7814 Regents Dr\\College Park, MD 20742-7505}]{address}
\DeclareStringOption[{adamliter}]{github}
\DeclareStringOption[{Adam Liter, cv, adamlitercv, vita, curriculum vitae, linguistics}]{keywords}

% Font options
\DeclareStringOption[{AGaramondPro}]{mainfont}
\DeclareStringOption[{Inconsolata}]{monofont}
\DeclareStringOption[{Italianno}]{titlefont}
\DeclareStringOption[{Raleway}]{headerfont}
\DeclareStringOption[{OpenSansEmoji}]{emojifont}
\DeclareStringOption[{Raleway Thin}]{biblatexlabelfont}

% Education display options
\DeclareBoolOption[false]{highschool}
\DeclareBoolOption[true]{undergrad}
\DeclareBoolOption[true]{lsa}
\DeclareBoolOption[true]{graduate}

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

\newcommand*{\edudisplay}{
  \ifmycv@graduate%
  graduate,%
  \else%
  \fi%
  \ifmycv@lsa%
  lsa,%
  \else%
  \fi%
  \ifmycv@undergrad%
  undergrad,%
  \else%
  \fi%
  \ifmycv@highschool%
  highschool%
  \else%
  \fi%
}

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
    UprightFont = *-Regular,
    BoldFont = *-Semibold,
    ItalicFont = *-Italic,
    BoldItalicFont = *-SemiboldItalic
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

\newfontfamily\BiblatexLabelFont{\mycv@biblatexlabelfont}

\RequirePackage{fontawesome}

\newfontfamily\BulletFont[Scale=.8]{Linux Libertine O}

% ------------------------------------------------------------------------------------------------
% DOCUMENT STUFF
% ------------------------------------------------------------------------------------------------

\RequirePackage{amsmath}
\RequirePackage{varwidth}

\def\@maketitle{%
  \begin{center}
    {\Huge\TitleFont\myauthor}%
    \,%
    $\left\{\begin{tabular}{@{}c@{\hspace{0.75ex}}l@{}}%
      \resizebox{0.85em}{!}{\EmojiFont\char"1F40C}\resizebox{0.85em}{!}{\faEnvelopeO} & \begin{varwidth}{0.4\textwidth}\myaddress\end{varwidth}\\[2em]
      %\faPhone & \myphone\\[0.2em]
      \faInbox & \href{mailto:\myemail}{\myemail}\\[0.2em]
      \faHome & \href{\mywebsiteurl}{\mywebsite}\\[0.2em]
      \faGithub & \href{https://github.com/\mygithub}{\mygithub}\\[0.2em]
    \end{tabular}\right.$%
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

\setcounter{secnumdepth}{0}

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

\RequirePackage{graphicx}

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
    issueandeditor=true,
    maxbibnames=99,
    defernumbers=true,% for the new bibenvironment
    sorting=ydmdDdt
  ]
  {biblatex}

% New bibliography environment with years in the margins
\newcommand*{\InPress}{in press}

\DeclareFieldFormat{mycv-label}{\BiblatexLabelFont#1}
\defbibenvironment{bibliography}
  {\list
     % only use "in press" as a label
     % NB: \iffieldequals only takes macros as arguments
     {\iffieldequals{pubstate}{\InPress}
        {\iffieldequals{pubstate}{\bibpubstate}
           {}
           {\printfield[mycv-label]{pubstate}%
            \savefield{pubstate}{\bibpubstate}}}
        % Otherwise print year (unless it matches
        % the previous item's year)
        {\iffieldequals{year}{\bibyear}
           {}
           {\printfield[mycv-label]{year}%
            \savefield{year}{\bibyear}}}}
     {\settowidth\labelwidth{forthcomingxxx}%
      \setlength{\leftmargin}{\bibhang}%
      \setlength{\itemindent}{-\leftmargin}%
      \setlength{\itemsep}{\bibitemsep}%
      \setlength{\parsep}{\bibparsep}}}
  {\endlist}
  {\item}
% Increase spacing between items a bit
\setlength{\bibparsep}{0.5ex}

% Don't print the year in the actual citation, just as the label
% (see the new bibenvironment immediately above)
\renewbibmacro*{date+extradate}{}
% Only print the pubstate if it doesn't equal "in press"
\renewbibmacro*{addendum+pubstate}{
  \iffieldequals{pubstate}{\InPress}
  {}
  {\printfield{pubstate}}}

 \DeclareFieldFormat{doi}{%
   \textsc{doi}:
   \ifhyperref
     {\Colorhref{https://doi.org/#1}{\nolinkurl{#1}}}
     {\nolinkurl{#1}}}

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
  \DeclareSortingTemplate{ydmdDdt}{
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

  \xpretobibmacro{name:family}{\begingroup\iffieldequalstr{hash}{0d367c6df2345224416120c3f5e5b5a4}{\bfseries}{}}{}{}
  \xpretobibmacro{name:given-family}{\begingroup\iffieldequalstr{hash}{0d367c6df2345224416120c3f5e5b5a4}{\bfseries}{}}{}{}
  \xpretobibmacro{name:family-given}{\begingroup\iffieldequalstr{hash}{0d367c6df2345224416120c3f5e5b5a4}{\bfseries}{}}{}{}
  \xpretobibmacro{name:delim}{\begingroup\normalfont}{}{}

  \xapptobibmacro{name:family}{\endgroup}{}{}
  \xapptobibmacro{name:given-family}{\endgroup}{}{}
  \xapptobibmacro{name:family-given}{\endgroup}{}{}
  \xapptobibmacro{name:delim}{\endgroup}{}{}

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

\RequirePackage{xcolor}

\newcommand*{\Colorhref}[2]{\href{#1}{\color{cyan}#2}}

\endinput
% end mycv.cls
