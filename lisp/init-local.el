;; ------------------------------
;; 按项目的方式管理文件和目录 projectile
;; 默认全局使用
(require 'projectile)
(projectile-global-mode)

;; ------------------------------
;; erlang折叠代码
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
(defun my-erlang-mode-hook ()
  (setq hs-special-modes-alist
        (cons '(erlang-mode
                "^\\([a-z][a-zA-Z0-9_]*\\|'[^\n']*[^\\]'\\)\\s *(" nil "%"
                erlang-end-of-clause) hs-special-modes-alist))
  (hs-minor-mode 1)
  (local-set-key [?\M-s] 'hs-toggle-hiding)
  (local-set-key [?\M-h] 'hs-hide-all)
  (local-set-key [?\M-u] 'hs-show-all))
;; ------------------------------
;; nitrogen-mode
(add-to-list 'load-path "/Users/homeway/erlang/research/nitrogen/support/nitrogen-mode")
(require 'nitrogen-mode)

;; ------------------------------
;; todo项定义
(setq org-todo-keywords
      '((sequence "TODO(t@)" "问题(r@)" "|" "完成(C/@)" "推迟(D@/!)" "取消(C@/!)" "解决(R@)")
        (sequence "阿鑫(q/@)" "小炳(h/@)" "王鹏(w/@)" "|")))

;; ------------------------------
;; 使用xelatex从org生成PDF的模板
(setq org-latex-pdf-process
'("xelatex -interaction nonstopmode %f"
"xelatex -interaction nonstopmode %f"))

;; code执行免应答（Eval code without confirm）
(setq org-confirm-babel-evaluate nil)
;; Auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(defun org-mode-article-modes ()
  (reftex-mode t)
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all)))
(add-hook 'org-mode-hook
          (lambda ()
            (if (member "REFTEX" org-todo-keywords-1)
                (org-mode-article-modes))))
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
;; 从org文件导出pdf的模板
;; 需要在org文件中增加 #+LATEX_CLASS: pdf
(require 'ox-latex)
(add-to-list 'org-latex-classes
             '("pdf"
               "\\documentclass[12pt,a4paper,titlepage]{article}
\\usepackage{graphicx}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\usepackage{lmodern}
\\usepackage{verbatim}
\\usepackage{fixltx2e}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{tikz}
\\usepackage{wrapfig}
\\usepackage{soul}
\\usepackage{textcomp}
\\usepackage{listings}
\\usepackage{geometry}
\\usepackage{algorithm}
\\usepackage{algorithmic}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{latexsym}
\\usepackage{natbib}
\\usepackage{fancyhdr}
\%%%% 设置正文字体
\\setCJKmainfont[Scale=0.9]{STSong}%中文字体
\\setCJKmonofont[Scale=0.9]{STSong}
\\usepackage{fontspec,xunicode,xltxtra}
\\setmainfont{Courier New}
\\setsansfont{Courier New}
\\setmonofont{Courier New}
\\newcommand\\fontnamemono{Courier New}%等宽字体
\\newfontinstance\\MONO{\\fontnamemono}
\\newcommand{\\mono}[1]{{\\MONO #1}}
\%%%% 目录格式
\\usepackage[xetex,colorlinks=true,CJKbookmarks=true,
\linkcolor=blue,urlcolor=blue,menucolor=blue]{hyperref}
\\renewcommand{\\contentsname}{目录}  % 将Contents改为目录
\\usepackage{titletoc}
\\titlecontents{section}[10mm] % 标题左边距
\{\\fontsize{13pt}{20pt}\\selectfont}
\{\\contentslabel{3em}} % label与标题文字的距离
\{}
\{\\titlerule*{}\\contentspage} % 右侧的填充和页码
\\titlecontents{subsection}[15mm]
\{\\fontsize{11pt}{20pt}\\selectfont}
\{\\contentslabel{3em}}
\{}
\{\\titlerule*{.}\\contentspage}
\\titlecontents{subsubsection}[20mm]
\{\\fontsize{11pt}{20pt}\\selectfont}
\{\\contentslabel{4em}}
\{}
\{\\titlerule*{.}\\contentspage}
\%%%% 设置章节标题的字体
\\usepackage{titlesec}
\\newfontfamily{\\H}{Yuanti SC}
\\titleformat*{\\section}{\\LARGE\\bfseries\\H}
\\titleformat*{\\subsection}{\\Large\\bfseries}
\\titleformat*{\\subsubsection}{\\large\\bfseries}
\\titleformat*{\\paragraph}{\\large\\bfseries}
\\titleformat*{\\subparagraph}{\\large\\bfseries}
\\hypersetup{unicode=true}
\\geometry{a4paper, textwidth=6.5in, textheight=10in,marginparsep=7pt,
           \marginparwidth=.6in}
\%punctstyle{kaiming}
\\title{}
\\fancyhf{} %清空页眉页脚
\\fancyfoot[C]{\\bfseries\\thepage}
\%chead{\\MakeUppercase\\sectionmark}
\%pagestyle{fancy}
\\tolerance=1000
\%%%% 段落首行缩进两个字 %%%%
\\makeatletter
\\let\\@afterindentfalse\\@afterindenttrue
\\@afterindenttrue
\\makeatother
\\setlength{\\parindent}{2em}  %中文缩进两个汉字位
[NO-DEFAULT-PACKAGES]
[NO-PACKAGES]"
("\\section{%s}" . "\\section*{%s}")
("\\subsection{%s}" . "\\subsection*{%s}")
("\\subsubsection{%s}" . "\\subsubsection*{%s}")
("\\paragraph{%s}" . "\\paragraph*{%s}")
("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(put 'upcase-region 'disabled nil)

;; 导出Beamer的设置
;; allow for export=>beamer by placing #+LaTeX_CLASS: beamer in org files
;;-----------------------------------------------------------------------------
(add-to-list 'org-latex-classes
             ;; beamer class, for presentations
             '("beamer"
"\\documentclass[smaller, presentation]{beamer}
\\usetheme{Warsaw}
%\\usecolortheme{{{{beamercolortheme}}}}
\\beamertemplateballitem
\\setbeameroption{show notes}
\\usepackage{graphicx}
\\usepackage{tikz}
\\usepackage{xcolor}
\\usepackage{xeCJK}
\\usepackage{amsmath}
\\usepackage{lmodern}
\\usepackage{fontspec,xunicode,xltxtra}
\\usepackage{polyglossia}
\\setmainfont{Times New Roman}
\\setCJKmainfont{Yuanti SC}
\\setCJKmonofont{Yuanti SC}
\\usepackage{verbatim}
\\usepackage{listings}
\\institute{{{{beamerinstitute}}}}
\\subject{{{{beamersubject}}}}"
                              ("\\section{%s}" . "\\section*{%s}")
                              ("\\begin{frame}[fragile]\\frametitle{%s}"
                               "\\end{frame}"
                               "\\begin{frame}[fragile]\\frametitle{%s}"
                               "\\end{frame}")))

(setq ps-paper-type 'a4
      ps-font-size 16.0
      ps-print-header nil
            ps-landscape-mode nil)

(provide 'init-local)
