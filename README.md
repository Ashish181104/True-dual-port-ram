<div align="center">
  <img src="images/_banner.png" alt="Banner">
</div>

<div align="center">

  <img src="https://img.shields.io/badge/Language-Verilog-blue" alt="Verilog">
  <img src="https://img.shields.io/badge/Tool-Vivado-orange" alt="Vivado">
  <img src="https://img.shields.io/badge/Target-FPGA-green" alt="FPGA">
  <img src="https://img.shields.io/badge/Design-CDC_Safe-red" alt="CDC Safe">
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License">

</div>

<hr>

<h1>True Dual Port RAM</h1>

<p>
A Verilog HDL project focused on designing an industrial-style asynchronous
True Dual Port RAM subsystem for FPGA-based systems.
</p>

<p>
This project was built to understand how real-world memory architectures work
inside modern digital systems and FPGA designs. Along with the RAM itself,
the design also explores important concepts used in industry such as
Clock Domain Crossing (CDC), handshake-based communication,
collision handling, and BRAM-friendly RTL coding.
</p>

<hr>

<h2>About the Project</h2>

<p>
In many digital systems, multiple modules need to access memory at the same time.
A True Dual Port RAM allows two independent ports to read and write simultaneously,
making it useful for high-speed and parallel hardware systems.
</p>

<p>
This project models that behavior using modular Verilog RTL and follows
FPGA-oriented design practices compatible with Xilinx Vivado synthesis.
</p>

<p>
The design also introduces practical engineering concepts like:
</p>

<ul>
  <li>Independent clock domains</li>
  <li>Metastability handling</li>
  <li>Synchronizer circuits</li>
  <li>Collision detection</li>
  <li>Modular RTL hierarchy</li>
</ul>

<p>
The goal of this project is not only to build RAM,
but also to understand how industrial memory subsystems
are designed step by step.
</p>

<hr>

<h2>Features</h2>

<ul>
  <li>True Dual Port RAM architecture</li>
  <li>Independent read/write ports</li>
  <li>Asynchronous clock support</li>
  <li>CDC-safe synchronizers</li>
  <li>VALID/READY style interface</li>
  <li>Collision detection logic</li>
  <li>Vivado-compatible BRAM inference</li>
  <li>Modular Verilog design</li>
  <li>Simulation-ready testbench</li>
</ul>

<hr>

<h2>Concepts Covered</h2>

<p>This project helps in understanding:</p>

<ul>
  <li>Memory fundamentals</li>
  <li>Single-port vs dual-port RAM</li>
  <li>True dual-port RAM operation</li>
  <li>FPGA BRAM architecture</li>
  <li>Clock Domain Crossing (CDC)</li>
  <li>Metastability</li>
  <li>Two-flop synchronizers</li>
  <li>Industrial RTL design methodology</li>
  <li>Collision handling</li>
  <li>FPGA-friendly coding style</li>
</ul>

<hr>

<h2>Project Structure</h2>

<pre>
True_Dual_Port_RAM/
│
├── rtl/
│   ├── DP_ram_top.v
│   ├── axi_interface.v
│   ├── trueDP_ram.v
│   ├── collision_detector.v
│   └── cdc_synchronizer.v
│
├── tb/
│   └── tb_DP_ram_top.v
│
├── docs/
├── waveforms/
│
├── README.md
└── LICENSE
</pre>

<hr>

<h2>Module Description</h2>

<h3><code>DP_ram_top.v</code></h3>
<p>
Top-level module integrating all memory subsystem components together.
</p>

<h3><code>trueDP_ram.v</code></h3>
<p>
Core RAM module supporting simultaneous dual-port access.
</p>

<h3><code>axi_interface.v</code></h3>
<p>
Implements a simple VALID/READY style communication interface
inspired by industrial bus architectures.
</p>

<h3><code>collision_detector.v</code></h3>
<p>
Detects simultaneous access conflicts when both ports
target the same memory location.
</p>

<h3><code>cdc_synchronizer.v</code></h3>
<p>
Implements two-flop synchronizers for safer signal transfer
across clock domains.
</p>

<h3><code>tb_DP_ram_top.v</code></h3>
<p>
Behavioral testbench used for functional verification and simulation.
</p>

<hr>

<h2>Tools Used</h2>

<ul>
  <li>Verilog HDL</li>
  <li>Xilinx Vivado</li>
  <li>FPGA BRAM</li>
  <li>Behavioral Simulation</li>
</ul>

<hr>

<h2>RTL Architecture</h2>

<div align="center">
  <img src="images/rtl_design.png" alt="RTL Architecture">
</div>

<hr>

<h2>Simulation Waveform</h2>

<div align="center">
  <img src="images/sim.png" alt="Simulation Waveform">
</div>

<hr>

<h2>Collision Handling Policy</h2>

<p>
The subsystem includes collision detection logic to identify
simultaneous access conflicts during dual-port memory operation.
</p>

<p>
Current collision handling features include:
</p>

<ul>
  <li>Detection of same-address simultaneous access</li>
  <li>Monitoring of concurrent read/write conditions</li>
  <li>Collision indication during operation</li>
</ul>

<p>
The current implementation focuses on collision detection and reporting.
Future improvements may include:
</p>

<ul>
  <li>Write-first policy</li>
  <li>Read-first policy</li>
  <li>No-change policy</li>
  <li>Arbitration-based conflict resolution</li>
</ul>

<p>
This helps in understanding how industrial memory subsystems manage
concurrent memory accesses safely and predictably.
</p>

<hr>

<h2>What I Learned</h2>

<p>
While building this project, I explored:
</p>

<ul>
  <li>How FPGA memories are modeled in Verilog</li>
  <li>How asynchronous clock domains create challenges</li>
  <li>Why CDC handling is important</li>
  <li>How dual-port architectures improve parallelism</li>
  <li>How modular RTL design is used in industry</li>
</ul>

<p>
This project also helped me better understand how larger systems such as
FIFOs, AXI-based subsystems, and memory controllers are built internally.
</p>

<hr>

<h2>Future Improvements</h2>

<p>Some planned future additions are:</p>

<ul>
  <li>Asynchronous FIFO implementation</li>
  <li>AXI4 interface support</li>
  <li>Arbitration logic</li>
  <li>ECC (Error Correction Code)</li>
  <li>Built-In Self-Test (BIST)</li>
  <li>Parameterized RAM sizing</li>
  <li>Burst transfer support</li>
</ul>

<hr>

<h2>Author</h2>

<p>
Ashish Kumar Kashyap<br>
B.Tech Electronics &amp; Communication Engineering<br>
MNNIT Allahabad
</p>

<hr>

<h2>License</h2>

<p>
This project is released under the MIT License
for educational and learning purposes.
</p>
