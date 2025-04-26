# AXI_to_APB_Bridge

This project implements an **AXI4-Lite to APB3 Bridge** in Verilog. It acts as a protocol converter, enabling communication between an AXI master and APB-compliant peripherals. This bridge is commonly used in SoC designs to connect high-performance AXI components with simpler, low-power APB devices.

---

## Protocol Descriptions

### AXI (Advanced eXtensible Interface) – AXI4-Lite

AXI is part of ARM’s AMBA (Advanced Microcontroller Bus Architecture) family. The **AXI4-Lite** protocol is a lightweight version of AXI4, suitable for simple, low-bandwidth control register interfaces.

**Key Features:**

- Separate read and write channels
- No burst support (single beat transfers only)
- Fully handshaked using `VALID` and `READY` signals
- Pipelined structure allows multiple outstanding transactions
- Response signals (`BRESP`, `RRESP`) for error reporting

![Screenshot 2025-04-26 103544](https://github.com/user-attachments/assets/d18ae498-3a00-4607-b58b-9dfd95673cf1)

---

### APB (Advanced Peripheral Bus) – APB3

APB is also part of the AMBA family. It is a simple, low-power bus protocol optimized for **connecting peripheral devices** like timers, UARTs, and GPIOs.

**Key Features:**

- Simple read/write operation (non-pipelined)
- Low power and area-efficient
- Supports only one transfer at a time
- No burst transfers, no out-of-order transactions
- Single clock edge operation

![Screenshot 2025-04-26 103555](https://github.com/user-attachments/assets/78bb05f5-e232-4b49-812f-9c2354ba2fb3)

---

Together, AXI and APB are often used in SoC designs where a high-performance AXI bus is used to communicate with a protocol bridge, which then interfaces with low-speed peripherals using APB.

### AXI to APB Bridge

The **AXI to APB Bridge** serves as a **protocol converter** between an AXI4-Lite master and an APB3 peripheral. This bridge is essential in System-on-Chip (SoC) designs where high-performance AXI components need to interface with low-power, low-complexity APB peripherals.

# Schematic

![Screenshot 2025-04-26 102746](https://github.com/user-attachments/assets/189a6dd2-9c2c-4b6e-9d02-d3d1b6d6bee9)

# Simulation Results

![Screenshot 2025-04-26 102820](https://github.com/user-attachments/assets/fd231acc-f7df-4630-bc78-c32f1042828a)

