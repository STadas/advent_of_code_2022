#!/usr/bin/sbcl --script

(load (make-pathname
        :name "../common.lisp"
        :directory (pathname-directory *load-truename*)))

(defun p1 (data)
  "part 1"
  (loop for line in data
        collect line))
        ; collect (str:words line)))

(defun p2 (data)
  "part 2"
  (loop for line in data
        collect line))
        ; collect (str:words line)))


(format t "p1=~A~%" (p1 (get-lines "input")))
(format t "p2=~A~%" (p2 (get-lines "input")))
