# Development Log - Sarah Parratt

## May 8, 2026 - Initial Planning

For this project, I need to implement a Prolog predicate called plan/1. The goal is to generate a work schedule for morning, evening, and night shifts.

The plan needs to make sure every employee works exactly one workstation for exactly one shift. It also needs to follow the workstation minimum and maximum employee limits, avoid idle workstations, avoid restricted workstations, and avoid restricted shifts.

My plan is to first create the basic plan/1 structure, then add helper predicates for shifts and workstations, then test everything using the sample files.