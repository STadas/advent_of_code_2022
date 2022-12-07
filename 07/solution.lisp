(defvar *size-sum* 0)
(defvar *dir-stack* (list))
(defvar *dir-map* (make-hash-table :test 'equal))
(defun handle-command (command output)
  (if (string= (nth 0 command) "cd")
    (if (string= (nth 1 command) "..")
      (pop *dir-stack*)
      (if (string= (nth 1 command) "/")
        (setf *dir-stack* '("/"))
        (push (nth 1 command) *dir-stack*))))
  (if (string= (nth 0 command) "ls")
    (setf (gethash (format nil "~{~a/~}" (reverse *dir-stack*))
                   *dir-map*) output)))

(defun dir-size (dir)
  (sum (loop for item in (gethash dir *dir-map*)
             collect
             (if (str:starts-with-p "dir" item)
               (let* ((dirname (concatenate 'string dir (nth 1 (str:split " " item)) "/"))
                      (dsize (dir-size dirname)))
                 (if (<= dsize 100000) (incf *size-sum* dsize))
                 dsize)
               (parse-integer (nth 0 (str:split " " item)))))))

(defun p1 (data)
  (loop for line in data
        for i from 1
        when (equal (nth 0 (str:split " " line)) "$")
        collect
        (handle-command (subseq (str:split " " line) 1)
                        (subseq data i (position-if
                                         (lambda (s) (str:starts-with-p "$" s))
                                         data :start i))))
  (dir-size "//")
  *size-sum*)

(defun p2 (data)
  (min-in-list
    (remove-if
      (lambda (size)
        (< size (- 30000000 (- 70000000 (dir-size "//")))))
      (loop for key being the hash-keys of *dir-map*
            collect (dir-size key)))))


(defun day-main ()
  (format t "p1=~a~%" (p1 (input-lines *aoc-day*)))
  (format t "p2=~a~%" (p2 (input-lines *aoc-day*))))
