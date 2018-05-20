% vim:ft=tex:ts=2:sw=2
%
% Peking University dissertation document class
%
% Copyright (c) 2008-2009 solvethis
% Copyright (c) 2010-2011 Casper Ti. Vector
%
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or (at
% your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The current maintainer of this work is Casper Ti. Vector.
%
% This work consists of the following files:
%   pkuthss.cls
%   pkuthss-gbk.def
%   pkuthss-utf8.def
%   pkuthss-extra.sty

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{pkuthss}
	[2011/04/08 v1.3 beta1 Peking University dissertation document class]

% ��������ѡ�
\newif\ifpkuthss@opt@gbk \pkuthss@opt@gbktrue
\DeclareOption{GBK}{\pkuthss@opt@gbktrue\PassOptionsToClass{GBK}{ctexbook}}
\DeclareOption{UTF8}%
	{\pkuthss@opt@gbkfalse\PassOptionsToClass{UTF8}{ctexbook}}
% �Ƿ����Ĭ�ϵĶ������á�
\newif\ifpkuthss@opt@extra \pkuthss@opt@extratrue
\DeclareOption{extra}{\pkuthss@opt@extratrue}
\DeclareOption{noextra}{\pkuthss@opt@extrafalse}
% ��������ĵ������ȫ�����ݸ� ctexbook �ĵ��ࡣ
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% ���̴������к��ѡ�
\ProcessOptions\relax

% ���ĵ����� ctexbook Ϊ�������趨ҳ��ߴ�Ϊ A4��Ĭ���ֺ�ΪС�ĺš�
% CJKfntef ����ṩ�� \maketitle ���õ��� \CJKunderline ���
% fancyhdr ����ṩ�˷���ʹ�õ�������������ҳü��ҳ�š�
\LoadClass[fntef,a4paper,fancyhdr,cs4size]{ctexbook}[2009/10/20]
% �˺���ṩ�� key=val ��ʽ���õ�֧�֡�
\RequirePackage{keyval}
% �˺���ṩͼ��֧�֡�
\RequirePackage{graphicx}[1999/02/16]
% �˺���ṩ�˷���ʹ�õ�������������ҳ�沼�֡�
\RequirePackage{geometry}
% �Ƿ����Ĭ�ϵĶ������á�
\ifpkuthss@opt@extra\RequirePackage{pkuthss-extra}\fi

\ifxetex\ifpkuthss@opt@gbk
	% ��֧�ַ��� XeLaTeX ����� UTF-8 ���ĵ���
	\ClassError{pkuthss}%
		{XeLaTeX compilation is not supported without UTF-8}%
		{%
			XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
			Therefore please use UTF-8 encoding for the LaTeX code.%
		}
\fi\fi

\AtEndOfClass{%
	% �趨������������ݡ�
	\ifpkuthss@opt@gbk\input{pkuthss-gbk.def}
	\else\input{pkuthss-utf8.def}
	\fi

	% Ϊ�����е�Ŀ¼��������������Զ��������ӣ����Զ�������ǩ��
	% ���븴���� ctex ����� ctex-common.def���иĶ���
	% ��ֱ��ʹ�� ctex ����� hyperref ѡ���ԭ���Ǳ���� setspace �ĳ�ͻ��
	% XXX: ʵ�ַ�ʽ�������ţ������и��Ӻ��ʵĴ�����ʽ��
	\ifxetex
		\RequirePackage{hyperref}
	\else
		\ifpdf
			\RequirePackage[pdftex]{hyperref}
		\else
			\ifCTEX@GBK
				\AtBeginDvi{\special{pdf:tounicode GBK-EUC-UCS2}}
			\fi
			\RequirePackage[dvipdfmx]{hyperref}
		\fi
		\ifCTEX@GBK
			\hypersetup{CJKbookmarks=true}
		\else
			\hypersetup{unicode=true}
		\fi
	\fi
}

% �趨ҳ�沼�֡�
\geometry{height=240mm,width=150mm,includeheadfoot,headheight=1.2em}
% �趨ҳü��ҳ����ʽ��
\pagestyle{fancy}\fancyhf{}
\fancyhead[LE]{\small\normalfont\leftmark}
\fancyhead[RO]{\small\normalfont\rightmark}
\fancyhead[LO,RE]{\small\normalfont\cuniversity\cthesisname}
\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
% �趨ÿ����һ�����ֵĵ�һҳ��ҳü��ҳ����ʽ��
\fancypagestyle{plain}{
	\fancyhf{}\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[RO,LE]{\small\normalfont --~\thepage~--}
}

% ���磺
% \pkuthss@int@infoitema{ctitle} ���ձ���չΪ��
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{pkuthss@info}{ctitle}{\ctitle{#1}}
\def\pkuthss@int@infoitema#1{
	\expandafter\def\csname #1\endcsname##1%
		{\expandafter\def\csname @#1\endcsname{##1}}
	\expandafter\define@key{pkuthss@info}{#1}{\csname #1\endcsname{##1}}
}
% ���磺
% \pkuthss@int@infoitemb{cuniversity} ���ձ���չΪ��
%   \define@key{pkuthss@info}{cuniversity}{\def\cuniversity{#1}}
\def\pkuthss@int@infoitemb#1{
	\expandafter\define@key{pkuthss@info}{#1}%
		{\expandafter\def\csname #1\endcsname{##1}}
}
% �趨�����ĵ���Ϣ�ľ������ݡ�
\pkuthss@int@infoitema{ctitle}
\pkuthss@int@infoitema{etitle}
\pkuthss@int@infoitema{cauthor}
\pkuthss@int@infoitema{eauthor}
\pkuthss@int@infoitema{studentid}
\pkuthss@int@infoitema{date}
\pkuthss@int@infoitema{school}
\pkuthss@int@infoitema{cmajor}
\pkuthss@int@infoitema{emajor}
\pkuthss@int@infoitema{direction}
\pkuthss@int@infoitema{cmentor}
\pkuthss@int@infoitema{ementor}
\pkuthss@int@infoitema{ckeywords}
\pkuthss@int@infoitema{ekeywords}
\pkuthss@int@infoitemb{cuniversity}
\pkuthss@int@infoitemb{euniversity}
\pkuthss@int@infoitemb{cthesisname}
\pkuthss@int@infoitemb{ethesisname}
\pkuthss@int@infoitemb{cabstractname}
\pkuthss@int@infoitemb{eabstractname}
% ������������ key=val ��ʽ�����ĵ���Ϣ��
\newcommand{\pkuthssinfo}[1]{\setkeys{pkuthss@info}{#1}}

% �趨�����ʽ���������ɷ���ʱ�趨�ĵ���Ϣ��
\renewcommand{\maketitle}{
	\cleardoublepage
	\pdfbookmark[1]{\titlepagename}{titlepage}
	\begin{titlepage}
		% ����ʹ������о��Ϊ���ۡ�
		\linespread{1.6}\selectfont
		% ���������»������ָ���Ŀռ䡣
		\def\pkuthss@int@fillinblank##1##2%
			{\CJKunderline{\makebox[##1]{##2}}}
		% ���С�
		\begin{center}
			% ��һ���֣�У�ա���������ѧ���������������
			{
				\includegraphics[height=0.07\textheight]{img/pkulogo}\hspace{1em}
				\includegraphics[height=0.07\textheight]{img/pkuword}\\[2.25em]
				{\zihao{1}\bfseries\cthesisname}
			}
			\vfill
			% �ڶ����֣����ı��⡣
			{
				\zihao{2}
				{\label@ctitle}\makebox[0pt][l]{
					\parbox[t]{12em}{\centering\textbf{\@ctitle}}
				}
				\parbox[t]{12em}{
					\pkuthss@int@fillinblank{12em}{}\\
					\pkuthss@int@fillinblank{12em}{}
				}
			}
			\vfill
			% �������֣�������Ϣ��
			{
				% �ֺ��иı䣬�о��趨������������
				\zihao{-2}\linespread{1.75}\selectfont
				\begin{tabular}{l@{\extracolsep{0.2em}}c}
					{\label@cauthor}		&
					\pkuthss@int@fillinblank{12em}{\kaishu\@cauthor}		\\
					{\label@studentid}	&
					\pkuthss@int@fillinblank{12em}{\kaishu\@studentid}	\\
					{\label@school}			&
					\pkuthss@int@fillinblank{12em}{\kaishu\@school}			\\
					{\label@cmajor}			&
					\pkuthss@int@fillinblank{12em}{\kaishu\@cmajor}			\\
					{\label@direction}	&
					\pkuthss@int@fillinblank{12em}{\kaishu\@direction}	\\
					{\label@cmentor}		&
					\pkuthss@int@fillinblank{12em}{\kaishu\@cmentor}		\\
				\end{tabular}
			}
			\vfill
			% ���Ĳ��֣����ڡ�
			{\kaishu\zihao{2}\@date}
		\end{center}
	\end{titlepage}
}

% �����Ű�ժҪ���ڲ�������
\newenvironment{pkuthss@int@abstract}{
	\cleardoublepage
	\pdfbookmark[1]{\tmp@abstractname}{\tmp@abstlabel}
	\chapter*{\zihao{-2}\tmp@title}
	\markboth{\tmp@abstractname}{}
	\vspace{-2em}\par
	\begin{center}
 		\zihao{-3}
 		{\tmp@author}\quad{\tmp@major}\\
 		{\tmp@label@mentor}{\tmp@mentor}
	\end{center}
	\vspace{1em}\par
	\section*{\zihao{4}\tmp@abstractname}
	\vskip 0.5em
}{% ��ҳ��ײ��Ű�ؼ��ʡ�
	\vfill\noindent\textbf{\tmp@label@keywords}{\tmp@keywords}
}

% �˻��������Ű�����ժҪ��
\newenvironment{cabstract}{
	\def\tmp@abstlabel{cabstract}
	\let\tmp@title\@ctitle
 	\let\tmp@author\@cauthor
	\let\tmp@major\@cmajor
 	\let\tmp@mentor\@cmentor
 	\let\tmp@keywords\@ckeywords
 	\let\tmp@label@mentor\label@cmentor
 	\let\tmp@label@keywords\label@ckeywords
	\let\tmp@abstractname\cabstractname
	\begin{pkuthss@int@abstract}
}{\end{pkuthss@int@abstract}}

% �˻��������Ű�Ӣ��ժҪ��
\newenvironment{eabstract}{
	\def\tmp@abstlabel{eabstract}
	\let\tmp@title\@etitle
 	\let\tmp@author\@eauthor
	\let\tmp@major\@emajor
 	\let\tmp@mentor\@ementor
 	\let\tmp@keywords\@ekeywords
 	\let\tmp@label@mentor\label@ementor
 	\let\tmp@label@keywords\label@ekeywords
	\let\tmp@abstractname\eabstractname
	\begin{pkuthss@int@abstract}
}{\end{pkuthss@int@abstract}}

\endinput