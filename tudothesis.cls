\ProvidesClass{tudothesis}[2023/07/18 v0.10 wrapper to scrbook for thesis at TUDo]

% Setup color= to work 
% Use Keyval to be able to give key-value options
\RequirePackage{kvoptions}
% use tugreen as default if key is given as a switch,
% otherwise leave tugreen empty
\DeclareStringOption{color}[tugreen]
\ProcessKeyvalOptions*

% All other Options go to KOMA-Script
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\PassOptionsToPackage{bibliography=totoc}{biblatex}
\ProcessOptions\relax

\LoadClass[
  headsepline,            % line  between header and text body
  bibliography=totoc,     % bibliography as unnumbered chapter in toc
  numbers=noenddot,       % no dot after figure/table number
  captions=tableheading,  % correct spacing for table headings
  titlepage=firstiscover, % symmetrical margins on titlepage
  headings=normal         % size of chapter headings slightly smaller
]{scrbook}


% Define our beloved tu colour:
% orange one is an accent
\RequirePackage{xcolor}
% tu colors
\definecolor{tugreen}{HTML}{83b818}
\definecolor{tuorange}{HTML}{d98207}

\RequirePackage{caption}
\RequirePackage{subcaption}

% add some Color to structural elements if option tucolor was given
\RequirePackage{scrlayer-scrpage}
\pagestyle{scrheadings}

\KOMAoption{headsepline}{0.5pt}
\ifx\tudothesis@color\@empty
  \captionsetup{%
              labelfont=bf,               % bold label
              format=plain,               % no indentation under the label
              width=0.9\textwidth,        % slightly smaller width than text
              font=small,                 % font slightly smaller than text
            }
\else
  \addtokomafont{title}{\color{\tudothesis@color}}       % title on titlepage
  \addtokomafont{chapter}{\color{\tudothesis@color}}     % headlines of the chapters, sections etc. 
  \setkomafont{headsepline}{\color{\tudothesis@color}}   % line between header and text body
  \DeclareCaptionFont{\tudothesis@color}{\color{\tudothesis@color}}
  \captionsetup{%
              labelfont={bf,tugreen},     % bold label in tu colour
              format=plain,               % no indentation under the label
              width=0.9\textwidth,        % slightly smaller width than text
              font=small,                 % font slightly smaller than text
            }
\fi

% equation numbers of form chapter.equationnumber
\RequirePackage{amsmath}%
\renewcommand{\theequation}{\thechapter{}.\arabic{equation}}%
\numberwithin{equation}{chapter}%

% store the title in \thetitle, so one can access it in the document
\let\oldtitle\title%
\renewcommand{\title}[1]{\oldtitle{#1}\newcommand{\thetitle}{#1}}

% initialize commands:
\newcommand\thebirthplace{}
\newcommand\thechair{}
\newcommand\thedivision{}
\newcommand\thethesisclass{}
\newcommand\thesubmissiondate{}
\newcommand\thefirstcorrector{}
\newcommand\thesecondcorrector{}

% new commands for information about the thesis
\newcommand\birthplace[1]{\renewcommand\thebirthplace{geboren in #1}}
\newcommand\chair[1]{\renewcommand\thechair{#1}}
\newcommand\division[1]{\renewcommand\thedivision{#1}}
\newcommand\thesisclass[1]{\renewcommand\thethesisclass{#1}}
\newcommand\submissiondate[1]{\renewcommand\thesubmissiondate{#1}}
\newcommand\firstcorrector[1]{\renewcommand\thefirstcorrector{#1}}
\newcommand\secondcorrector[1]{\renewcommand\thesecondcorrector{#1}}

% set title page elements
\subject{Arbeit zur Erlangung des akademischen Grades\\ \thethesisclass}
\publishers{\thechair \\ \thedivision \\ Technische Universität Dortmund}

% page for the correctors
\newcommand{\makecorrectorpage}{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{tabular}{@{}l@{\hspace{2em}}l@{}}
      Erstgutachter:  & \thefirstcorrector \\
      Zweitgutachter: & \thesecondcorrector \\
      Abgabedatum:    & \thesubmissiondate
  \end{tabular}
  \newpage
}

% add birthplace to author
\let\oldauthor\author
\renewcommand\author[1]{%
  \oldauthor{#1 \\ \thebirthplace}
}
