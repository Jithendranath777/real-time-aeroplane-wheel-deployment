# Real-Time Airplane Wheel Deployment using FPGA, Ultrasonic Sensor, and Servo Motor

## Project Overview

This project implements a **real-time airplane wheel deployment system** using an FPGA, ultrasonic sensor, servo motor, and LCD display. The system monitors the distance between the airplane base and the ground and deploys or retracts the landing wheels accordingly. The deployment status is also displayed on an LCD screen.

The project consists of four separate modules:

1. **Ultrasonic Sensor Module**
2. **Servo Motor Module**
3. **LCD Display Module**
4. **FSM Controller Module**
5. **Testbench Module**


---

## Working Principle

1. The **ultrasonic sensor** continuously measures the distance between the airplane base and the ground.
2. The measured distance is sent to the **FPGA/FSM controller**.
3. The FSM processes the data:

   * **Distance < Threshold:**

     * Deploys the wheels (servo rotates to 180°)
     * LCD displays `FLIGHT LANDING`
   * **Distance >= Threshold:**

     * Retracts the wheels (servo rotates back to 0°)
     * LCD displays `FLIGHT TAKEOFF`
4. An LED indicator mirrors the wheel deployment status.

---

## Modules Description

### 1. Ultrasonic Sensor Module

* Measures distance between airplane and ground.
* Provides `echo` signal back to FPGA.
* Outputs `distance_raw` data.

### 2. Servo Motor Module

* Controls deployment and retraction of wheels.
* Receives `angle_sel` signal from FSM.
* Rotates servo motor to **0°** (retracted) or **180°** (deployed).

### 3. LCD Display Module

* Shows the flight status: `FLIGHT LANDING` or `FLIGHT TAKEOFF`.
* Receives processed data from FSM (`state`) to determine message.
* Uses 8-bit data bus and control signals `lcd_e` and `lcd_rs`.

### 4. FSM Controller Module

* Central processing unit for wheel deployment logic.
* Receives `distance_raw` from ultrasonic sensor.
* Sets `angle_sel` for servo motor based on threshold distance.
* Controls LCD message and LED indicator.
* Integrates all other modules for complete system operation.

### 5. Testbench Module

* Used for simulating and validating system functionality.
* Provides clock and reset signals.
* Monitors outputs like servo position, LED, and LCD data.

---

## Inputs and Outputs

| Signal      | Width | Description                  |
| ----------- | ----- | ---------------------------- |
| `clk`       | 1-bit | System clock                 |
| `rst`       | 1-bit | System reset                 |
| `echo`      | 1-bit | From ultrasonic sensor       |
| `trig`      | 1-bit | To ultrasonic sensor         |
| `servo_out` | 1-bit | Servo motor control output   |
| `LED`       | 1-bit | LED indicator for deployment |
| `data`      | 8-bit | LCD data bus                 |
| `lcd_e`     | 1-bit | LCD enable signal            |
| `lcd_rs`    | 1-bit | LCD register select          |

---

## Simulation and Usage

1. Instantiate the `fsm_controller` module in your Verilog testbench.
2. Apply clock (`clk`) and reset (`rst`) signals.
3. Provide input `echo` from the ultrasonic sensor module.
4. Monitor the outputs:

   * `servo_out` for wheel position
   * `LED` for deployment status
   * `data`, `lcd_e`, `lcd_rs` for LCD message
5. Observe the real-time deployment/retraction based on distance thresholds.

---

## Future Enhancements

* Add multi-level deployment for different distances.
* Integrate with a real aircraft simulation environment.
* Add buzzer or warning system for deployment status.
* Improve servo control for smoother deployment.

---

## Author

**Angam Jithendranath**

* Email: [jithendranathangam@gmail.com](mailto:jithendranathangam@gmail.com)
* Contact: +91-9908476598
* GitHub: [https://github.com/Jithendranath777](https://github.com/Jithendranath777)
* LinkedIn: [https://www.linkedin.com/in/angam-jithendranath](https://www.linkedin.com/in/angam-jithendranath)
