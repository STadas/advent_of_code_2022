(defun ch-to-prio (ch)
  (- (char-int ch)
     (if (lower-case-p ch)
       (- (char-int #\a) 1)
       (- (char-int #\A) 27))))

(defun seq-mid (seq)
  (ceiling (length seq) 2))

(defun common-chars (s1 s2)
  (intersection (coerce s1 'list) (coerce s2 'list)))

(defun common-in-group (group)
  (first (reduce #'common-chars group)))

(defun p1 (data)
  (sum (mapcar
         (lambda (line)
           (ch-to-prio
             (first (common-chars
                      (subseq line 0 (seq-mid line))
                      (subseq line (seq-mid line))))))
         data)))

(defun p2 (data)
  (sum (loop for idx below (length data)
             when (zerop (mod idx 3))
             collect
             (ch-to-prio
               (common-in-group (subseq data idx (+ idx 3)))))))

(defun day-main ()
  (format t "p1=~a~%" (p1 (input-lines *aoc-day*)))
  (format t "p2=~a~%" (p2 (input-lines *aoc-day*))))
