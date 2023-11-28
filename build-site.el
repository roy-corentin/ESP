;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      '(("orgfiles"
         :recursive t
         :base-directory "./content"
         :publishing-function 'org-html-publish-to-html
         :publishing-directory "./public"
         :base-extension "org\\|svg\\|css\\|png\\|jpg"
         :with-author nil           ;; Don't include author name
         :with-creator t            ;; Include Emacs and Org versions in footer
         :with-toc t                ;; Include a table of contents
         :section-numbers nil       ;; Don't include section numbers
         :time-stamp-file nil       ;; Don't include time stamp in file
         )
        ("images"
         :base-directory "./content/img"
         :base-extension "png\\|jpg\\|svg"
         :publishing-directory "./public/img"
         :publishing-function org-publish-attachment
         )
        ("org-site:main" :components("orgfiles" "images"))))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
