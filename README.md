# Universal Code Converter using Verilog HDL

A 4-bit universal code converter implemented in Verilog HDL. The design is simulated on EDA Playground and includes a testbench, waveform output, and a synthesized logic diagram.

## EDA Playground

Run the project here: https://edaplayground.com/x/QNz8

## Supported conversions

| `sel` | Conversion |
|---|---|
| `000` | Binary to Gray |
| `001` | Gray to Binary |
| `010` | Binary to Excess-3 |
| `011` | Excess-3 to Binary |
| `100` | Binary to 2-digit packed BCD |
| `101` | BCD to Binary |
| `110`, `111` | Unused modes (default output `00000000`) |

Invalid Excess-3 and BCD inputs produce `11111111`.

## Files

- `design.sv` — Verilog module implementing the code conversions.
- `testbench.sv` — testbench covering all conversion modes and selected invalid inputs.
- `screenshots/` — screenshots of the EDA Playground source, simulation output, EPWave waveform, and synthesized circuit.

## Tools used

- Verilog HDL
- EDA Playground
- Icarus Verilog
- EPWave
- Yosys

## Run locally

With Icarus Verilog installed, compile and run:

```bash
iverilog -g2012 -o converter_sim design.sv testbench.sv
vvp converter_sim
```

The testbench writes a `dump.vcd` waveform file. Open it with GTKWave or another VCD viewer.

## Example test cases

| Mode | Input | Expected output | Description |
|---|---|---|---|
| `000` | `1010` | `00001111` | Binary to Gray |
| `001` | `1111` | `00001010` | Gray to Binary |
| `010` | `0101` | `00001000` | Binary to Excess-3 |
| `011` | `1000` | `00000101` | Excess-3 to Binary |
| `100` | `1101` | `00010011` | Binary to packed BCD |
| `101` | `1001` | `00001001` | BCD to Binary |

## Screenshots

Add the provided screenshots to the `screenshots/` folder. Suggested filenames:

- `01-epwave-waveform.png`
- `02-eda-playground-code-and-simulation.png`
- `03-simulation-output.png`
- `04-synthesized-circuit-diagram.png`
- `05-verilog-design-and-testbench.png`
- `06-synthesis-log.png`
