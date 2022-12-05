(defun p1 (data)
  (let* ((batches (line-batches data 2))
         (stacks (mapcar (lambda (s) (coerce s 'list)) (str:lines (nth 0 batches))))
         (moves (str:lines (nth 1 batches))))
    (loop for line in moves
          do (let* ((amount (parse-integer (nth 1 (str:words line))))
                    (from (1- (parse-integer (nth 3 (str:words line)))))
                    (to (1- (parse-integer (nth 5 (str:words line))))))
               (loop repeat amount do
                     (push (pop (nth from stacks)) (nth to stacks)))))
    (concatenate 'string (mapcar #'first stacks))))

(defun p2 (data)
  (let* ((batches (line-batches data 2))
         (stacks (mapcar (lambda (s) (coerce s 'list)) (str:lines (nth 0 batches))))
         (moves (str:lines (nth 1 batches))))
    (loop for line in moves
          do (let* ((amount (parse-integer (nth 1 (str:words line))))
                    (from (1- (parse-integer (nth 3 (str:words line)))))
                    (to (1- (parse-integer (nth 5 (str:words line)))))
                    (from-stack (nth from stacks))
                    (moving-stack (subseq from-stack 0 amount)))
               (setf (elt stacks from) (subseq from-stack amount))
               (mapcar (lambda (c) (push c (nth to stacks))) (reverse moving-stack))))
    (concatenate 'string (mapcar #'first stacks))))

(defun day-main ()
  (format t "p1=~a~%" (p1 (input-str *aoc-day*)))
  (format t "p2=~a~%" (p2 (input-str *aoc-day*))))
