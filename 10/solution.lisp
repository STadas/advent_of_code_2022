(defun run-op (op) ; => '(cycles V)
  (cond
    ((string= (nth 0 op) "noop") (list 1 0))
    ((string= (nth 0 op) "addx") (list 2 (parse-integer (nth 1 op))))))

(defun sig-str (state op) ; => '(cycles x sum) '(cycles V) => '(cycles x sum)
  (list (+ (nth 0 state) (nth 0 op))
        (+ (nth 1 state) (nth 1 op))
        (+ (nth 2 state)
           (sum
             (loop for tick from 0 below (nth 0 op)
                   collect
                   (if (or (= 20 (+ tick (nth 0 state)))
                           (zerop (mod (- 20 (+ tick (nth 0 state))) 40)))
                     (* (+ tick (nth 0 state)) (nth 1 state))
                     0))))))

(defun display (state op) ; => '(cycles x disp) '(cycles V) => '(cycles x disp)
  (list (+ (nth 0 state) (nth 0 op))
        (+ (nth 1 state) (nth 1 op))
        (format ; all my homies hate concatenate
          nil "~a~a"
          (nth 2 state)
          (format
            nil "~{~a~}"
            (loop for tick from 0 below (nth 0 op) collect
                  (format
                    nil "~a~a"
                    (if (and (>= (+ (nth 1 state) 1)
                                 (1- (mod (+ tick (nth 0 state)) 40)))
                             (<= (- (nth 1 state) 1)
                                 (1- (mod (+ tick (nth 0 state)) 40))))
                      "#" " ")
                    (if (zerop (mod (+ tick (nth 0 state)) 40))
                      (format nil "~%") "")))))))

(defun xd (data lmbd r)
  (nth 2 (reduce lmbd
                 (loop for line in data collect
                       (run-op (str:split " " line)))
                 :initial-value (list 1 1 r))))

(defun day-main ()
  (format t "p1=~a~%" (xd (input-lines *aoc-day*) #'sig-str 0))
  (format t "p2=~a~%" (xd (input-lines *aoc-day*) #'display (format nil "~%"))))
