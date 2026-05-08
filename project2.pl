%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% project2.pl
% CS4337 Project 2 - Sarah Parratt
%
% This file implements plan/1 for the work schedule project.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plan(plan(Morning, Evening, Night)) :-
    findall(Employee, employee(Employee), Employees),
    schedule_shift(morning, Employees, Morning, EmployeesAfterMorning),
    schedule_shift(evening, EmployeesAfterMorning, Evening, EmployeesAfterEvening),
    schedule_shift(night, EmployeesAfterEvening, Night, []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% schedule_shift(+Shift, +AvailableEmployees, -Schedule, -RemainingEmployees)
%
% Builds the schedule for one shift.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
schedule_shift(Shift, AvailableEmployees, Schedule, RemainingEmployees) :-
    active_workstations(Shift, Workstations),
    schedule_workstations(Shift, Workstations, AvailableEmployees, Schedule, RemainingEmployees).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% active_workstations(+Shift, -Workstations)
%
% Finds all workstations that are not idle during the given shift.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
active_workstations(Shift, Workstations) :-
    findall(station(Station, Min, Max),
            (workstation(Station, Min, Max), \+ is_idle(Station, Shift)),
            Workstations).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% is_idle(+Station, +Shift)
%
% Checks if a workstation is idle during a shift.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
is_idle(Station, Shift) :-
    current_predicate(workstation_idle/2),
    workstation_idle(Station, Shift).