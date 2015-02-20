\ProvidesClass{tudothesis}[2015/02/20 v0.5 wrapper to scrbook for thesis at TUDo]
\LoadClass[
  headsepline,            % line  between header and text body
  cleardoublepage=plain,  % no header/footer on empty pages
  bibliography=totoc,     % bibliography as unnumbered chapter in toc
  numbers=noenddot,       % no dot after figure/table number
  captions=tableheading,  % correct spacing for table headings
  titlepage=firstiscover, % symmetrical margins on titlepage
  headings=normal         % size of chapter headings slightly smaller
]{scrbook}

% Option for tu colors:
\newif\if@tucolor\@tucolorfalse
\DeclareOption{tucolor}{\@tucolortrue}

% All other Options go to KOMA-Script
\DeclareOption*{\PassOptionsToClass{scrbook}{\CurrentOption}}
\ProcessOptions\relax

% Define our beloved tu colour:
\RequirePackage{xcolor}
\xdefinecolor{tugreen}{RGB}{128, 186, 38}

\RequirePackage{caption}
\RequirePackage{subcaption}

% add some Color to structural elements if option tucolor was given
\RequirePackage{scrlayer-scrpage}
\pagestyle{scrheadings}

\if@tucolor%
  \addtokomafont{title}{\color{tugreen}}          % Titel auf der Titelseite in TU-Grün
  \addtokomafont{sectioning}{\color{tugreen}}     % Kapitel-Überschriften in TU-Grün
  \addtokomafont{pagenumber}{\color{tugreen}}     % Seitenzahl in TU-Grün
  \addtokomafont{chapterentry}{\color{tugreen}}   % Inhaltsverziechnis
  \setheadsepline{0.75pt}[\color{tugreen}]        % Linie unter Kopzzeile in TU-Grün
  \DeclareCaptionFont{tugreen}{\color{tugreen}}
  \captionsetup{%
              labelfont={bf,tugreen},     % bold label in tu colour
              format=plain,               % no indentation under the label
              width=0.9\textwidth,        % slightly smaller width than text
              font=small,                 % font slightly smaller than text
            }
\else
  \captionsetup{%
              labelfont=bf,               % bold label
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

% new commands for information about the thesis
\newcommand\birthplace[1]{\newcommand\thebirthplace{geboren in #1}}
\newcommand\chair[1]{\newcommand\thechair{#1}}
\newcommand\division[1]{\newcommand\thedivision{#1}}
\newcommand\thesisclass[1]{\newcommand\thethesisclass{#1}}
\newcommand\submissiondate[1]{\newcommand\thesubmissiondate{#1}}
\newcommand\firstcorrector[1]{\newcommand\thefirstcorrector{#1}}
\newcommand\secondcorrector[1]{\newcommand\thesecondcorrector{#1}}

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

% check if all information is given:
\AtBeginDocument{%
  \@ifundefined{thebirthplace}{%
    \ClassError{tudothesis}{your birthplace is not set, use \protect\birthplace{} to set it}{}
  }{}%
  \@ifundefined{thefirstcorrector}{%
    \ClassError{tudothesis}{firstcorrector is not set, use \protect\firstcorrector{} to set it}{}
  }{}%
  \@ifundefined{thesecondcorrector}{%
    \ClassError{tudothesis}{secondcorrector is not set, use \protect\secondcorrector{} to set it}{}
  }{}%
  \@ifundefined{thesubmissiondate}{%
    \ClassError{tudothesis}{submissiondate is not set, use \protect\submissiondate{} to set it}{}
  }{}%
  \@ifundefined{thechair}{%
    \ClassError{tudothesis}{your chair is not set, use \protect\chair{} to set it}{}
  }{}%
  \@ifundefined{thedivision}{%
    \ClassError{tudothesis}{your division is not set, use \protect\division{} to set it}{}
  }{}%
}
