;;; faustine-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "faustine" "faustine.el" (0 0 0 0))
;;; Generated autoloads from faustine.el

(autoload 'faustine-mode "faustine" "\
A mode to allow the edition of Faust code.

Syntax highlighting of all the Faust commands and operators, as
well as indentation rules, using [faust-mode](https://melpa.org/#/faust-mode).

Every referenced (\"component\") file is linked, and can be
opened by clicking on it or by pressing `RET' over it ; Imported
library files are linked too.

The code is checked at each save ; The state of the last check is
displayed in the modeline as a green bug icon when it compiles
without error or warning, and a red bug when it doesn't. This
icon is also the main Faustine menu.

An \"output buffer\" is provided to display information about the
Faust command output, you can toggle its visibility with
`faustine-toggle-output-buffer' ; see `faustine-output-mode'
documentation for details about interaction in said buffer.

Several commands allow the editing of Faust code, they are all
available in the menu or as a key binding, and described below.

\\{faustine-mode-map}

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "faustine" '("faustine-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; faustine-autoloads.el ends here
