# Run Path of Building (PoE2) on Linux via Wine.
# The repo ships the Windows runtime (runtime/*.exe + DLLs); running it from
# the repo checkout automatically enables Dev Mode (see CONTRIBUTING.md).

WINE        ?= wine
WINEPREFIX  ?= $(HOME)/.local/share/wineprefixes/pob-poe2
WINEDEBUG   ?= -all
EXE         := runtime/Path{space}of{space}Building-PoE2.exe

export WINEPREFIX WINEDEBUG

.PHONY: run prefix kill clean-prefix

run: $(WINEPREFIX)/system.reg
	$(WINE) "$(EXE)"

# Create the dedicated Wine prefix on first run.
$(WINEPREFIX)/system.reg:
	@command -v $(WINE) >/dev/null || { echo "wine not found: install it (e.g. 'pacman -S wine')"; exit 1; }
	mkdir -p "$(WINEPREFIX)"
	wineboot -i

prefix: $(WINEPREFIX)/system.reg

# Force-stop PoB (and everything else in its Wine prefix).
kill:
	wineserver -k

clean-prefix:
	rm -rf "$(WINEPREFIX)"
