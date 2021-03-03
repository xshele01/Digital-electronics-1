# Lab 1: Introduction to Git and VHDL

You can find my DE-1 repository [here](https://github.com/xshele01/Digital-electronics-1).

## 1. Verification of De Morgan's laws of function f(c,b,a)

My public EDA Playground example can be found [here](https://www.edaplayground.com/x/Z5Sb).

Using De Morgan's laws I modified the following logic function to the form with NAND and NOR gates only:

![De Morgan's laws](Images/equations.png) 

Listing of VHDL architecture from design file `design.vhd`:

```vhdl
architecture dataflow of gates is
begin
    f_o <= (not b_i and a_i) or (not c_i and not b_i);
    fnand_o <= (not b_i nand a_i) nand (not c_i nand not b_i);
    fnor_o <= b_i nor (a_i nor not c_i);
end architecture dataflow;
```

Screenshot with simulated time waveforms:

![Screenshot with simulated time waveforms](Images/screenshot_de_morgans_laws.png) 

You can see the results in the folowing table:

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

## 2. Verification of Distributive laws

My public EDA Playground example can be found [here](https://www.edaplayground.com/x/AKjK).

In EDA Playground, I verified Distributive laws:

![Distributive laws](Images/distributives.png)

Listing of VHDL architecture from design file `design.vhd`:

```vhdl
architecture dataflow of gates is
begin
    f_o1 <= (a_i and b_i) or (a_i and c_i);
    f_o2 <= (a_i or b_i) and (a_i or c_i);
    f_distr_o1 <= a_i and (b_i or c_i);
    f_distr_o2 <= a_i or (b_i and c_i);
end architecture dataflow;
```

Screenshot with simulated time waveforms:

![Screenshot with simulated time waveforms](Images/screenshot_distributive_laws.png)