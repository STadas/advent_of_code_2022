#!/usr/bin/sbcl --script

(format t "-------------------------- loading common~%")
(if (not (boundp '*common-loaded*))
  (if (not (load "common.lisp" :if-does-not-exist nil))
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
  (setf *aoc-day* (if (every #'digit-char-p day)
                    (format nil "~2,'0d" (parse-integer day))
                    day))
  (format t "-------------------------- running ~a~%" *aoc-day*)
  (if (load (format nil "~A/solution.lisp" *aoc-day*) :if-does-not-exist nil)
    (day-main)
    (format t "Solution for ~a not found~%" *aoc-day*)))

(when (equal (length (cmd-args)) 2)
  (cond
    ((equal "all" (nth 1 (cmd-args)))
     (format t "lol~%"))
    ((equal "template" (nth 1 (cmd-args)))
     (run-day (nth 1 (cmd-args))))
    ((every #'digit-char-p (nth 1 (cmd-args)))
     (run-day (nth 1 (cmd-args))))))
