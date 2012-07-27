;;;; letrec.asd
;;;; Copyright (c) 2012 Robert Smith

(asdf:defsystem #:letrec
  :serial t
  :description "A simple alternative to Scheme's LETREC."
  :author "Robert Smith <quad@symbo1ics.com>"
  :license "Public Domain"
  :components ((:file "package")
               (:file "letrec")))

