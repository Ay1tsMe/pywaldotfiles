;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "MesloLGS NF" :size 16))

;; Function to reload theme when config is reloaded. Doing this because doom/reload-theme doesn't work
(defun my/load-theme ()
  "Load the specified theme set in `doom-theme`."
  (when doom-theme
    (disable-theme doom-theme)
    (load-theme doom-theme t)))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'dracula)
(setq doom-theme 'ewal-doom-vibrant)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/Sync/DueDates.org"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;; Python Debugger
(require 'dap-python)
(after! dap-mode
  (setq dap-python-debugger 'debugpy))

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

;; Emacs shell config
(use-package exec-path-from-shell
  :init
  (when (daemonp)
    (exec-path-from-shell-initialize)))

;; Indentation settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Buffer tabs
(require 'centaur-tabs)
(centaur-tabs-mode t)
(global-set-key (kbd "C-<prior>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<next>") 'centaur-tabs-forward)
(setq centaur-tabs-style "bar")
(setq centaur-tabs-set-icons t)

;; Indentation guides
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-character ?\|)
(setq highlight-indent-guides-responsive 'top)

;; Enable lsp by default for the following:
(add-hook 'python-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'html-mode-hook 'lsp)

(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp-deferred)
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
 (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Transparent Background
(set-frame-parameter nil 'alpha-background 70)
(add-to-list 'default-frame-alist '(alpha-background . 0.8))

;; Vim line numbers
(setq display-line-numbers-type 'relative)

;; Conda environment
(use-package conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "~/miniforge3"))
  (setq conda-env-home-directory (expand-file-name "~/miniforge3/envs")))

;; Reload the theme because doom/reload-theme doesn't work
(my/load-theme)

;; Change org-agenda to a 14 day agenda
(after! org
  (map! :map org-mode-map
        :localleader
        :desc "Grip Mode Preview" "m g" #'grip-mode)
  (setq org-agenda-span 14)
  (setq org-deadline-warning-days 30))

(after! markdown-mode
  (map! :map markdown-mode-map
        :localleader
        "g" #'grip-mode))

(map! :leader
      :desc "ispell-buffer"
      "s c" #'ispell-buffer)

(defun jl/random-quote ()
  "Generate a random quote for dashboard"
  (interactive)
  (let ((ops '(
    "Hello World!"
    "sudo systemctl stop adamw"
    "sudo systemctl start adamw"
    "sudo systemctl restart adamw"
    "Church of Emacs"
    "https://tuxtower.net"
    "I use arch btw"
    "Everything I want to do is illegal"
    "I debloated my workstation"
    "I am way too dumb to use ubuntu"
    "I got rid of my mattress, it's bloat"
    "Look's like Arch Linux broke once again"
    "Imagine using VS Code"
    "/home/adamw/.config"
    "No emacs???"))) (nth (random (length ops)) ops)))

(defun jl/random-ascii ()
  "Generate a random quote for dashboard"
  (interactive)
  (let ((ops '(
"
    ⠀⠀⠀⠀⠀⡰⢂⣾⠿⠛⠒⠚⠛⠃⠺⢶⡀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⢠⡣⠋⠁⠀⠀⠀⠀⠀⢀⡐⠒⢙⣄⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⡘⠀⠀⠀⠀⠀⠀⢄⠉⠀⠐⠀⠀⠙⢦⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⣾⠁⠀⠀⠄⠂⢈⣠⠎⠀⠀⣸⣿⡿⠓⢬⡇⠀⠀⠀⠀⠀
    ⠀⠀⢸⡟⠀⠔⣁⣤⣶⣿⠋⢰⠀⠀⣿⡟⠻⣦⠀⢳⠀⠀⠀⠀⠀
    ⠀⠀⣷⡇⢠⣾⢟⢭⣭⡭⡄⠀⡆⠀⣿⣷⣶⠺⡆⢸⡄⠀⠀⠀⠀
    ⠀⠀⠇⡇⠛⠡⣑⣈⣛⠝⢁⡀⠇⠀⣿⡿⠛⠒⣡⠇⣧⣀⠀⠀⠀
    ⠀⠀⢠⠁⠈⠐⠤⠄⠀⣠⢸⠈⠢⠀⣿⡇⠀⠀⠠⠚⣿⣿⠀⠀⠀
    ⡄⠀⢾⠀⡆⠠⣴⠞⠯⡀⠈⠙⠲⣶⣿⡇⠑⣦⡄⠀⣿⣿⠀⠀⠀
    ⠈⠺⡮⠀⢡⠀⠀⠀⠀⠀⠁⠐⠒⠒⠛⠃⠈⠛⠇⠀⡏⡏⠀⠀⠀
    ⠀⢰⠁⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⢷⠀⠀⠀
    ⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠃⠀⢸⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡄⠀⠀
    ⠀⠀⢣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠸⡳⡀⠀
    ⠀⠀⠀⠑⢄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣯⣼⡇⠑⣄
"
"
⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀⠀
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"
    ))) (nth (random (length ops)) ops)))
(defun jl/random-icon ()
  "Generate a random image for dashboard"
  (interactive)
  (let* ((icons-dir (expand-file-name "icons/" (expand-file-name ".config/doom/" (getenv "HOME"))))
        (ops (directory-files icons-dir))
        (ops (delete "." ops))
        (ops (delete ".." ops))
        (file (nth (random (length ops)) ops)))
          (expand-file-name file icons-dir)))

(use-package dashboard
  :config
    (setq default-directory "~/"
          dashboard-icon-type 'nerd-icons
          dashboard-set-file-icons t
          dashboard-vertically-center-content t
          dashboard-center-content t
          dashboard-display-icons-p t
          initial-buffer-choice (lambda() (get-buffer-create "*dashboard*"))
          dashboard-banner-logo-title (jl/random-quote)
          dashboard-footer-messages `(,(jl/random-quote)))
    (if (display-graphic-p)
      (setq dashboard-startup-banner (jl/random-icon))
      (progn
        (setq dashboard-startup-banner 'ascii)
        (setq dashboard-banner-ascii (jl/random-ascii))))
    (dashboard-setup-startup-hook))
