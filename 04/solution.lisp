(defun is-subset (r1 r2)
  (and (>= (nth 0 r1) (nth 0 r2)) (<= (nth 1 r1) (nth 1 r2))))

(defun is-overlay (r1 r2)
  (and (<= (nth 0 r1) (nth 1 r2)) (>= (nth 1 r1) (nth 0 r2))))

(defun line-to-r (line)
  (mapcar
    (lambda (r)
      (mapcar #'parse-integer (str:split "-" r)))
    (str:split "," line)))

(defun xd (data p)
  (length
    (remove nil
            (mapcar (lambda (line)
                      (or (apply p (line-to-r line))
                          (apply p (reverse (line-to-r line)))))
                    data))))

(defun day-main ()
  (format t "p1=~a~%" (xd (input-lines *aoc-day*) #'is-subset))
  (format t "p2=~a~%" (xd (input-lines *aoc-day*) #'is-overlay)))
