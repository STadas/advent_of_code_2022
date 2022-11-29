#!/usr/bin/sbcl --script

(format t "-------------------------- loading common~%")
(if (not (boundp '*common-loaded*))
  (if (not (ignore-errors (load "common.lisp")))
    (load "../common.lisp")))

(defun cmd-args ()
  (or
    #+CLISP *args*
    #+SBCL *posix-argv*
    #+LISPWORKS system:*line-arguments-list*
    #+CMU extensions:*command-line-words*
    nil))

(defvar *aoc-day*)
(defun run-day (day)
  (format t "-------------------------- running ~A~%" day)
  (setf *aoc-day* (if (every #'digit-char-p day)
                    (format nil "~2,'0d" (parse-integer day))
                    day))
  (handler-case
    (progn
      (load (format nil "~A/solution.lisp" *aoc-day*))
      (day-main))
    (sb-int:simple-file-error (c) (format nil "~A~%" c))))

(cond
  ((equal "all" (nth 1 (cmd-args)))
   (format t "lol"))
  ((equal "template" (nth 1 (cmd-args)))
   (run-day (nth 1 (cmd-args))))
  ((every #'digit-char-p (nth 1 (cmd-args)))
   (run-day (nth 1 (cmd-args)))))
