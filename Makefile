PREFIX = /usr/local

syn: syn.sh syn.awk syn.tsv
	cat syn.sh > $@
	echo 'exit 0' >> $@
	echo '#EOF' >> $@
	tar czf - syn.awk syn.tsv >> $@
	chmod +x $@

test: syn.sh
	shellcheck -s sh syn.sh

clean:
	rm -f syn

install: syn
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f syn $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/syn

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/syn

.PHONY: test clean install uninstall
