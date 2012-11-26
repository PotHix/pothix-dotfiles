SHELL:=/bin/bash
CURRENT_PATH=`pwd`

update:
		for i in `ls bundles`; do pushd bundles/$i; git pull origin master; popd; done

install:
		git submodule init
		git submodule update

		if test -d $(HOME)/.vim; then \
		  rm -rf $(HOME)/.vim; \
		fi

		# Linking
		ln -sf $(CURRENT_PATH)/.vimrc $(HOME)/.vimrc
		ln -sf $(CURRENT_PATH) $(HOME)/.vim

		@echo "Vim sucessfully installed"
