;	§Guideline 1: 
;	    1. savings_account(inadequate) Þ investment(savings).
;	
;	§Guideline 2:                                                              
;	    2. savings_account(adequate) Ù income(adequate)  Þ investment(stocks).                                                
;	    
;	§Guideline 3:
;	   3. savings_account(adequate) Ù income(inadequate)  Þ investment(combination).
;	
;	§Guideline 4:   
;	  
;	   4. amount_saved(X) Ù  (dependents(Y) Ù greater(X,minsavings(Y))) 
;	       Þ savings_account(adequate).   
;	   5. amount_saved(X) Ù (dependents(Y) Ù Ø greater(X, minsavings(Y))) 
;	      Þ savings_account(inadequate). 
;	 
;	   where  minsavings(X) = 5000 * X
;	
;	§Guideline 5:   
;	    6. earnings(X, steady) Ù (dependents(Y) Ù greater(X, minincome(Y)))  
;	      Þ income(adequate).  
;	  
;	    7. earnings(X, steady) Ù (dependents(Y) Ù Ø greater(X, minincome(Y)))  
;	       Þ income(inadequate).
;	     8. earnings(X, unsteady) Þ income(inadequate). 
;	     where  minincome(X) = 15000 + (4000 * X)  


;minincome(Y)
;(+ 15000 (* 4000 ?y))

; greater(X, minincome(Y))
; (dependents ?y&: (>= ?x (+ 15000 (* 4000 ?y))))

clear
reset


(deffunction incomead (?x, ?y)
           (printout t "현재 연수입은 " ?x "이고" crlf)
           (printout t "부양가족 " ?y "명을 부양하기위해 필요로 하는 수입의" crlf)
           (printout t "충분여부를 판단하는 기준은 " (+ 15000 (* 4000 ?y)) 
                    "이므로" crlf)
           (printout t "수입은 충분한 것으로 판단 됩니다." crlf crlf))

(deffunction incomeinad (?x, ?y)
           (printout t "현재 연수입은 " ?x "이고" crlf)
           (printout t "부양가족 " ?y "명을 부양하기위해 필요로 하는 수입의" crlf)
           (printout t "충분여부를 판단하는 기준은 " (+ 15000 (* 4000 ?y)) 
                    "이므로" crlf)
           (printout t "수입은 불충분한 것으로 판단 됩니다." crlf crlf))
		   
(deffunction incomeinad_unsteady (?x)
           (printout t "현재 연수입은 " ?x "이지만" crlf)
           (printout t "현재 수입이 불안정 하므로" crlf)
           (printout t "수입은 불충분한 것으로 판단 됩니다." crlf crlf))


;	   5. amount_saved(X) Ù (dependents(Y) Ù Ø greater(X, minsavings(Y))) 
;	      Þ savings_account(inadequate).		   






;	    6. earnings(X, steady) Ù (dependents(Y) Ù greater(X, minincome(Y)))  
;	      Þ income(adequate). 

(defrule R6
          (earnings ?x steady)
		  ;
          (dependents ?y&: (>= ?x (+ 15000 (* 4000 ?y)))) 		; greater(X, minincome(Y))
          =>
         (incomead ?x ?y)
         (assert (income adequate)))
		 
		 
;	    7. earnings(X, steady) Ù (dependents(Y) Ù Ø greater(X, minincome(Y)))  
;	       Þ income(inadequate).

(defrule R7
          (earnings ?x steady)
		  ;
          (dependents ?y&: (< ?x (+ 15000 (* 4000 ?y)))) 		; greater(X, minincome(Y))
          =>
         (incomeinad ?x ?y)
         (assert (income inadequate)))

;	     8. earnings(X, unsteady) Þ income(inadequate). 
;	     where  minincome(X) = 15000 + (4000 * X) 
		 
(defrule R8
          (earnings ?x unsteady)
          =>
         (incomeinad_unsteady ?x)
         (assert (income inadequate)))


; test
(printout t "Hello, world!" crlf)
(printout t "Hello, world!2" crlf)
