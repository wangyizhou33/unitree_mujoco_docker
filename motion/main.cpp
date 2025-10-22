#include <iostream>
#include "Controller.h"

int main(int argc, char **argv)
{
	Controller controller("lo");
	controller.zero_torque_state();
	controller.move_to_default_pos();
	controller.run();
	controller.damp();
	return 0;
}
