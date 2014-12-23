all:
	@echo " usage: make build|cleancover[-html]|deps|test"

build:
	@dzil build

clean:
	@dzil clean

cover-%:
	@dzil cover \
		-outputdir cover_db \
		-coverage statement,branch,condition,subroutine \
		-report $(subst cover-,,$@)

cover: cover-html

deps:
	@cpanm Dist::Zilla
	@dzil authordeps \
		| grep -v 'Bundle::GitFlow' \
		| xargs -n 5 -P 10 cpanm
	@dzil listdeps --author \
		| grep -vP '[^\w:]' \
		| cpanm

release:
	@dzil release

test:
	@dzil smoke --release --author

# vim:noet
