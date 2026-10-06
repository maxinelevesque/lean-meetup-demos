# Top-level build for the SF working group.
#   make        build the PLF book, then the demos
#   make plf    build Software Foundations Vol. 2 (Programming Language Foundations)
#   make demos  check the files in demos/
#   make clean

PLF_DIR := software-foundations/plf
DEMOS   := $(wildcard demos/*.v)

all: demos

plf:
	$(MAKE) -C $(PLF_DIR)

demos: plf
	for f in $(DEMOS); do \
	  rocq compile -Q $(PLF_DIR) PLF -Q demos Demos $$f || exit 1; \
	done

clean:
	$(MAKE) -C $(PLF_DIR) clean
	rm -f demos/*.vo demos/*.vok demos/*.vos demos/*.glob demos/.*.aux

.PHONY: all plf demos clean
