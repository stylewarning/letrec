;;;; letrec.asd
;;;; Author: Robert Smith -- 2012

(asdf:defsystem #:letrec
  :serial t
  :description "A simple alternative to Scheme's LETREC."
  :author "Robert Smith <quad@symbo1ics.com>"
  :license "Public Domain"
  :components ((:file "package")
               (:file "letrec")))

