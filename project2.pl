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