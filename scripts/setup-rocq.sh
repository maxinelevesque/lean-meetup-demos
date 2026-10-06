#!/usr/bin/env bash
# Install the Rocq Prover (the version Software Foundations is tested
# against) into an opam switch called "rocq".
#
# Usage: scripts/setup-rocq.sh
# Afterwards, in each new shell:  eval "$(opam env --switch=rocq)"
set -euo pipefail

ROCQ_VERSION="${ROCQ_VERSION:-9.0.0}"
SWITCH="${ROCQ_SWITCH:-rocq}"
export OPAMYES=1 OPAMROOTISOK=1

if ! command -v opam >/dev/null 2>&1; then
  if command -v apt-get >/dev/null 2>&1; then
    SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
    $SUDO apt-get update
    $SUDO env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      opam ocaml ocaml-findlib libgmp-dev pkg-config m4 rsync bubblewrap
  elif command -v brew >/dev/null 2>&1; then
    brew install opam gmp pkg-config
  else
    echo "Please install opam first: https://opam.ocaml.org/doc/Install.html" >&2
    exit 1
  fi
fi

[ -d "${OPAMROOT:-$HOME/.opam}" ] || opam init --bare -n --disable-sandboxing

if ! opam switch list --short | grep -qx "$SWITCH"; then
  # Use the system OCaml if there is one (much faster); otherwise build one.
  if command -v ocaml >/dev/null 2>&1; then
    opam switch create "$SWITCH" ocaml-system
  else
    opam switch create "$SWITCH" 4.14.2
  fi
fi
eval "$(opam env --switch="$SWITCH" --set-switch)"

opam repo list --short | grep -qx rocq-released \
  || opam repo add rocq-released https://rocq-prover.org/opam/released
# The rocq-prover meta-package does not constrain its dependencies, so pin
# the actual components or opam will happily pick a newer Rocq.
for pkg in rocq-runtime rocq-core rocq-stdlib rocq-prover; do
  opam pin add -n "$pkg" "$ROCQ_VERSION"
done
opam install -j"$(nproc 2>/dev/null || echo 2)" rocq-prover

echo
rocq --version
echo
echo "Done. In new shells run:  eval \"\$(opam env --switch=$SWITCH)\""
