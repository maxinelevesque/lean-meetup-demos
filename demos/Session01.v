(** * Session01: Warm-up with Programming Language Foundations

    Scratch file for the SF working group. It imports the [Equiv]
    chapter of Software Foundations Volume 2 (PLF), so everything from
    [Maps], [Imp], and [Equiv] is in scope: Imp syntax ([<{ ... }>]),
    the big-step relation [st =[ c ]=> st'], and [aequiv]/[cequiv].

    Build the book first ([make plf] at the repo root), then step
    through this file in your editor. *)

From PLF Require Import Equiv.
From Stdlib Require Import Lia.

(** Sanity check: Imp programs parse and evaluate. *)
Example plus2_from_zero :
  empty_st =[ X := X + 2 ]=> (X !-> 2).
Proof.
  apply E_Asgn. reflexivity.
Qed.

(** A worked example: an arithmetic equivalence that holds in
    every state. *)
Example times_one :
  aequiv <{ X * 1 }> <{ X }>.
Proof.
  intros st. simpl. lia.
Qed.

(** A worked command equivalence (the book's [skip_right] exercise).
    The pattern is the same as the book's [skip_left]: unfold
    [cequiv], split the iff, and invert the evaluation derivations. *)
Theorem skip_right' : forall c,
  cequiv <{ c; skip }> c.
Proof.
  intros c st st'. split; intros H.
  - (* -> *)
    inversion H; subst.
    inversion H5; subst.
    assumption.
  - (* <- *)
    apply E_Seq with st'.
    + assumption.
    + apply E_Skip.
Qed.

(** ** For the group *)

(** Sequencing is associative (the book's [seq_assoc]). *)
Theorem seq_assoc' : forall c1 c2 c3,
  cequiv <{ (c1; c2); c3 }> <{ c1; (c2; c3) }>.
Proof.
  (* FILL IN HERE *) Admitted.

(** An [if] whose branches are identical is the same as either
    branch. *)
Theorem if_same : forall b c,
  cequiv <{ if b then c else c end }> c.
Proof.
  (* FILL IN HERE *) Admitted.
