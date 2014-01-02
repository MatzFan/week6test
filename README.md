week6test
=========

This code is a submission for the Makers Academy week 6 test; a simulation of a basic graphical editor.

Getting started
-------------

*graphical_editor* is the executable in the top-level directory.

- On start it lists all commands, including help
- It then prompts for a user command and loops until user wishes to exit
- Invalid commands or command parameters (*all uppercase*) are met with a prompt to try again or consult the help

The final unit test in /spec/editor_spec.rb does a demonstration of several commands to draw 'HELLO !' and then fills the background region. The 'O' in 'HELLO !' remains unfilled, as a demonstration of how fill works - i.e. it does not cross diagonally connected 'pixels' of the same colour.
