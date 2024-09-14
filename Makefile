TESTS = additionneur_test bascule_d_test reg_a_test reg_b_test reg_m_test

DEPENDENCIES_additionneur_test=additionneur_unitaire.vhd additionneur.vhd additionneur_test.vhd
DEPENDENCIES_bascule_d_test=bascule_d.vhd bascule_d_test.vhd
DEPENDENCIES_reg_a_test=bascule_d.vhd reg_a.vhd reg_a_test.vhd
DEPENDENCIES_reg_b_test=bascule_d.vhd reg_b.vhd reg_b_test.vhd
DEPENDENCIES_reg_m_test=bascule_d.vhd reg_m.vhd reg_m_test.vhd

GHDLFLAGS= --std=08 --workdir=work

all: $(TESTS)

define test_template =
$(1): $$(DEPENDENCIES_$(1)) 
	mkdir -p work
	$$(foreach file,$$(DEPENDENCIES_$(1)),ghdl -a $(GHDLFLAGS) --workdir=work $$(file);)
	ghdl -e $(GHDLFLAGS) $(1)
endef

$(foreach test,$(TESTS),$(eval $(call test_template,$(test))))

test: $(TESTS)
	@for test in $(TESTS); do \
		ghdl -r $(GHDLFLAGS) $$test; \
		done

%.ghw: %
	./$< --wave=$@

%.vcd: %
	./$< --vcd=$@

vcd: $(addsuffix .ghw, $(TESTS)) 

ghw: $(addsuffix .vcd, $(TESTS))

clean:
	$(foreach TEST, $(TESTS), rm -f $(addprefix work/, $(DEPENDENCIES_$(TEST):.vhd=.o));)
	rm -f $(TESTS)
	rm -f $(addsuffix .vcd, $(TESTS))
	rm -f $(addsuffix .ghw, $(TESTS))
	rm -f $(addprefix e~, $(addsuffix .o, $(TESTS)))

