(defun xd (data n)
  (sum (subseq (sort
    (mapcar
      (lambda (batch)
        (sum (mapcar #'parse-integer (str:lines batch))))
      (line-batches data 2))
    '>) 0 n)))

(defun day-main ()
  (format t "p1=~a~%" (xd (input-str *aoc-day*) 1))
  (format t "p2=~a~%" (xd (input-str *aoc-day*) 3)))
