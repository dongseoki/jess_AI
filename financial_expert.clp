;	��Guideline 1: 
;	    1. savings_account(inadequate) �� investment(savings).
;	
;	��Guideline 2:                                                              
;	    2. savings_account(adequate) U income(adequate)  �� investment(stocks).                                                
;	    
;	��Guideline 3:
;	   3. savings_account(adequate) U income(inadequate)  �� investment(combination).
;	
;	��Guideline 4:   
;	  
;	   4. amount_saved(X) U  (dependents(Y) U greater(X,minsavings(Y))) 
;	       �� savings_account(adequate).   
;	   5. amount_saved(X) U (dependents(Y) U �� greater(X, minsavings(Y))) 
;	      �� savings_account(inadequate). 
;	 
;	   where  minsavings(X) = 5000 * X
;	
;	��Guideline 5:   
;	    6. earnings(X, steady) U (dependents(Y) U greater(X, minincome(Y)))  
;	      �� income(adequate).  
;	  
;	    7. earnings(X, steady) U (dependents(Y) U �� greater(X, minincome(Y)))  
;	       �� income(inadequate).
;	     8. earnings(X, unsteady) �� income(inadequate). 
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
           (printout t "����� ������� �����Ƿ�" crlf)
           (printout t "���ݿ� �����Ͻʽÿ�." crlf crlf))

(deffunction investment_stocks ()
           (printout t "����� ����ϰ�" crlf)
           (printout t "���� ������ ��� �ϹǷ�" crlf)
           (printout t "�ֽĿ� �����Ͻʽÿ�." crlf crlf))

(deffunction investment_combination ()
           (printout t "����� ����ϰ�" crlf)
           (printout t "���� ������ ����� �ϹǷ�" crlf)
           (printout t "���ݰ� �ֽĿ� �ݹ� �����Ͻʽÿ�." crlf crlf))

(deffunction savings_account_ad (?x, ?y)
           (printout t "���� ��Ƶ� ����� " ?x "�̰�" crlf)
           (printout t "�ξ簡�� " ?y "���� �ξ��ϱ����� �ʿ�� �ϴ� �����" crlf)
           (printout t "��п��θ� �Ǵ��ϴ� ������ " (* 5000 ?y) 
                    "�̹Ƿ�" crlf)
           (printout t "����� ����� ������ �Ǵ� �˴ϴ�." crlf crlf))

(deffunction savings_account_inad (?x, ?y)
           (printout t "���� ��Ƶ� ����� " ?x "�̰�" crlf)
           (printout t "�ξ簡�� " ?y "���� �ξ��ϱ����� �ʿ�� �ϴ� �����" crlf)
           (printout t "��п��θ� �Ǵ��ϴ� ������ " (* 5000 ?y) 
                    "�̹Ƿ�" crlf)
           (printout t "����� ������� ������ �Ǵ� �˴ϴ�." crlf crlf))

(deffunction incomead (?x, ?y)
           (printout t "���� �������� " ?x "�̰�" crlf)
           (printout t "�ξ簡�� " ?y "���� �ξ��ϱ����� �ʿ�� �ϴ� ������" crlf)
           (printout t "��п��θ� �Ǵ��ϴ� ������ " (+ 15000 (* 4000 ?y)) 
                    "�̹Ƿ�" crlf)
           (printout t "������ ����� ������ �Ǵ� �˴ϴ�." crlf crlf))

(deffunction incomeinad (?x, ?y)
           (printout t "���� �������� " ?x "�̰�" crlf)
           (printout t "�ξ簡�� " ?y "���� �ξ��ϱ����� �ʿ�� �ϴ� ������" crlf)
           (printout t "��п��θ� �Ǵ��ϴ� ������ " (+ 15000 (* 4000 ?y)) 
                    "�̹Ƿ�" crlf)
           (printout t "������ ������� ������ �Ǵ� �˴ϴ�." crlf crlf))
		   
(deffunction incomeinad_unsteady (?x)
           (printout t "���� �������� " ?x "������" crlf)
           (printout t "���� ������ �Ҿ��� �ϹǷ�" crlf)
           (printout t "������ ������� ������ �Ǵ� �˴ϴ�." crlf crlf))

;	��Guideline 1: 
;	    1. savings_account(inadequate) �� investment(savings).
;	
                                                		   
(defrule R1
          (savings_account inadequate)
          =>
         (investment_savings)
         (assert (investment savings)));  actually, it doesn't need		   

;	��Guideline 2:                                                              
;	    2. savings_account(adequate) U income(adequate)  �� investment(stocks).

(defrule R2
          (savings_account adequate)
          (income adequate)
          =>
         (investment_stocks)
         (assert (investment stocks)));  actually, it doesn't need		   
		   
;	��Guideline 3:
;	   3. savings_account(adequate) U income(inadequate)  �� investment(combination).

(defrule R3
          (savings_account adequate)
          (income inadequate)
          =>
         (investment_combination)
         (assert (investment combination)));  actually, it doesn't need

		   
;	   4. amount_saved(X) U  (dependents(Y) U greater(X,minsavings(Y))) 
;	       �� savings_account(adequate).
		   
(defrule R4
          (amount_saved ?x)
          (dependents ?y&: (>= ?x (* 5000 ?y))) 		; greater(X, minsaving(Y))
          =>
         (savings_account_ad ?x ?y)
         (assert (savings_account adequate)))
		   

;	   5. amount_saved(X) U (dependents(Y) U �� greater(X, minsavings(Y))) 
;	      �� savings_account(inadequate).		   

(defrule R5
          (amount_saved ?x)
          (dependents ?y&: (< ?x (* 5000 ?y))) 		; not greater(X, minsaving(Y))
          =>
         (savings_account_inad ?x ?y)
         (assert (savings_account inadequate)))





;	    6. earnings(X, steady) U (dependents(Y) U greater(X, minincome(Y)))  
;	      �� income(adequate). 

(defrule R6
          (earnings ?x steady)
		  ;
          (dependents ?y&: (>= ?x (+ 15000 (* 4000 ?y)))) 		; greater(X, minincome(Y))
          =>
         (incomead ?x ?y)
         (assert (income adequate)))
		 
		 
;	    7. earnings(X, steady) U (dependents(Y) U �� greater(X, minincome(Y)))  
;	       �� income(inadequate).

(defrule R7
          (earnings ?x steady)
		  ;
          (dependents ?y&: (< ?x (+ 15000 (* 4000 ?y)))) 		; not greater(X, minincome(Y))
          =>
         (incomeinad ?x ?y)
         (assert (income inadequate)))

;	     8. earnings(X, unsteady) �� income(inadequate). 
;	     where  minincome(X) = 15000 + (4000 * X) 
		 
(defrule R8
          (earnings ?x unsteady)
          =>
         (incomeinad_unsteady ?x)
         (assert (income inadequate)))


; test
;(printout t "Hello, world!" crlf)
;(printout t "Hello, world!2" crlf)
