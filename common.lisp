;; hehe common lisp get it

;; --- docs ---
; https://github.com/vindarel/cl-str
; http://www.lispworks.com/documentation/HyperSpec/Front/Contents.htm

;; --- cheatsheet ---
; (format t "~A~%" (reduce #'+ '(1 2 3 4)))
; (format t "~A~%" (max-in-list '(1 2 3 4)))
; (format t "~A~%" (sort '(9 6 3 9 9 9 0 4) '<))
; (format t "~A~%" (cons '(xd xdd xdddd) '(9 6 3 9 9 9 0 4)))
; (format t "~A~%" (append '(xd xdd xdddd) '(9 6 3 9 9 9 0 4) '(a s d f)))

;; --- rc ---
(load "~/.sbclrc")

;; --- imports ---
(ql:quickload :str)

;; --- funs ---
(defun min-in-list (list)
  "get minimum value in list"
  (reduce #'min list))

(defun max-in-list (list)
  "get maximum value in list"
  (reduce #'max list))

(defun input-string (day &optional (input-name "input"))
  "get string from file"

  (with-open-file
    (istream (format nil "~A/~A" day input-name))
    (let ((contents (make-string (file-length istream))))
      (read-sequence contents istream)
      contents)))

(defun input-lines (day &optional (input-name "input"))
  "get lines from file"

  (with-open-file
    (istream (format nil "~A/~A" day input-name))
    (loop for line = (read-line istream nil)
      while line
        collect line)))

; scuffed ifdef
(defvar *common-loaded* t)
