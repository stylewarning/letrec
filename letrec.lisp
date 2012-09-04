;;;; letrec.lisp
;;;; Author: Robert Smith -- 2012

(in-package #:letrec)

(defmacro letrec (bindings &body body)
  "A macro imitation of Scheme's LETREC. Bindings should be of the form

   (NAME FUNCTION-FORM)

where NAME is a symbol and FUNCTION-FORM is any function-producing form."
  (let ((args (gensym "ARGS-")))
    `(labels ,(loop :for (name fn) :in bindings
                    :do (assert (symbolp name)
                                (name)
                                "Bindings must have symbols for names. Given ~S in the binding ~S."
                                name
                                (list name fn))
                    :collect `(,name (&rest ,args) (apply ,fn ,args)))
       ,@body)))
