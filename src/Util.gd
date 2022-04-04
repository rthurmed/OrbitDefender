extends Node


func timer_percent(timer: Timer):
	return (timer.wait_time - timer.time_left) / timer.wait_time
