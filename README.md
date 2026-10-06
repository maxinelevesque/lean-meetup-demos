# lean-meetup-demos
Demos for the SF Lean meetup

## Software Foundations in Rocq

The working group is going through
[Software Foundations](https://softwarefoundations.cis.upenn.edu/), Volume 2:
**Programming Language Foundations** (PLF, the red "Volume 2" badge). Its proof
scripts are vendored in [`software-foundations/plf`](software-foundations/plf)
(MIT licensed; see the `LICENSE` there). The rendered HTML version is at
<https://softwarefoundations.cis.upenn.edu/plf-current/index.html>.

### Layout

| Path | What |
| --- | --- |
| `software-foundations/plf/` | The PLF `.v` files, unmodified, with the book's `Makefile` |
| `demos/Session01.v` | Warm-up file for the group: imports `PLF.Equiv`, a few worked proofs, a few open exercises |
| `scripts/setup-rocq.sh` | Installs Rocq 9.0.0 (the version the book is tested with) via opam |
| `scripts/fetch-sf.sh` | Re-downloads a volume's sources, e.g. `scripts/fetch-sf.sh lf` for Volume 1 |
| `_CoqProject` | Maps `software-foundations/plf` to `PLF` and `demos` to `Demos` for editors |

### Setup

```sh
scripts/setup-rocq.sh            # one-time; installs opam + Rocq 9.0.0 in switch "rocq"
eval "$(opam env --switch=rocq)" # in every new shell
make                             # builds PLF, then checks demos/
```

The first `make` compiles every chapter (a few minutes). Chapters import each
other (`From PLF Require Import Imp.`), so a chapter must be compiled before
anything that imports it can be stepped through in an editor. After you edit a
chapter, rerun `make plf`.

### Editors

Open the repository root so the editor picks up `_CoqProject`.

- **VS Code**: install the *VsRocq* extension, plus the language server with
  `opam install vsrocq-language-server` in the `rocq` switch.
- **Emacs**: [Proof General](https://proofgeneral.github.io/) (optionally with
  `company-coq`).
- **No install**: each chapter on the website has a "Try it in jsCoq" link that
  runs in the browser.

### Suggested path through PLF

`Maps` and `Imp` recap the end of Volume 1. Then:

1. `Equiv`: program equivalence (`demos/Session01.v` starts here)
2. `Hoare`, `Hoare2`, `HoareAsLogic`: Hoare logic
3. `Smallstep`, `Types`: small-step semantics and a first type system
4. `Stlc`, `StlcProp`, `MoreStlc`: the simply typed lambda calculus
5. Optional: `Sub`, `Typechecking`, `Records`, `References`, `RecordSub`,
   `Norm`, `PE`, and the `LibTactics`/`UseTactics`/`UseAuto` tactic chapters

Each chapter also has a `*Test.v` file that checks your exercise solutions
have the expected types.
