# Development Log - Sarah Parratt

## May 8, 2026 - Initial Planning

For this project, I need to implement a Prolog predicate called plan/1. The goal is to generate a work schedule for morning, evening, and night shifts.

The plan needs to make sure every employee works exactly one workstation for exactly one shift. It also needs to follow the workstation minimum and maximum employee limits, avoid idle workstations, avoid restricted workstations, and avoid restricted shifts.

My plan is to first create the basic plan/1 structure, then add helper predicates for shifts and workstations, then test everything using the sample files.



\## May 8, 2026 - Scheduling Implementation



I added the scheduler in smaller parts. First, I added helper predicates for shifts and active workstations. Then I added the recursive logic for scheduling each workstation. After that, I added the worker selection logic and the checks for avoided shifts and avoided workstations.



The main idea I focused on was keeping track of which employees are still available. Once an employee is selected for a workstation, they are removed from the available list. This helps make sure an employee does not get scheduled more than once.



I also added wrapper predicates for workstation\_idle/2, avoid\_workstation/2, and avoid\_shift/2 so the code can still run even if one of those facts is not included in a test file.



\## May 8, 2026 - Simple Testing



I tested the program using a small input file with three employees and one workstation. The program successfully loaded the input file and project2.pl file in SWI-Prolog. When I ran plan(Plan)., it returned a valid plan that assigned one employee to the workstation for each shift. 



This confirmed that the basic plan structure, shift scheduling, and worker selection logic were working on a simple test case.



\## May 8, 2026 - Additional Testing



I tested the project with more input cases. I used one test that included avoided shifts, avoided workstations, idle workstations, and multiple workstations. The program returned a valid plan that followed those restrictions. 



I also tested an impossible case where there were not enough employees to meet a workstation requirement. In that case, plan(Plan). returned false, which is the expected result because no valid schedule could be made.

