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
(ql:quickload :alexandria)

;; --- funs ---
(defun sum (list)
  (reduce #'+ list))

(defun all-permutations (list)
  (apply
    #'alexandria:map-product 'list
    (loop repeat (length list) collect list)))

(defun min-in-list (list)
  (reduce #'min list))

(defun max-in-list (list)
  (reduce #'max list))

(defun input-string (day &optional (input-name "input"))
  (with-open-file
    (istream (format nil "~a/~a" day input-name)
             :direction :input
             :if-does-not-exist nil)
    (if istream
      (let ((contents (make-string (file-length istream))))
        (read-sequence contents istream)
        contents)
      (format t "File ~a/~a not found~%" day input-name))))

(defun input-lines (day &optional (input-name "input"))
  (with-open-file
    (istream (format nil "~a/~a" day input-name)
             :direction :input
             :if-does-not-exist nil)
    (if istream
      (loop for line = (read-line istream nil)
            while line
            collect line)
      (format t "File ~a/~a not found~%" day input-name))))

; scuffed ifdef
(defvar *common-loaded* t)
