(defun range (start end)
  (loop for i from (parse-integer start) to (parse-integer end)
        collect i))

(defun check-subset (r1 r2)
  (if (< (length r1) (length r2))
    (subsetp r1 r2)
    (subsetp r2 r1)))

(defun check-overlap (r1 r2)
  (zerop (length (intersection r1 r2))))

(defun p1 (data)
  (length (remove nil (loop for line in data
        collect (apply #'check-subset (mapcar (lambda (r)
                          (apply #'range (str:split "-" r)))
                        (str:split "," line)))))))

(defun p2 (data)
  (length (remove t (loop for line in data
        collect (apply #'check-overlap (mapcar (lambda (r)
                          (apply #'range (str:split "-" r)))
                        (str:split "," line)))))))

(defun day-main ()
  (format t "p1=~a~%" (p1 (input-lines *aoc-day*)))
  (format t "p2=~a~%" (p2 (input-lines *aoc-day*))))
