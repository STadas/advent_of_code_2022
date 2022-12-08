(defun direction-obp (height direction-li)
  (some (lambda (tree) (>= tree height)) direction-li))

(defun is-visible (x y forest)
  (let* ((tree (nth x (nth y forest))))
    (notevery
      (lambda (direction-li) (direction-obp tree direction-li))
      (list (subseq (v-list forest x) 0 y)
            (subseq (v-list forest x) (1+ y))
            (subseq (nth y forest) 0 x)
            (subseq (nth y forest) (1+ x))))))

(defun visible-trees (height direction-li)
  (length (subseq direction-li 0
                  (1+ (or (position-if
                            (lambda (tree) (>= tree height))
                            direction-li)
                          (1- (length direction-li)))))))

(defun scenic-score (x y forest)
  (reduce
    #'* (mapcar
          (lambda (direction-li)
            (visible-trees (nth x (nth y forest)) direction-li))
          (list (reverse (subseq (v-list forest x) 0 y))
                (subseq (v-list forest x) (1+ y))
                (reverse (subseq (nth y forest) 0 x))
                (subseq (nth y forest) (1+ x))))))

(defun p1 (data)
  (let* ((forest (mapcar (lambda (line) (map 'list #'digit-char-p line)) data)))
    (sum (loop for y below (length forest) collect
               (count t (loop for x below (length (nth 0 forest)) collect
                              (is-visible x y forest)))))))

(defun p2 (data)
  (let* ((forest (mapcar (lambda (line) (map 'list #'digit-char-p line)) data)))
    (max-in-list
      (loop for y below (length forest)
            collect
            (max-in-list (loop for x below (length (nth 0 forest))
                               collect (scenic-score x y forest)))))))

(defun day-main ()
  (format t "p1=~a~%" (p1 (input-lines *aoc-day*)))
  (format t "p2=~a~%" (p2 (input-lines *aoc-day*))))
