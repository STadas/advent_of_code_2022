(defun data-to-stacks (data)
  (mapcar
    (lambda (s) (remove #\Space (coerce s 'list)))
    (reduce
      (lambda (line1 line2)
        (loop for idx below (length line1)
              collect
              (concatenate 'string (nth idx line1) (nth idx line2))))
      (mapcar
        (lambda (line)
          (loop for idx from 1 below (length line)
                when (= (mod idx 4) 1)
                collect (subseq line idx (1+ idx))))
        (butlast (str:lines (nth 0 (line-batches data 2))))))))

(defun m-count (line)
  (parse-integer (nth 1 (str:words line))))

(defun m-from (line)
  (1- (parse-integer (nth 3 (str:words line)))))

(defun m-to (line)
  (1- (parse-integer (nth 5 (str:words line)))))

(defun p1-handle-line (line stacks)
  (loop repeat (m-count line) do
        (push (pop (nth (m-from line) stacks))
              (nth (m-to line) stacks))))

(defun p2-handle-line (line stacks)
  (let* ((from-stack (nth (m-from line) stacks)))
    (setf (elt stacks (m-from line)) (subseq from-stack (m-count line)))
    (mapcar (lambda (c) (push c (nth (m-to line) stacks)))
            (reverse (subseq from-stack 0 (m-count line))))))

(defun xd (data line-handler)
  (let* ((stacks (data-to-stacks data)))
    (loop for line in (str:lines (nth 1 (line-batches data 2))) do
          (funcall line-handler line stacks))
    (concatenate 'string (mapcar #'first stacks))))

(defun day-main ()
  (format t "p1=~a~%" (xd (input-str *aoc-day*) #'p1-handle-line))
  (format t "p2=~a~%" (xd (input-str *aoc-day*) #'p2-handle-line)))
