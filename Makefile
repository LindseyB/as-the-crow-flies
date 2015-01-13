all: love

love:
	zip -9 -q -r as-the-crow-flies.love .
war:
	@echo "Error: no task for 'war' did you mean 'love'?"
release:
	love-release -ldmw -n as-the-crow-flies -r releases -v 0.9.0 --description="A game about a crow and the power of words" --homepage="https://github.com/LindseyB/as-the-crow-flies" --win-icon="/Users/lindseybieda/projects/as-the-crow-flies/assets/icon/icon.ico" --win-maintainer-name="Lindsey Bieda"--win-package-version="0.0.1" --osx-icon="/Users/lindseybieda/projects/as-the-crow-flies/assets/icon/icon.icns" --osx-maintainer-name="lindseybieda" --maintainer-email="lbieda@gmail.com" --deb-maintainer-name="lindseybieda" --deb-package-name="as-the-crow-flies" --deb-package-version="0.0.1" *.lua assets/*
