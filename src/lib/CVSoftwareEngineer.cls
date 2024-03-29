% !TEX TS-program = xelatex
% !TEX encoding = UTF-8 Unicode

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CVSoftwareEngineer}[2020/06/07 Software Engineering CV Latex Class]

% -----------------------------------------------------------------------------
% Main package and configuration
% ------------------------------------------------1-----------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt]{article}

% -----------------------------------------------------------------------------
% Debugging packages
% -----------------------------------------------------------------------------
%\RequirePackage{showframe}

% -----------------------------------------------------------------------------
% Required packages
% -----------------------------------------------------------------------------
\RequirePackage[utf8]{inputenc}

% Required for modifying sections, the nobottomtitles* is required for pushing
% section titles to the next page when they are close to the bottom of the page.
% http://www.ctex.org/documents/packages/layout/titlesec.pdf
\RequirePackage[nobottomtitles*]{titlesec}

% Set a4paper width minimal options.
\RequirePackage[a4paper]{geometry}

% Tables
% https://www.uakron.edu/dotAsset/0804dc93-7a58-4692-ad50-4fc95db2151f.pdf

% Required for creating multi-column layouts that can span pages automatically.
% https://download.nus.edu.sg/mirror/ctan/macros/latex/contrib/paracol/paracol-man.pdf
\RequirePackage{paracol}

% Required for conditional statements
% http://mirrors.ibiblio.org/CTAN/macros/latex/contrib/etoolbox/etoolbox.pdf
\RequirePackage{etoolbox}

\RequirePackage{calc}

% Allows the definition and use of custom colours
% https://download.nus.edu.sg/mirror/ctan/macros/latex/contrib/xcolor/xcolor.pdf
\RequirePackage{xcolor}

% Required for links
\RequirePackage{hyperref}
\hypersetup{colorlinks, breaklinks, urlcolor=linkcolor, linkcolor=linkcolor}

% Required for customising headers and footers
\RequirePackage{fancyhdr}

\RequirePackage{ifthen}

\RequirePackage{varwidth}

% Some helpful manuals
% https://sites.clas.ufl.edu/gradmath/files/tikz.pdf
\RequirePackage{tikz}

% https://download.nus.edu.sg/mirror/ctan/graphics/pgf/contrib/pgfplots/doc/pgfplots.pdf
\RequirePackage{pgfplots}

% https://download.nus.edu.sg/mirror/ctan/graphics/pgf/contrib/pgf-pie/pgf-pie-manual.pdf
\RequirePackage{pgf-pie}

% https://download.nus.edu.sg/mirror/ctan/macros/latex/contrib/etoolbox/etoolbox.pdf
\RequirePackage{etoolbox}

% https://download.nus.edu.sg/mirror/ctan/fonts/fontawesome/doc/fontawesome.pdf
% \RequirePackage{fontawesome}
% https://ctan.org/pkg/fontawesome5
\RequirePackage{fontawesome5}

% Provides the justify command.
\RequirePackage{ragged2e}

% Compact itemize
% https://download.nus.edu.sg/mirror/ctan/macros/latex/required/tools/enumerate.pdf
% https://download.nus.edu.sg/mirror/ctan/macros/latex/contrib/enumitem/enumitem.pdf
\RequirePackage{enumitem}

% https://download.nus.edu.sg/mirror/ctan/info/symbols/comprehensive/symbols-a4.pdf
\usepackage{enumitem}

% https://tex.stackexchange.com/questions/167948/package-rerunfilecheck-warning-file-out-has-changed
\usepackage{bookmark}


% -----------------------------------------------------------------------------
% Configurations
% -----------------------------------------------------------------------------
% Enable custom headers and footers
\pagestyle{fancy}

% This suppresses all headers and footers by default, add headers and footers
% in the template file as per the example.
\fancyhf{}

% Paracol column ratio.
\columnratio{0.40, 0.45}

% Remove the default rule under the header
\renewcommand{\headrulewidth}{0pt}

% Disable paragraph indentation.
\setlength{\parindent}{0pt}

% Define the \section format
% \titleformat{〈command〉}[〈shape〉]{〈format〉}{〈label〉}{〈sep〉}{〈before〉}[〈after〉]
\titleformat{\section}
	{\color{black}\LARGE\raggedright\center\uppercase}
	{}
	{0em}
	{}
	[\titlerule]

% Spacing around section titles, the order is: left, before and after
\titlespacing{\section}{0pt}{0pt}{4pt}


% -----------------------------------------------------------------------------
% Colors
% -----------------------------------------------------------------------------
% See http://latexcolor.com/

\definecolor{black}{HTML}{000000}

% 25% desaturated headings colour for links
%\definecolor{linkcolor}{HTML}{641c1d}
\definecolor{linkcolor}{HTML}{000000}

% The color of the large sections
\definecolor{headings}{HTML}{6A6A6A}

\definecolor{cvGreen}{HTML}{357F2D}
\definecolor{mainblue}{HTML}{002E63}

% Gray (X11 gray) #BEBEBE \definecolor{gray(x11gray)}{rgb}{0.75, 0.75, 0.75}
\definecolor{cvBar}{HTML}{BEBEBE}
\definecolor{cvPie}{HTML}{BEBEBE}

% Lavender gray #C4C3D0 \definecolor{lavendergray}{rgb}{0.77, 0.76, 0.82}
\definecolor{lavendergray}{HTML}{C4C3D0}

% Liver #534B4F \definecolor{liver}{rgb}{0.33, 0.29, 0.31}
\definecolor{liver}{HTML}{534B4F}

% Taupe gray #8B8589 \definecolor{taupegray}{rgb}{0.55, 0.52, 0.54}
\definecolor{taupegray}{HTML}{8B8589}

% Trolley Grey #808080 \definecolor{trolleygrey}{rgb}{0.5, 0.5, 0.5}
\definecolor{trolleygrey}{HTML}{808080}

% -----------------------------------------------------------------------------
% tikz definition
% -----------------------------------------------------------------------------
% Some helpful manuals
% https://sites.clas.ufl.edu/gradmath/files/tikz.pdf
%
% calc        : allows to use complex node combinations (e.g. fractions of node
%               coordinates).
% positioning : library allows convenient relative positioning of nodes
%               (e.g. right=1cm of title).
% background  : allows us to use the predefined nodes such as current page to
%               provide absolute positioning on the page. This is very useful
%               to draw the sidebar background.
% matrix      : enables to conveniently place regular table-like node combinations
%               without needed to code all relative distances separately.
%
\usetikzlibrary{calc, positioning, backgrounds, matrix, shapes, arrows.meta, decorations, decorations.text, decorations.pathreplacing}

\tikzset{
	contactIcon/.style={
		minimum height=\baselineskip,
	},
	contactText/.style={
		minimum height=\baselineskip,
		text depth=0pt,
		text width=\cvSideWidth,
	},
	languageText/.style={},
	languageTextComment/.style={
		languageText,
		font=\scriptsize,
	},
	languageProgressArea/.style={
		minimum width=\cvLanguageBarWidth,
		minimum height=\cvLanguageBarHeight,
		rectangle,
		rounded corners=0ex,
		draw,
		cvBar,
	},
	languageProgressBar/.style={
		minimum height=\cvLanguageBarHeight,
		rectangle,
		rounded corners=0ex,
		draw,
		fill,
		cvBar,
		anchor=west,
	},
	skillText/.style={},
	skillTextComment/.style={
		skillText,
		anchor=west,
	},
	skillProgressArea/.style={
		minimum width=\cvSkillBarWidth,
		minimum height=\cvSkillBarHeight,
		rectangle,
		rounded corners=0ex,
		line width=0pt,
		inner xsep=10pt,
		inner ysep=0pt,
	},
	skillProgressBar/.style={
		minimum height=\cvSkillBarHeight,
		rectangle,
		rounded corners=0ex,
		draw,
		cvBar,
		anchor=west,
		line width=0pt,
		inner xsep=10pt,
		inner ysep=0pt,
	},
	headerIcon/.style={
		minimum width=\headericonwidth,
		minimum width=\cvHeaderIconWidth,
		anchor=center
	},
	sectionTitle/.style={
		anchor=north west,
		align=left,
	},
	timelinePreface/.style = {
		text width=\cvMainWidth,
		black,
		anchor=west,
		align=justify,
	},
	eventDotText/.style = {
		text width=\cvEventTextWidth,
		black,
		anchor=north west,
		align=justify,
	},
	invisibleTimeDot/.style = {
		circle,
		minimum width=3pt,
		scale=0.2,
		anchor=center,
	},
	timeDot/.style = {
		invisibleTimeDot,
		draw,
		fill,
		black,
	},
	timeDotInner/.style = {
		invisibleTimeDot,
		minimum width=3pt,
		scale=0.2,
		draw,
		fill,
		black,
	},
	eventGroupedLine/.style = {
		dotted,
		blue,
		decorate,
		decoration = {
			brace,
			amplitude = 10pt,
			mirror
		},
		yshift = 0pt,
		xshift = 0pt,
	},
	eventGroupedSideText/.style = {
		black,
		midway,
		xshift = 1cm,
		yshift = 0.75cm,
		font = \scriptsize,
		text depth = 0pt,
		text width = 1.2cm,
	},
	personalDetailsBox/.style = {
		black,
		draw,
		very thick,
		rectangle,
		rounded corners,
		inner xsep=10pt,
		inner ysep=0pt,
	},
}


% -----------------------------------------------------------------------------
% Margins
% -----------------------------------------------------------------------------
% Define length.
\newlength\margin
\setlength\margin{1cm}

\geometry{
	margin=\margin,
	noheadfoot
}

% Specify the amount of space between the columns
\setlength\columnsep{0.05\textwidth}

% Define more lengths.
\newlength\cvNodeSep
\setlength\cvNodeSep{0.75cm}
\newlength\cvtimeDotDiameter
\setlength\cvtimeDotDiameter{3pt}
\newlength\cvMargin
\setlength\cvMargin{1cm}
\newlength\cvSideWidth
\setlength\cvSideWidth{0.40\paperwidth-\cvMargin}
\newlength\cvMainWidth
\setlength\cvMainWidth{\paperwidth-4\cvMargin-\cvSideWidth}
\newlength\cvEventTextWidth
\setlength\cvEventTextWidth{\cvMainWidth}

\newlength\cvSideWidthText
\setlength\cvSideWidthText{\cvSideWidth}

\newlength\cvLanguageBarWidth
\setlength\cvLanguageBarWidth{5em}
\newlength\cvLanguageBarHeight
\setlength\cvLanguageBarHeight{0.75em}

\newlength\cvSkillBarWidth
\setlength\cvSkillBarWidth{3cm}
\newlength\cvSkillBarHeight
\setlength\cvSkillBarHeight{0.01cm}

% This length will define the spacing between the icon that each section will
% have and the title of that section. Additionally, this will also be the
% spacing between the timeline and the events on that timeline, hence the name.
% Let’s set this length to 0.4 cm for now:
\newlength\cvTimeDotSepMain
\setlength\cvTimeDotSepMain{0.3cm}
\newlength\cvTimeDotSepSecondary
\setlength\cvTimeDotSepSecondary{0cm}

\newlength{\cvSectionSep}
\setlength{\cvSectionSep}{0.30cm}


% -----------------------------------------------------------------------------
% Helper functions
% -----------------------------------------------------------------------------

\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% #1: Name of position
% #2: Name of the company
% #3: Location
% #4: Date period
% #5: Text
\newcommand{\cvExperience}[5]{{#1 \hfill \scriptsize#4}\\ {\scriptsize {\textit{#2}} -- #3.} #5}

% #1: Name of project
% #2: github link
% #3: Text
\newcommand{\cvProject}[3]{{\centerline{#1 \scriptsize -- #2}} #3}
