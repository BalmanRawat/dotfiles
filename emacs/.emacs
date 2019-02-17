(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-safe-themes
   (quote
    ("aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "99b2fdc7de612b74fcb76eb3a1962092cf729909223434f256c7007d490d787a" "07ed389142fef99649ebcfe1f835cf564fc40bb342d8d2f4e13f05302378a47a" "3e2fd26606cba08448283cc16860c1deab138ede73c38c91fdaf4e5c60ece485" "5e5345ea15d0c2234356bc5958a224776b83198f0c3df7155d1f7575405ce990" default)))
 '(package-selected-packages
   (quote
    (ox-reveal ox-jira typo dracula-theme klere-theme memoize ox-twbs htmlize magit projectile org-bullets flyspell-correct))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; poet-theme
;; wiki https://github.com/kunalb/poet
(add-hook 'text-mode-hook
               (lambda ()
                 (variable-pitch-mode 1)))

(flyspell-mode 1)        ;; Catch Spelling mistakes
(typo-mode 1)            ;; Good for symbols like em-dash
(blink-cursor-mode 0)    ;; Reduce visual noise
(linum-mode 0)           ;; No line numbers for prose

(set-face-attribute 'default nil :family "Iosevka" :height 120)
(set-face-attribute 'fixed-pitch nil :family "Iosevka")
(set-face-attribute 'variable-pitch nil :family "Baskerville")

;; wiki https://www.emacswiki.org/emacs/CustomThemes
(let ((basedir "~/.emacs.d/themes/"))
  (dolist (f (directory-files basedir))
    (if (and (not (or (equal f ".") (equal f "..")))
             (file-directory-p (concat basedir f)))
        (add-to-list 'custom-theme-load-path (concat basedir f)))))
;;custom theme
(load-theme 'poet t)

;; yasnippet
;; wiki https://github.com/joaotavora/yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; yaml-mode
;; wiki https://github.com/yoshiki/yaml-mode
(add-to-list 'load-path "~/.emacs.d/my-installs/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; neo-tree
;; wiki https://github.com/jaypei/emacs-neotree
(add-to-list 'load-path "~/.emacs.d/my-installs/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t)
(setq neo-window-fixed-size nil)

;; go-mode
;; wiki https://github.com/dominikh/go-mode.el
(add-to-list 'load-path "~/.emacs.d/my-installs/go-mode")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'yas-snippet-dirs "~/.emacs.d/my-installs/yasnippet-go")


;; org-reveal
;; wiki https://github.com/joaotavora/yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/org-reveal")
(require 'ox-reveal)

;; all-the-icons
;;wiki https://github.com/domtronn/all-the-icons.el
(add-to-list 'load-path "~/.emacs.d/my-installs/all-the-icons")
(require 'all-the-icons)

;; change the fontsize
(set-face-attribute 'default nil :height 140)

;; change buffer window size
;; wiki https://stackoverflow.com/questions/4987760/how-to-change-size-of-split-screen-emacs-windows
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

;; projectile mode
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; cloudformation-mode
;; wiki https://github.com/drocamor/cloudformation-mode
(add-to-list 'load-path "~/.emacs.d/my-installs/cloudformation-mode")
(autoload 'cloudformation-mode "cloudformation-mode" nil t)
(add-to-list 'auto-mode-alist '(".template\\'" . cloudformation-mode))

;;disabling the toobar, scrollbar and menubar
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(menu-bar-mode -1)

;; babel
;; wiki https://orgmode.org/worg/org-contrib/babel/languages.html#configure
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   
   (shell . t)
   (python . t)
   (emacs-lisp . nil)
   (C . t)

   )
 )

;; docker mode
;; wiki https://github.com/Silex/docker.el

;; files operations
;; wiki http://ergoemacs.org/emacs/emacs_set_backup_into_a_directory.html
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
