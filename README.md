
<img width="862" height="507" alt="RISCV-EC-v1 0" src="https://github.com/user-attachments/assets/5183dcd6-32d4-4fb0-a4b5-6f257f3d20bf" />


# RISCV-EC-v1.0
The first Ecuadorian open-source RISC-V soft processor for Edge Computing applications.  
This version corresponds to the architecture and performance analysis presented in the 2025 publication:  
**“Evaluating the RISCV-EC: A Comparative Analysis of Instruction Efficiency and Power Performance for Edge Computing.”**

---

## 🧩 Overview
**RISCV-EC-v1.0** is a soft processor based on a **5-stage, multi-cycle, non-pipelined architecture** implemented in **VHDL** for FPGA devices.  
It executes each instruction in its entirety before proceeding to the next, focusing on **instruction efficiency**, **execution speed**, and **power-performance balance** for **edge computing** environments.

The processor is implemented and validated on a **Xilinx Zynq-7000 SoC FPGA**, maintaining clock parity with reference processors to ensure unbiased benchmarking.

---

## ⚙️ Microarchitecture
RISCV-EC follows the standard **RISC-V single-core ISA** and includes the following stages:

1. **Instruction Fetch (IF)** – Fetches instructions from 32-word ROM.  
2. **Instruction Decode (ID)** – Decodes opcode and operands; handles register and immediate values.  
3. **Execute (EX)** – Performs arithmetic and logical operations using the ALU.  
4. **Memory Access (MEM)** – Reads/writes data to the 256-word data memory.  
5. **Write Back (WB)** – Stores computed results into registers.

### Key Components
- **ALU:** Performs arithmetic and comparison operations (4-bit control).  
- **Register File:** 32 general-purpose registers (32-bit).  
- **Control Unit:** Handles instruction decoding and signal generation.  
- **Multiplexers:** Manage data flow between immediate values, registers, and memory.

---

## 📊 Performance Evaluation
Three benchmark algorithms were used to compare RISCV-EC with other processors:
- **Fibonacci Sequence**
- **Matrix Multiplication**
- **RGB to HSL Conversion**

### Compared Architectures and Clock Frequencies
| Processor | Architecture | Clock | Platform |
|------------|---------------|--------|------------|
| **RISCV-EC** | RISC-V 32-bit | 50 MHz | Zynq-7000 SoC FPGA |
| **ATmega328P** | 8-bit AVR | 16 MHz | Arduino Uno |
| **ARM Cortex-M0+** | 32-bit ARM | 125 MHz | Raspberry Pi Pico |
| **ARM Cortex-A9** | 32-bit ARM | 650 MHz | Zynq-7000 SoC |

### Main Findings
- RISCV-EC demonstrates **fewer executed instructions** compared to the AVR and ARM Cortex-M0+.  
- It achieves **better instruction efficiency** in serial algorithms such as Fibonacci and matrix multiplication.  
- **Dynamic power consumption:** ~2.0 mW (FPGA, 50 MHz).  
- **Logic utilization:** <4% LUTs on Zynq-7000, suitable for low-resource FPGAs.  
- Although non-pipelined, RISCV-EC achieves a **balanced trade-off between performance and energy efficiency**.

---

## 🧠 Future Work
Planned improvements include:
- **Parallelization of J-type instructions**  
- **Fabrication on TSMC 65 nm technology**  
- **Dedicated PCB development for real-world testing**  
- **Integration with TinyML workloads** to evaluate edge AI efficiency  

---

## 🧪 Repository
All VHDL source code, algorithms, and test benches are available in this repository.  
Implementation and simulation scripts are compatible with **Xilinx Vivado**.

> Full design schematics and architecture diagrams can be found in the publication and associated supplementary materials.

---

## 🧾 Citation
If you use this repository or reference its contents, please cite the following publications:

- **2025 Publication:**  
[  > Asanza, V., Montesdeoca, G., Estrada, R., Mayorca-Torres, D., Safhi, M.H., & Peluffo-Ordóñez, D.H. (2025).  
  > *Evaluating the RISCV-EC: A Comparative Analysis of Instruction Efficiency and Power Performance for Edge Computing.*  
  > SN Computer Science, 6(769). https://doi.org/10.1007/s42979-025-04309-2 ](https://link.springer.com/article/10.1007/s42979-025-04309-2) 

- **2023 Publication:**  
[  > Montesdeoca, G., Asanza, V., Estrada, R., Valeriano, I., & Muneeb, M.A. (2023).  
  > *Softprocessor RISCV-EC for Edge Computing Applications.*  
  > In: Barolli, L. (ed.) Innovative Mobile and Internet Services in Ubiquitous Computing (IMIS 2023).  
  > Lecture Notes on Data Engineering and Communications Technologies, vol. 177. Springer, Cham.  
  > https://doi.org/10.1007/978-3-031-35836-4_23  ](https://link.springer.com/chapter/10.1007/978-3-031-35836-4_23)

---

## 🧑‍💻 Authors
- **Víctor Asanza** — SDAS Research Group  
- **Guillermo Montesdeoca** — ESPOL, Ecuador  
- **Rebeca Estrada** — ESPOL, Ecuador  
- **Dagoberto Mayorca-Torres** — Universidad Mariana, Colombia  
- **Moad Hicham Safhi** — Hassan II University, Morocco  
- **Diego H. Peluffo-Ordóñez** — Mohammed VI Polytechnic University, Morocco  

---

## 📚 Keywords
`RISC-V` · `Soft Processor` · `FPGA Implementation` · `Edge Computing` · `Low Power` · `Open Hardware`

---

© 2025 RISCV-EC Project – Open-source release under MIT License.
