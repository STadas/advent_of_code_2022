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
(if (not (load "~/.sbclrc" :if-does-not-exist nil))
  (format t "Couldn't load .sblcrc"))

;; --- imports ---
(ql:quickload :str)
(ql:quickload :alexandria)

;; --- funs ---
(defun repeat-to-str (c c-count)
  (format nil "~v@{~a~:*~}" c-count c))

(defun line-batches (s newlines-between)
  (str:split (repeat-to-str #\Newline newlines-between) s))

(defun sum (li)
  (reduce #'+ li))

(defun all-permutations (li)
  (apply
    #'alexandria:map-product 'list
    (loop repeat (length li) collect li)))

(defun min-in-list (li)
  (reduce #'min li))

(defun max-in-list (li)
  (reduce #'max li))

(defun input-str (day &optional (name "input"))
  (with-open-file
    (istream (format nil "~a/~a" day name)
             :direction :input
             :if-does-not-exist nil)
    (if istream
      (let ((contents (make-string (file-length istream))))
        (read-sequence contents istream)
        contents)
      (format t "File ~a/~a not found~%" day name))))

(defun input-lines (day &optional (name "input"))
  (with-open-file
    (istream (format nil "~a/~a" day name)
             :direction :input
             :if-does-not-exist nil)
    (if istream
      (loop for line = (read-line istream nil)
            while line
            collect line)
      (format t "File ~a/~a not found~%" day name))))

;; scuffed ifdef
(defvar *common-loaded* t)
