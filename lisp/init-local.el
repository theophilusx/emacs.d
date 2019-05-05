;;; init-local.el --- Summary
;;; Commentary:
;;; Code:

(require 'info)

;;; mu4e config

(if *is-a-mac*
    (progn
      (setq mu4e-lisp "/usr/local/share/emacs/site-lisp/mu/mu4e")
      (setq mu4e-info "/usr/local/share/info"))
  (setq mu4e-lisp "/usr/share/emacs/site-lisp/mu4e")
  (setq mu4e-info "/usr/share/info"))

(add-to-list 'load-path (expand-file-name mu4e-lisp))
(add-to-list 'Info-additional-directory-list (expand-file-name mu4e-info))

(require 'mu4e)

(setq tx-gmail-email "theophilusx@gmail.com"
      tx-sheepcrc-email "tcross8@une.edu.au"
      tx-hotmail-email "blind-bat@hotmail.com")
(setq mu4e-maildir (expand-file-name "~/Maildir")
      mu4e-attachment-dir (expand-file-name "~/Desktop")
      mu4e-get-mail-command "mbsync -a"
      mu4e-headers-include-related nil
      mu4e-change-filenames-when-moving t
      mu4e-context-policy 'pick-first
      mu4e-compose-context-policy nil
      mu4e-view-fields '(:from :to :cc :subject :date :attachments)
      mu4e-view-scroll-to-next nil
      mu4e-view-show-addresses t
      mu4e-view-use-gnus t
      mu4e-user-mail-address-list '("theophilusx@gmail.com"
                                    "tcross8@une.edu.au"
                                    "tcross@une.edu.au"
                                    "blind-bat@hotmail.com"))
(setq org-mu4e-link-query-in-headers-mode nil)

(setq mu4e-bookmarks `(,(make-mu4e-bookmark
                         :name  "Unread messages"
                         :query "flag:unread AND NOT flag:trashed"
                         :key ?u)
                       ,(make-mu4e-bookmark
                         :name "Today's messages"
                         :query "date:today..now"
                         :key ?t)
                       ,(make-mu4e-bookmark
                         :name "Last 7 days"
                         :query "date:7d..now"
                         :key ?w)
                       ,(make-mu4e-bookmark
                         :name "Messages with images"
                         :query "mime:image/*"
                         :key ?p)))

(setq mu4e-contexts
      `(,(make-mu4e-context
          :name "Private"
          :enter-func (lambda ()
                        (mu4e-message "Entering Private context"))
          :leave-func
          (lambda ()
            (mu4e-message "Leaving Private context"))
          ;; we match based on the contact-fields of the message
          :match-func
          (lambda (msg)
            (when msg
              (mu4e-message-contact-field-matches msg :to "theophilusx@gmail.com")))
          :vars '((user-mail-address . "theophilusx@gmail.com")
                  (user-full-name . "Tim Cross")
                  (mu4e-compose-signature . (concat "Tim Cross\n"))
                  (mu4e-drafts-folder . "/gmail/Drafts")
                  (mu4e-sent-folder . "/gmail/Sent Mail")
                  (mu4e-trash-folder . "/gmail/Bin")
                  (mu4e-refile-folder . "/gmail/All Mail")
                  (mu4e-maildir-shortcuts . (("/gmail/INBOX" . ?i)
                                             ("/gmail/Sent Mail" . ?s)
                                             ("/gmail/All Mail" . ?a)
                                             ("/gmail/Drafts" . ?d)
                                             ("/gmail/Starred" . ?f)))
                  (smtpmail-smtp-server . "smtp.gmail.com")
                  (smtpmail-smtp-service . 587)
                  (mu4e-sent-messages-behavior . delete)))
        ,(make-mu4e-context
          :name "Sheep"
          :enter-func
          (lambda ()
            (mu4e-message "Entering Sheep context"))
          :leave-func
          (lambda ()
            (mu4e-message "Leaving Sheep context"))
          ;; we match based on the contact-fields of the message
          :match-func
          (lambda (msg)
            (when msg
              (mu4e-message-contact-field-matches msg :to "tcross8@une.edu.au")))
          :vars '((user-mail-address . "tcross8@une.edu.au")
                  (user-full-name . "Tim Cross")
                  (mu4e-compose-signature . (concat
                                             "Tim Cross\n"
                                             "DBA/Developer - Livestock App Building\n"
                                             "School of Science and Technology\n"
                                             "Room 253 Booth Block (C027), Univrsity of New England\n"))
                  (mu4e-drafts-folder . "/sheep/Drafts")
                  (mu4e-sent-folder . "/sheep/Sent Items")
                  (mu4e-trash-folder . "/sheep/Deleted Items")
                  (mu4e-refile-folder . "/sheep/Archive")
                  (mu4e-maildir-shortcuts . (("/sheep/INBOX" . ?i)
                                             ("/sheep/Sent Items" . ?s)
                                             ("/sheep/Archive" . ?a)
                                             ("/sheep/Drafts" . ?d)))
                  (smtpmail-smtp-server . "mailhub.une.edu.au")
                  (smtpmail-smtp-service . 25)
                  (mu4e-sent-messages-behavior . sent)))
        ,(make-mu4e-context
          :name "Outlook"
          :enter-func
          (lambda ()
            (mu4e-message "Entering Outlook context"))
          :leave-func
          (lambda ()
            (mu4e-message "Leaving Outlook context"))
          ;; we match based on the contact-fields of the message
          :match-func
          (lambda (msg)
            (when msg
              (mu4e-message-contact-field-matches msg :to "blind-bat@hotmail.com")))
          :vars '((user-mail-address . "blind-bat@hotmail.com")
                  (user-full-name . "Tim Cross")
                  (mu4e-compose-signature . (concat "Tim Cross\n"))
                  (mu4e-drafts-folder . "/outlook/Drafts")
                  (mu4e-sent-folder . "/outlook/Sent Mail")
                  (mu4e-trash-folder . "/outlook/Deleted Items")
                  (mu4e-refile-folder . "/outlook/Archive")
                  (mu4e-maildir-shortcuts . (("/outlook/INBOX" . ?i)
                                             ("/outlook/Sent Mail" . ?s)
                                             ("/outlook/Archive" . ?a)
                                             ("/outlook/Drafts" . ?d)))
                  (smtpmail-smtp-server . "smtp-mail.outlook.com")
                  (smtpmail-smtp-service . 587)
                  (mu4e-sent-messages-behavior . delete)))))

(add-hook 'message-mode-hook 'turn-on-orgtbl)

;;; set default font

(if *is-a-mac*
    (set-face-attribute 'default nil
                        :foundry nil
                        :family "Source Code Pro"
                        :height 340)
  (set-face-attribute 'default nil
                      :foundry "PfEd"
                      :family "Ricty Diminished"
                      :height 230))


;;; browse-url

(require 'browse-url)

(if *is-a-mac*
    ;; (setq browse-url-browser-function 'browse-url-default-macosx-browser)
    (setq browse-url-browser-function 'eww-browse-url)
  (setq browse-url-browser-function 'eww-browse-url))

(maybe-require-package 'highlight-indentation)

(after-load 'highlight-indentation
  (add-hook 'prog-mode-hook #'highlight-indentation-current-column-mode))

(provide 'init-local)
;;; init-local.el ends here
