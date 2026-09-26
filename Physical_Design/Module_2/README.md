# Module 2 – Good floorplan vs bad floorplan and introduction to library cells

## Overview

This module focuses on the fundamentals of physical design with emphasis on floorplanning, die and core dimensions, utilization, aspect ratio, placement, and layout organization.

Floorplanning is an important stage in the ASIC physical design flow because it determines the physical organization of the design before standard-cell placement and routing.

---

## Topics Covered

### 1. Floorplanning

Floorplanning is the process of defining the physical structure and arrangement of a chip before detailed placement and routing.

The major objectives of floorplanning are:

- Define the die and core area
- Determine the core dimensions
- Place macros and pre-placed cells
- Provide sufficient space for standard-cell placement
- Consider routing and congestion
- Plan the power distribution
- Achieve suitable area utilization

---

### 2. Die and Core Dimensions

The physical design is divided into the die area and the core area.

- **Die:** The complete physical area of the chip.
- **Core:** The area inside the die where the standard cells and other design elements are placed.
- **Die Height and Width:** Define the overall chip dimensions.
- **Core Height and Width:** Define the usable area available for the core logic.

The dimensions must be selected carefully to provide sufficient area for the design and its physical implementation.

---

### 3. Utilization Factor

The utilization factor represents the percentage of the core area occupied by the standard cells.

It can be expressed as:

**Utilization = (Area occupied by cells / Total core area) × 100**

A suitable utilization factor is required to provide enough space for placement, routing, and other physical-design requirements.

---

### 4. Aspect Ratio

The aspect ratio describes the relationship between the height and width of the core.

**Aspect Ratio = Height / Width**

An aspect ratio close to the required design target helps determine the shape of the core during floorplanning.

---

### 5. Pre-Placed Cells

Some cells or blocks may need to be placed at specific locations before standard-cell placement.

These are referred to as pre-placed cells or fixed cells.

Examples include:

- Macros
- Memory blocks
- IP blocks
- I/O-related structures

Their positions can affect routing, congestion, timing, and the overall floorplan.

---

### 6. Floorplanning Considerations

Important factors considered during floorplanning include:

- Core utilization
- Aspect ratio
- Macro placement
- I/O placement
- Routing resources
- Congestion
- Timing
- Power distribution
- Available area

A suitable floorplan provides sufficient space for later stages of physical implementation.

---

### 7. Power Planning

Power planning establishes the power and ground distribution required by the design.

The power network should provide reliable power delivery to the cells while minimizing voltage drop and ensuring proper connectivity.

Power planning may include:

- Power rings
- Power rails
- Power straps
- VDD and VSS distribution

---

### 8. Placement

Placement determines the physical locations of standard cells within the core area.

The placement process aims to:

- Place cells within the available core area
- Minimize unnecessary wirelength
- Reduce congestion
- Support timing requirements
- Maintain appropriate utilization

Placement is performed after floorplanning and before Clock Tree Synthesis and routing.

---

## Practical Work

The following screenshots document the practical physical-design work carried out during this module.

### 1. Floorplanning Close View

The floorplanning result and physical organization of the design are shown below.

![Floorplanning Close View](fp_close.png)

---

### 2. Physical Layout

The resulting physical layout of the design is shown below.

![Physical Layout](layout.png)

---

### 3. PicoRV32 Floorplanning

The floorplanning stage for the PicoRV32 design is shown below.

![PicoRV32 Floorplanning](picorv32a_floorplanning.png)

---

### 4. PicoRV32 Placement

The placement stage for the PicoRV32 design is shown below.

![PicoRV32 Placement](picorv32a_placement.png)

---

# Key Learning Outcomes

After completing this module, I gained an understanding of:

- Floorplanning concepts
- Die and core dimensions
- Core utilization
- Aspect ratio
- Pre-placed cells
- Macro placement
- Power planning
- Physical layout organization
- Standard-cell placement
- Placement-related considerations
- Practical floorplanning and placement of the PicoRV32 design

---

## Conclusion

Module 2 provided a practical understanding of floorplanning and placement in ASIC physical design. The concepts learned in this module form the foundation for subsequent stages such as Clock Tree Synthesis, routing, timing analysis, and physical verification.
