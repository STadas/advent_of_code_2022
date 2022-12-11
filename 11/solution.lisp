(defclass monky ()
  ((items :initarg :items :accessor items)
   (op :initarg :op :accessor op)
   (div :initarg :div :accessor div)
   (if-t :initarg :if-t :accessor if-t)
   (if-nil :initarg :if-nil :accessor if-nil)
   (insp-count :accessor insp-count :initform 0)))

(defun make-monky (batch)
  (make-instance
    'monky
    :items (str:split ", " (nth 1 (str:split ": " (nth 1 batch))))
    :op (str:split " " (nth 1 (str:split " = " (nth 2 batch))))
    :div (parse-integer (nth 1 (str:split "by " (nth 3 batch))))
    :if-t (parse-integer (nth 1 (str:split "monkey " (nth 4 batch))))
    :if-nil (parse-integer (nth 1 (str:split "monkey " (nth 5 batch))))))

(defun do-op (item op)
  (let* ((parsed-op (substitute item "old" op :test 'equal)))
    (funcall (read-from-string (nth 1 parsed-op))
             (parse-integer (nth 0 parsed-op))
             (parse-integer (nth 2 parsed-op)))))

(defun play-round (monkys p1)
  (loop for m in monkys do
        (loop for item in (items m) do
              (let* ((res (floor (/ (mod (do-op item (op m))
                                         (reduce #'* (mapcar #'div monkys)))
                                    (if p1 3 1))))
                     (to-monky (nth (if (zerop (mod res (div m)))
                                      (if-t m) (if-nil m)) monkys)))
                (setf (items to-monky)
                      (append (items to-monky) (list (write-to-string res))))))
        (incf (insp-count m) (length (items m)))
        (setf (items m) (list))))

(defun xd (data p1)
  (let* ((monkys (loop for mnky in (line-batches data 2) collect
                       (make-monky (str:lines mnky)))))
    (loop for r below (if p1 20 10000) do
          (play-round monkys p1))
    (apply #'* (subseq (sort (mapcar #'insp-count monkys) '>) 0 2))))

(defun day-main ()
  (format t "p1=~a~%" (xd (input-str *aoc-day*) t))
  (format t "p2=~a~%" (xd (input-str *aoc-day*) nil)))
