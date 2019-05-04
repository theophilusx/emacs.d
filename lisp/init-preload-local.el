;;; commentary:
;;; This file is used to setrup emacspeak which needs to be
;;; initialised early in the init process

;;; code:

(defconst *emacspeak-src-dir* (expand-file-name "~/git/emacspeak/trunk")
  "Where emacs will find the emacspeak distro")

(require 'info)
(add-to-list 'Info-additional-directory-list
             (expand-file-name "info"  *emacspeak-src-dir*))

(if *is-a-mac*
    (defconst *emacspeak-server* "mac")
  (defconst *emacspeak-server* "outloud"))

(require 'info)
(add-to-list 'Info-additional-directory-list
             (expand-file-name "info"  *emacspeak-src-dir*))



(when (and (not noninteractive)
           (not (featurep 'emacspeak)))
  (add-to-list 'load-path *emacspeak-src-dir*)
  (setenv "EMACSPEAK_DIR" *emacspeak-src-dir*)
  (setenv "DTK_PROGRAM" *emacspeak-server*)
  (setq dtk-program *emacspeak-server*
        dtk-use-tones nil
        emacspeak-auditory-icon-function 'emacspeak-soxplay-auditory-icon
        emacspeak-erc-my-nick "theophilusx"
        emacspeak-erc-speak-all-participants t
        emacspeak-mail-alert nil
        emacspeak-play-emacspeak-startup-icon nil
        emacspeak-play-program "/home/tcross/bin/play"
        emacspeak-play-args nil
        emacspeak-wizards-available-browsers (if *is-a-mac*
                                                 '(eww-browse-url browse-url-default-macosx-browser)
                                               '(eww-browse-url browse-url-chrome))
        emacspeak-vm-use-raman-settings nil
        mac-default-speech-rate 370
        outloud-default-speech-rate 90
        sox-play (if *is-a-mac*
                     "/usr/local/bin/play"
                   "/usr/bin/play")
        emacspeak-soxplay-command (if *is-a-mac*
                                      "/usr/local/bin/play -v 1.2 %s earwax &"
                                    "/usr/bin/play -v 1.2 %s earwax &")
        tts-default-speech-rate 90)
  (add-hook 'emacspeak-startup-hook
            (lambda ()
              ;; (dtk-set-rate tts-default-speech-rate 1)
              (dtk-interp-sync)
              (emacspeak-sounds-select-theme "3d/")))
  (load-file (concat *emacspeak-src-dir* "/lisp/emacspeak-setup.el")))

(provide 'init-preload-local)
;;; init-preload-local.el ends here
