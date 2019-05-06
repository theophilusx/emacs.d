;;; init-org.el --- Org-mode config -*- lexical-binding: t -*-
;;; Commentary:

(require-package 'org-plus-contrib)

(setq org-agenda-show-outline-path nil
      org-catch-invisible-edits 'smart
      org-ctrl-k-protect-subtree t
      org-default-notes-file "~/Dropbox/org/notes.org"
      org-directory "~/Dropbox/org"
      org-ellipsis "…"
      org-list-allow-alphabetical t
      org-list-indent-offset 2
      org-pretty-entities t
      org-startup-align-all-tables t
      org-startup-with-inline-images (display-graphic-p)
      org-support-shift-select t
      org-use-sub-superscripts (quote {}))

(setq org-modules '(org-bibtex
                    org-crypt
                    org-docview
                    org-eww
                    org-info
                    org-irc
                    org-protocol))

(setq org-capture-templates
      (quote
       (("t" "todo" entry
         (file "~/Dropbox/org/refile.org")
         "* TODO %?\n\n  %a"
         :empty-lines-after 1 :clock-in t :clock-resume t)
        ("r" "respond" entry
         (file "~/Dropbox/org/refile.org")
         "* NEXT Respond to %:from on %:subject\n  SCHEDULED: %t\n  %a"
         :empty-lines-after 1 :clock-in t :clock-resume t)
        ("n" "note" entry
         (file "~/Dropbox/org/notes.org")
         "* %? :NOTE:\n\n  %a"
         :empty-lines-after 1 :clock-in t :clock-resume t)
        ("j" "journal" entry
         (file+olp+datetree "~/Dropbox/org/journal.org")
         "* %?\n  "
         :empty-lines-after 1 :clock-in t :clock-resume t)
        ("p" "phone" entry
         (file "~/Dropbox/org/refile.org")
         "* PHONE %? :PHONE:\n  "
         :empty-lines-after 1 :clock-in t :clock-resume t)
        ("m" "mail" entry
         (file "~/Dropbox/org/refile.org")
         "* MAIL from %:from on %:subject\n\n  %a"
         :empty-lines-after 1 :clock-in t :clock-resume t))))

(setq org-enforce-todo-checkbox-dependencies t
      org-enforce-todo-dependencies t
      org-log-done 'time
      org-log-into-drawer t)

(setq org-todo-keywords
      (quote
       ((sequence "TODO(t)"
                  "NEXT(n)"
                  "STARTED(s!)"
                  "DELEGATED(w@/!)"
                  "HOLD(h@/!)"
                  "|"
                  "CANCELLED(c@)"
                  "DONE(d!)"))))

(setq org-log-refile 'time
      org-refile-allow-creating-parent-nodes 'confirm
      org-refile-targets (quote ((nil :maxlevel . 5)
                                 (org-agenda-files :maxlevel . 5)))
      org-refile-use-outline-path (quote file))

(setq org-clock-in-resume t
      org-clock-out-remove-zero-time-clocks t
      org-clock-persist 'clock
      org-time-clocksum-format
      '(:hours "%d" :require-hours t
               :minutes ":%02d" :require-minutes t))

(setq org-agenda-files '("~/Dropbox/org")
      org-agenda-remove-tags t)

(setq org-agenda-custom-commands
      (quote
       (("n" "Agenda and all TODO's"
         ((agenda "" nil)
          (alltodo "" nil))
         nil)
        ("wr" "Weekly Report"
         ((todo
           "DONE|CANCELLED"
           ((org-agenda-overriding-header
             "Completed and Cancelled : Last Week")))
          (todo
           "STARTED|NEXT"
           ((org-agenda-overriding-header "WIP")))
          (todo
           "HOLD|DELEGATED"
           ((org-agenda-overriding-header "On Hold and Delegated Tasks")))
          (todo
           "TODO"
           ((org-agenda-overriding-header "Task Backlog"))))
         nil nil))))

(setq org-src-tab-acts-natively t
      org-hide-block-startup t
      org-src-window-setup 'current-window)

(setq org-confirm-babel-evaluate nil)

(setq org-babel-clojure-backend 'cider
      org-babel-clojure-sync-nrepl-timeout 0)

(setq org-plantuml-jar-path (expand-file-name
                             "~/.emacs.d/jars/plantuml.jar")
      org-ditaa-jar-path (expand-file-name "~/.emacs.d/jars/ditaa.jar")
      org-ditaa-eps-jar-path (expand-file-name
                              "~/.emacs.d/jars/DitaaEps.jar"))

(setq org-export-backends '(ascii beamer html
                                  latex texinfo
                                  md odt org)
      org-export-coding-system 'utf-8)

(setq org-latex-classes
      '(("beamer"
         "\\documentclass[presentation]{beamer}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
        ("hitec-article"
         "\\documentclass[12pt]{hitec}
    [DEFAULT-PACKAGES]
    [PACKAGES]
    [NO-EXTRA]
    \\settextfraction{0.95}\n"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("article" "\\documentclass[11pt]{article}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("korma-article" "\\documentclass[11pt]{scrartcl}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("report"
         "\\documentclass[11pt]{report}"
         ("\\part{%s}" . "\\part*{%s}")
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
        ("korma-report"
         "\\documentclass[11pt]{scrreport}"
         ("\\part{%s}" . "\\part*{%s}")
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
        ("korma-book"
         "\\documentclass[11pt]{scrbook}"
         ("\\part{%s}" . "\\part*{%s}")
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
        ("book"
         "\\documentclass[11pt]{book}"
         ("\\part{%s}" . "\\part*{%s}")
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(setq org-latex-hyperref-template
      "\\hypersetup{pdfauthor={%a},
                        pdftitle={%t},
                        pdfkeywords={%k},
                        pdfsubject={%d},
                        pdfcreator={%c},
                        pdflang={%L},
                        colorlinks=true,
                        linkcolor=blue}")

(setq org-latex-listings t
      org-latex-listings-options '(("basicstyle" "\\tiny")
                                   ("frame" "single")
                                   ("stringstyle" "\\color{orange}")
                                   ("commentstyle" "\\color{cyan}")
                                   ("keywordstyle" "\\color{blue}")
                                   ("showstringspaces" "false")
                                   ("breakatwhitespace" "false")
                                   ("breaklines" "true")))

(setq org-latex-pdf-process
      '("lualatex -interaction nonstopmode -output-directory %o %f"
        "lualatex -interaction nonstopmode -output-directory %o %f"
        "lualatex -interaction nonstopmode -output-directory %o %f"))

(setq org-latex-packages-alist
      '(("" "parskip")
        ("" "xcolor")
        ("" "listings")))

(setq org-html-checkbox-type 'unicode
      org-html-html5-fancy t
      org-html-doctype "html5")

(setq org-ascii-charset 'utf-8
      org-ascii-text-width 79)

(after-load 'org-plus-contrib
  (org-element-update-syntax)
  (org-clock-persistence-insinuate)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (clojure . t)
     (css . t)
     (dot . t)
     (java . t)
     (js . t)
     (latex . t)
     (ledger . t)
     (lisp . t)
     (makefile . t)
     (org . t)
     (perl . t)
     (python . t)
     (ruby . t)
     (scheme . t)
     (shell . t)
     (sql . t)
     (C . t)
     (ditaa . t)
     (plantuml . t)
     (gnuplot . t)))
  (bind-key "C-c l" 'org-store-link))

(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c r") 'org-capture)

(provide 'init-org)
;;; init-org.el ends here
