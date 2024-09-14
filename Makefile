TESTS = additionneur_test bascule_d_test reg_a_test reg_b_test reg_m_test

all: $(TESTS)

%_test: *.vhd
	rm -rf work/*.o work/*.cf
	$(MAKE) -f Makefile.$@

test: $(TESTS)
	@for test in $(TESTS); do \
		./$$test; \
		done

%.ghw: %
	./$< --wave=$@

%.vcd: %
	./$< --vcd=$@

vcd: $(addsuffix .ghw, $(TESTS)) 

ghw: $(addsuffix .vcd, $(TESTS))

clean:
	rm -f work/*.o work/*.cf
	rm -f $(TESTS)
	rm -f $(addsuffix .vcd, $(TESTS))
	rm -f $(addsuffix .ghw, $(TESTS))
	rm -f $(addprefix e~, $(addsuffix .o, $(TESTS)))

