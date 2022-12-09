(defun move-segment (segment-idx rope)
  (let* ((x 0)
         (y 0)
         (xdiff (- (nth 0 (nth (1- segment-idx) rope))
                   (nth 0 (nth segment-idx rope))))
         (ydiff (- (nth 1 (nth (1- segment-idx) rope))
                   (nth 1 (nth segment-idx rope)))))
    (case xdiff
      (2 (incf x))
      (-2 (decf x)))
    (case ydiff
      (2 (incf y))
      (-2 (decf y)))
    (if (and (/= x 0) (= y 0))
      (incf (nth 1 (nth segment-idx rope)) ydiff))
    (if (and (/= y 0) (= x 0))
      (incf (nth 0 (nth segment-idx rope)) xdiff))
    (incf (nth 0 (nth segment-idx rope)) x)
    (incf (nth 1 (nth segment-idx rope)) y)))

(defun move-rope (dir amount segments rope)
  (loop for n from 1 to amount collect
        (progn
          (case dir
            (#\L (decf (nth 0 (nth 0 rope))))
            (#\R (incf (nth 0 (nth 0 rope))))
            (#\U (incf (nth 1 (nth 0 rope))))
            (#\D (decf (nth 1 (nth 0 rope)))))
          (loop for segment-idx from 1 below segments do
                (move-segment segment-idx rope))
          (list (nth 0 (nth (1- segments) rope))
                (nth 1 (nth (1- segments) rope))))))

(defun xd (data rope-len)
  (let* ((rope (loop for k below rope-len collect (list 0 0))))
    (length (remove-duplicates
              (apply #'concatenate 'list
                     (mapcar (lambda (line)
                               (move-rope
                                 (char (nth 0 (str:split " " line)) 0)
                                 (parse-integer (nth 1 (str:split " " line)))
                                 rope-len
                                 rope)) data))
              :test 'equal))))

(defun day-main ()
  (format t "p1=~a~%" (xd (input-lines *aoc-day*) 2))
  (format t "p2=~a~%" (xd (input-lines *aoc-day*) 10)))
