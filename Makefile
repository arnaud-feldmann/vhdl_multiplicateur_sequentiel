TESTS=additionneur_test bascule_d_test reg_a_test reg_b_test reg_m_test uc_test

DEPENDENCIES_additionneur_test=additionneur_unitaire.vhd additionneur.vhd additionneur_test.vhd
DEPENDENCIES_bascule_d_test=bascule_d.vhd bascule_d_test.vhd
DEPENDENCIES_reg_a_test=bascule_d.vhd reg_a.vhd reg_a_test.vhd
DEPENDENCIES_reg_b_test=bascule_d.vhd reg_b.vhd reg_b_test.vhd
DEPENDENCIES_reg_m_test=bascule_d.vhd reg_m.vhd reg_m_test.vhd
DEPENDENCIES_uc_test=uc.vhd uc_test.vhd

GHDLFLAGS= --std=08 --workdir=work

all: $(TESTS)

%.compiled: %.vhd
	mkdir -p work
	ghdl -a $(GHDLFLAGS) --workdir=work $<
	touch $@

define test_template =
$(1): $$(addsuffix .compiled, $$(basename $$(DEPENDENCIES_$(1))))
	ghdl -e $(GHDLFLAGS) $(1)
	$$(foreach file,$$(DEPENDENCIES_$(1)),touch $$(basename $$(file));)
endef

$(foreach test,$(TESTS),$(eval $(call test_template,$(test))))

test: $(TESTS)
	@for test in $(TESTS); do \
		echo -ne "$$test : " && \
		ghdl -r $(GHDLFLAGS) $$test; \
		done

%.ghw: %.compiled
	ghdl -r $(GHDLFLAGS) $(basename $<) --wave=$@

%.vcd: %.compiled
	ghdl -r $(GHDLFLAGS) $(basename $<) --vcd=$@

vcd: $(addsuffix .vcd, $(TESTS)) 

ghw: $(addsuffix .ghw, $(TESTS))

clean:
	ghdl --clean $(GHDLFLAGS) 2>/dev/null
	rm -rf work
	rm -f $(TESTS)
	rm -f $(addsuffix .vcd, $(TESTS))
	rm -f $(addsuffix .ghw, $(TESTS))
	rm -f $(foreach test,$(TESTS),$(addsuffix .compiled, $(basename $(DEPENDENCIES_$(test)))))

