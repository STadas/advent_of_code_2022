; repl shenanigans
; (defvar *aoc-day*) (setf *aoc-day* "template")
(if (not (and (boundp '*load-truename*) (boundp '*common-loaded*)
              (not (equal nil *load-truename*)) (equal t *common-loaded*)))
  (if (not (load "common.lisp" :if-does-not-exist nil))
    (load "../common.lisp"))
  (format t "common already loaded~%"))

(defun p1 (data)
  (loop for line in data
        collect line))

(defun p2 (data)
  (loop for line in data
        collect line))

(defun day-main ()
  (format t "-------------------------- answers~%")
  (format t "p1=~a~%" (p1 (input-lines *aoc-day* "exinput")))
  (format t "p2=~a~%" (p2 (input-lines *aoc-day* "exinput"))))
