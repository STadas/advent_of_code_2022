;; hehe common lisp get it

;; --- rc ---
(load "~/.sbclrc")

;; --- imports ---
(ql:quickload :str)

;; --- funs ---
(defun get-lines (filename)
  "get lines from a file"

  (with-open-file
    (str (make-pathname
           :name filename
           :directory (pathname-directory *load-truename*)))
    (loop for line = (read-line str nil)
      while line
        collect line)))
