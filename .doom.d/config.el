;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Cizel"
      user-mail-address "i@cizel.cn")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.org/")

(setq doom-font (font-spec :family "Fira Mono" :size 16))
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;common::default
;;(setq-default line-spacing 0.5)
(defun set-bigger-spacing ()
  (setq-local default-text-properties '(line-spacing 0.1 line-height 1.5 )))
(add-hook 'text-mode-hook 'set-bigger-spacing)
(add-hook 'prog-mode-hook 'set-bigger-spacing)

;;plugin::doom-modeline
(setq doom-modeline-buffer-file-name-style 'file-name)
(setq doom-modeline-icon (display-graphic-p))
(setq doom-modeline-major-mode-icon t)

;;plugn::lsp-mode
(setq lsp-modeline-code-actions-enable nil)

;;plugin::lsp-java
(setq path-to-lombok
      (expand-file-name
       "~/.m2/repository/org/projectlombok/lombok/1.18.12/lombok-1.18.12.jar"
       )
      )
(setq lsp-java-vmargs
      `(
        "-Xmx4G"
        "-XX:+UseG1GC"
        "-XX:+UseStringDeduplication"
        "-noverify"
        ,(concat "-javaagent:" path-to-lombok)
        )
      )
