;; hehe common lisp get it

;; --- rc ---
(if (not (load "~/.sbclrc" :if-does-not-exist nil))
  (format t "Couldn't load .sblcrc"))

;; --- imports ---
(ql:quickload :str)
(ql:quickload :alexandria)

;; --- funs ---
(defun v-list (list-of-lists idx)
  (mapcar (lambda (li) (nth idx li)) list-of-lists))

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
