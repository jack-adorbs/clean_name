#!/usr/bin/env racket
#lang racket

(define (no-space str)
  (string-join (string-split (string-trim (string-normalize-spaces str)) " ") "_"))

(define (dot-file? path)
  (char=? (string-ref (path->string path) 0) #\.))

(define paths-to-change
  (filter (λ (x) (not (string=? (no-space (path->string x)) (path->string x))))
          (filter (λ (x) (not (dot-file? x))) (directory-list))))

(define (clean-names)
  (for ([i paths-to-change])
    (rename-file-or-directory i (no-space (path->string i)))))

(clean-names)
