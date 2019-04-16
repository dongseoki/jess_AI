;	§Guideline 1: 
;	    1. savings_account(inadequate) Þ investment(savings).
;	
;	§Guideline 2:                                                              
;	    2. savings_account(adequate) U income(adequate)  Þ investment(stocks).                                                
;	    
;	§Guideline 3:
;	   3. savings_account(adequate) U income(inadequate)  Þ investment(combination).
;	
;	§Guideline 4:   
;	  
;	   4. amount_saved(X) U  (dependents(Y) U greater(X,minsavings(Y))) 
;	       Þ savings_account(adequate).   
;	   5. amount_saved(X) U (dependents(Y) U Ø greater(X, minsavings(Y))) 
;	      Þ savings_account(inadequate). 
;	 
;	   where  minsavings(X) = 5000 * X
;	
;	§Guideline 5:   
;	    6. earnings(X, steady) U (dependents(Y) U greater(X, minincome(Y)))  
;	      Þ income(adequate).  
;	  
;	    7. earnings(X, steady) U (dependents(Y) U Ø greater(X, minincome(Y)))  
;	       Þ income(inadequate).
;	     8. earnings(X, unsteady) Þ income(inadequate). 
;	     where  minincome(X) = 15000 + (4000 * X)  


;mimincome(X) = 15000 + 4000 * X
;minincome(Y)
;(+ 15000 (* 4000 ?y))

;minsavings(X) = 5000 * X
;minsaving(Y)
;(* 5000 ?y)

; greater(X, minincome(Y))
; (dependents ?y&: (>= ?x (+ 15000 (* 4000 ?y))))

(clear)
(reset)

(deffunction investment_savings ()
           (printout t "재산이 충분하지 않으므로" crlf)
           (printout t "저금에 투자하십시오." crlf crlf))

(deffunction investment_stocks ()
           (printout t "재산이 충분하고" crlf)
           (printout t "현재 수입이 충분 하므로" crlf)
           (printout t "주식에 투자하십시오." crlf crlf))

(deffunction investment_combination ()
           (printout t "재산이 충분하고" crlf)
           (printout t "현재 수입이 불충분 하므로" crlf)
           (printout t "저금과 주식에 반반 투자하십시오." crlf crlf))

(deffunction savings_account_ad (?x, ?y)
           (printout t "현재 모아둔 재산은 " ?x "이고" crlf)
           (printout t "부양가족 " ?y "명을 부양하기위해 필요로 하는 재산의" crlf)
           (printout t "충분여부를 판단하는 기준은 " (* 5000 ?y) 
                    "이므로" crlf)
           (printout t "재산은 충분한 것으로 판단 됩니다." crlf crlf))

(deffunction savings_account_inad (?x, ?y)
           (printout t "현재 모아둔 재산은 " ?x "이고" crlf)
           (printout t "부양가족 " ?y "명을 부양하기위해 필요로 하는 재산의" crlf)
           (printout t "충분여부를 판단하는 기준은 " (* 5000 ?y) 
                    "이므로" crlf)
           (printout t "재산은 불충분한 것으로 판단 됩니다." crlf crlf))

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

;	§Guideline 1: 
;	    1. savings_account(inadequate) Þ investment(savings).
;	
                                                		   
(defrule R1
          (savings_account inadequate)
          =>
         (investment_savings)
         (assert (investment savings)));  actually, it doesn't need		   

;	§Guideline 2:                                                              
;	    2. savings_account(adequate) U income(adequate)  Þ investment(stocks).

(defrule R2
          (savings_account adequate)
          (income adequate)
          =>
         (investment_stocks)
         (assert (investment stocks)));  actually, it doesn't need		   
		   
;	§Guideline 3:
;	   3. savings_account(adequate) U income(inadequate)  Þ investment(combination).

(defrule R3
          (savings_account adequate)
          (income inadequate)
          =>
         (investment_combination)
         (assert (investment combination)));  actually, it doesn't need

		   
;	   4. amount_saved(X) U  (dependents(Y) U greater(X,minsavings(Y))) 
;	       Þ savings_account(adequate).
		   
(defrule R4
          (amount_saved ?x)
          (dependents ?y&: (>= ?x (* 5000 ?y))) 		; greater(X, minsaving(Y))
          =>
         (savings_account_ad ?x ?y)
         (assert (savings_account adequate)))
		   

;	   5. amount_saved(X) U (dependents(Y) U Ø greater(X, minsavings(Y))) 
;	      Þ savings_account(inadequate).		   

(defrule R5
          (amount_saved ?x)
          (dependents ?y&: (< ?x (* 5000 ?y))) 		; not greater(X, minsaving(Y))
          =>
         (savings_account_inad ?x ?y)
         (assert (savings_account inadequate)))





;	    6. earnings(X, steady) U (dependents(Y) U greater(X, minincome(Y)))  
;	      Þ income(adequate). 

(defrule R6
          (earnings ?x steady)
		  ;
          (dependents ?y&: (>= ?x (+ 15000 (* 4000 ?y)))) 		; greater(X, minincome(Y))
          =>
         (incomead ?x ?y)
         (assert (income adequate)))
		 
		 
;	    7. earnings(X, steady) U (dependents(Y) U Ø greater(X, minincome(Y)))  
;	       Þ income(inadequate).

(defrule R7
          (earnings ?x steady)
		  ;
          (dependents ?y&: (< ?x (+ 15000 (* 4000 ?y)))) 		; not greater(X, minincome(Y))
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
;(printout t "Hello, world!" crlf)
;(printout t "Hello, world!2" crlf)
