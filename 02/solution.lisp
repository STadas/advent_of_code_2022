(defun choice-to-pts (abcxyz)
  (case (char abcxyz 0) (#\A 1) (#\B 2) (#\C 3) (#\X 1) (#\Y 2) (#\Z 3)))

(defun res-to-pts (xyz)
  (case (char xyz 0) (#\X 0) (#\Y 3) (#\Z 6)))

(defun play-round (abc xyz)
  (+ (case (mod (- abc xyz) 3)
       (1 0) (2 6) (0 3))
     xyz))

(defun reverse-round (abc xyz)
  (+ (case xyz
       (0 (+ (mod (+ abc 1) 3) 1))
       (3 abc)
       (6 (+ (mod abc 3) 1)))
     xyz))

(defun p1 (data)
  (sum (loop for line in (mapcar (lambda (s) (str:split " " s)) data)
             collect (apply (lambda (abc xyz)
                              (play-round
                                (choice-to-pts abc)
                                (choice-to-pts xyz)))
                            line))))

(defun p2 (data)
  (sum (loop for line in (mapcar (lambda (s) (str:split " " s)) data)
             collect (apply (lambda (abc xyz)
                              (reverse-round
                                (choice-to-pts abc)
                                (res-to-pts xyz)))
                            line))))

(defun day-main ()
  (format t "p1=~a~%" (p1 (input-lines *aoc-day*)))
  (format t "p2=~a~%" (p2 (input-lines *aoc-day*))))
