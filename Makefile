go:
	@echo Testing with normal loop
	gcc test_tbljal.c tbljal.S -O -o test_tbljal && ./test_tbljal
	@echo
	@echo Testing with decbnez faked using jalr
	gcc test_tbljal.c tbljal.S -O -o test_tbljal -DTBL && ./test_tbljal
