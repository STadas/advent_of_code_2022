; repl shenanigans
; (defvar *aoc-day*) (setf *aoc-day* "template")
(if (not (and (boundp '*load-truename*) (boundp '*common-loaded*)
              (not (equal nil *load-truename*)) (equal t *common-loaded*)))
  (if (not (load "common.lisp" :if-does-not-exist nil))
    (load "../common.lisp"))
  (format t "common already loaded~%"))

(defvar *opq*)
(defvar *x*)
(defvar *clock*)

(defun finish-exec ()
  (if (/= 0 (length *opq*))
    (progn
      (decf (nth 0 (nth 0 (last *opq*))))
      (if (= 0 (nth 0 (nth 0 (last *opq*))))
        (progn
          (incf *x* (nth 1 (nth 0 (last *opq*))))
          (setf *opq* (butlast *opq*))))))
  ; (format t "finish ~a clock ~a~%" *x* *clock*)
  (incf *clock*))

(defun begin-exec (op)
  ; (format t "~a " op)
  (if (string= (nth 0 op) "addx")
    (push (list 2 (parse-integer (nth 1 op))) *opq*))
  (if (string= (nth 0 op) "noop")
    (push (list 1 0) *opq*)))

(defvar *ss-sum* 0)
(defun handle-ss ()
  (if (or (= 20 *clock*) (zerop (mod (- *clock* 20) 40)))
    (incf *ss-sum* (* *clock* *x*))))

(defun p1 (data)
  (setf *opq* (list))
  (setf *x* 1)
  (setf *clock* 1)
  (loop for line in data do
        (begin-exec (str:split " " line)))
  (loop while (/= 0 (length *opq*)) do
        (progn
          (handle-ss)
          (finish-exec)))
  *ss-sum*)

(defvar *display* (format nil "~%"))
(defvar *row* "")
(defun handle-display ()
  (setf *row* (concatenate 'string *row* (if (and
                                               (>= (+ *x* 1) (1- (mod *clock* 40)))
                                               (<= (- *x* 1) (1- (mod *clock* 40))))
                                               "#" ".")))
  ; (format t "clock ~a x ~a pos ~a drew ~a~%" *clock* *x* (1- (mod *clock* 40)) (char *row* (1- (length *row*))))
  (if (zerop (mod *clock* 40))
    (progn
      (setf *display* (concatenate 'string *display* (format nil "~a~%" *row*)))
      (setf *row* ""))))

(defun p2 (data)
  (setf *opq* (list))
  (setf *x* 1)
  (setf *clock* 1)
  (loop for line in data do
        (begin-exec (str:split " " line)))
  (loop while (/= 0 (length *opq*)) do
        (progn
          (handle-display)
          (finish-exec)))
  *display*)

(defun day-main ()
  (format t "-------------------------- answers~%")
  (format t "p1=~a~%" (p1 (input-lines *aoc-day*)))
  (format t "p2=~a~%" (p2 (input-lines *aoc-day*))))
