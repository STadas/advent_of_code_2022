(defun ch-to-prio (ch)
  (if (upper-case-p ch)
    (- (char-int ch) 38)
    (- (char-int ch) 96)))

(defun seq-mid (seq)
  (ceiling (length seq) 2))

(defun common-chars (s1 s2)
  (intersection (coerce s1 'list) (coerce s2 'list)))

(defun common-in-group (group)
  (first (reduce #'common-chars group)))

(defun p1 (data)
  (sum (loop for line in data
             collect
             (ch-to-prio
               (first (common-chars
                        (subseq line 0 (seq-mid line))
                        (subseq line (seq-mid line))))))))

(defun p2 (data)
  (sum (loop for line in data
             for idx from 0
             when (zerop (mod idx 3))
             collect
             (ch-to-prio
               (common-in-group
                 (list
                   (nth idx data)
                   (nth (+ idx 1) data)
                   (nth (+ idx 2) data)))))))

(defun day-main ()
  (format t "-------------------------- answers~%")
  (format t "p1=~A~%" (p1 (input-lines *aoc-day*)))
  (format t "p2=~A~%" (p2 (input-lines *aoc-day*))))
