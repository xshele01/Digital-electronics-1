# Lab 2 Theory

## Truth table

*Digital* or *Binary comparator* compares the digital signals A, B presented at input terminal and produce outputs depending upon the condition of those inputs.

*Magnitude comparator* is a combinational circuit that compares two numbers, A and B, and determines their relative magnitudes. The outcome of comparison is specifed by three binary variables that indicate whether *B > A* or *B < A*.

## Canonical SoP and PoS forms of functions

A logic function can be uniquely described by its truth table, or in one of the Boolean expression canonical forms: **Sum of the Products** (SoP) or **Product of the Sums** (PoS). The canonical SoP form is obtained from its truth table by taking the sum (OR) of the minterm of the rows where a 1 appears in the output.

A **minterm** is a product (AND) term containing all input variables of the function in either true or complemented form. A variable appears in complemented form if it is a 0 in the column of the truth-table, and as a true form if it appears as a 1.

The canonical product of the sums form is obtained from its truth table by taking the product (AND) of the Maxterms of the rows where a 0 appears in the output.

A **Maxterm** is a sum (OR) term containing all input variables of the function in either true or complemented form. A variable appears in complemented form if it is a 1 in the column of the truth-table, and as a true form if it appears as a 0.

## Karnaugh Maps

*Karnaugh Maps* (*K-maps*) offer a graphical method of reducing a digital circuit to its minimum number of gates. The map is a simple table containing 1s and 0s that can express a truth table or complex Boolean expression describing the operation of a digital circuit.