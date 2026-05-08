employee(alice).
employee(bob).
employee(charlie).

workstation(register, 1, 1).

workstation_idle(_, _) :- fail.
avoid_workstation(_, _) :- fail.
avoid_shift(_, _) :- fail.