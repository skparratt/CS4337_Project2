# Development Log - Sarah Parratt

## May 8, 2026 - Initial Planning

For this project, I need to implement a Prolog predicate called plan/1. The goal is to generate a work schedule for morning, evening, and night shifts.

The plan needs to make sure every employee works exactly one workstation for exactly one shift. It also needs to follow the workstation minimum and maximum employee limits, avoid idle workstations, avoid restricted workstations, and avoid restricted shifts.

My plan is to first create the basic plan/1 structure, then add helper predicates for shifts and workstations, then test everything using the sample files.



\## May 8, 2026 - Scheduling Implementation



I added the scheduler in smaller parts. First, I added helper predicates for shifts and active workstations. Then I added the recursive logic for scheduling each workstation. After that, I added the worker selection logic and the checks for avoided shifts and avoided workstations.



The main idea I focused on was keeping track of which employees are still available. Once an employee is selected for a workstation, they are removed from the available list. This helps make sure an employee does not get scheduled more than once.



I also added wrapper predicates for workstation\_idle/2, avoid\_workstation/2, and avoid\_shift/2 so the code can still run even if one of those facts is not included in a test file.

