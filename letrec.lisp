;;;; letrec.lisp
;;;; Author: Robert Smith -- 2012

(in-package #:letrec)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun check-definitions (definitions)
    (dolist (definition definitions)
      (unless (and (listp definition)
                   (not (null definition))
                   (not (null (cdr definition)))
                   (symbolp (car definition)))
        (error "Invalid binding in LETREC definitions: ~S" definition)))))

(defmacro letrec ((&rest definitions) &body body)
  "A macro imitation of Scheme's LETREC. Bindings should be of the form

   (NAME FUNCTION-FORM)

where NAME is a symbol and FUNCTION-FORM is any function-producing form."
  (check-definitions definitions)
  (let ((gensyms (loop :for d in definitions :collect (gensym)))
        (names (mapcar #'car definitions))
        (fdefs (mapcar #'cadr definitions))
        (args (gensym "ARGS-")))
    (multiple-value-bind (body decls)
        (alexandria:parse-body body)
      `(let ,gensyms
         (flet ,(loop :for g :in gensyms
                      :for name :in names
                      :for fdef :in fdefs
                      :do (assert (symbolp name)
                                  (name)
                                  "Bindings must have symbols for names. Given ~S in the binding ~S."
                                  name
                                  (list name fdef))
                      :collect `(,name (&rest ,args) (apply ,g ,args)))
           ,(when decls
              `(declare ,@decls))
           (setf ,@(mapcan #'list gensyms fdefs))
           ,@body)))))

