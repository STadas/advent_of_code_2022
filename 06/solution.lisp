(defun xd (data m-len)
  (loop for i below (- (length data) m-len)
        when (= m-len (length (remove-duplicates (subseq data i (+ i m-len)))))
        do (return-from xd (+ i m-len))))

(defun day-main ()
  (format t "-------------------------- answers~%")
  (format t "p1=~a~%" (xd (input-str *aoc-day*) 4))
  (format t "p2=~a~%" (xd (input-str *aoc-day*) 14)))
