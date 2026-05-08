%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% project2.pl
% CS4337 Project 2 - Sarah Parratt
%
% This file implements plan/1 for the work schedule project.
% It assumes an input fact file has already been consulted, containing facts for:
% employee/1, workstation/3, workstation_idle/2, avoid_workstation/2, avoid_shift/2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plan(-Plan)
%
% Plan is unified with plan(Morning, Evening, Night), where each shift schedule is
% a list of workstation(Station, Workers) terms.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plan(plan(Morning, Evening, Night)) :-
    findall(Employee, employee(Employee), Employees),
    schedule_shift(morning, Employees, Morning, EmployeesAfterMorning),
    schedule_shift(evening, EmployeesAfterMorning, Evening, EmployeesAfterEvening),
    schedule_shift(night, EmployeesAfterEvening, Night, []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% schedule_shift(+Shift, +AvailableEmployees, -Schedule, -RemainingEmployees)
%
% Builds the schedule for one shift. Only non-idle workstations are included.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
schedule_shift(Shift, AvailableEmployees, Schedule, RemainingEmployees) :-
    active_workstations(Shift, Workstations),
    schedule_workstations(Shift, Workstations, AvailableEmployees, Schedule, RemainingEmployees).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% active_workstations(+Shift, -Workstations)
%
% Creates a list of station(Station, Min, Max) terms for workstations that are not
% idle during Shift.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
active_workstations(Shift, Workstations) :-
    findall(station(Station, Min, Max),
            (workstation(Station, Min, Max), \+ is_idle(Station, Shift)),
            Workstations).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% schedule_workstations(+Shift, +Workstations, +Available, -Schedule, -Remaining)
%
% Assigns employees to each workstation for a shift.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
schedule_workstations(_, [], Employees, [], Employees).
schedule_workstations(Shift,
                      [station(Station, Min, Max)|RestStations],
                      AvailableEmployees,
                      [workstation(Station, Workers)|RestSchedule],
                      RemainingEmployees) :-
    Min =< Max,
    between(Min, Max, NumberOfWorkers),
    select_workers(NumberOfWorkers,
                   Shift,
                   Station,
                   AvailableEmployees,
                   Workers,
                   EmployeesAfterStation),
    schedule_workstations(Shift,
                          RestStations,
                          EmployeesAfterStation,
                          RestSchedule,
                          RemainingEmployees).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% select_workers(+N, +Shift, +Station, +Available, -Selected, -Remaining)
%
% Selects N eligible workers from Available while preserving the original order.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
select_workers(0, _, _, Employees, [], Employees).
select_workers(N,
               Shift,
               Station,
               [Employee|RestAvailable],
               [Employee|SelectedRest],
               RemainingEmployees) :-
    N > 0,
    can_work(Employee, Shift, Station),
    N1 is N - 1,
    select_workers(N1,
                   Shift,
                   Station,
                   RestAvailable,
                   SelectedRest,
                   RemainingEmployees).
select_workers(N,
               Shift,
               Station,
               [Employee|RestAvailable],
               SelectedEmployees,
               [Employee|RemainingRest]) :-
    N > 0,
    select_workers(N,
                   Shift,
                   Station,
                   RestAvailable,
                   SelectedEmployees,
                   RemainingRest).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% can_work(+Employee, +Shift, +Station)
%
% True when the employee is allowed to work that station during that shift.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
can_work(Employee, Shift, Station) :-
    \+ avoids_shift(Employee, Shift),
    \+ avoids_workstation(Employee, Station).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wrapper predicates.
%
% These prevent SWI-Prolog from throwing an error if a test file does not define
% workstation_idle/2, avoid_workstation/2, or avoid_shift/2.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
is_idle(Station, Shift) :-
    current_predicate(workstation_idle/2),
    workstation_idle(Station, Shift).

avoids_workstation(Employee, Station) :-
    current_predicate(avoid_workstation/2),
    avoid_workstation(Employee, Station).

avoids_shift(Employee, Shift) :-
    current_predicate(avoid_shift/2),
    avoid_shift(Employee, Shift).