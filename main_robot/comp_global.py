import math
import com_esp

def comand_steper(instruction : str, amplitude : int):
    instructions = {
        "forward" : ('f', 'f'),
        "backward" : ('b', 'b'),
        "right forward" : ('f', 'n'),
        "left forward" : ('n', 'f'),
        "right" : ('f', 'b'),
        "left" : ('b','f'),
        "right backward" : ('n', 'b'),
        "left backward" : ('b', 'n')
    }
    
    translated_instr = instructions[instruction]
    msg = f"s {translated_instr[0]} {translated_instr[1]} {amplitude}"

    com_esp.send_text(msg)


class Robot:
    # origine à l'opposé de la zone de départ jaune
    # regardant le mur côté grenier
    default_blue_position = (0., 0.) # en cm
    default_yellow_position = (0., 0.) # en cm
    default_theta = - math.pi / 2
    tire_radius = 10
    nb_step = 200
    nb_micro_step = 8 * nb_step
    delta_l = 2*math.pi*tire_radius / nb_micro_step

    def __init__(self):
        self.theta = Robot.default_theta
        self.set_team()
        if self.team == "blue":
            self.position = Robot.default_blue_position
        else:
            self.position = Robot.default_yellow_position

    def update_pos(self):
        pass

    def set_team(self):
        # TODO : vraie fct
        self.team = "blue"

    def go_to(self, pos : tuple, rot : float):
        # TODO :
        #    - trouver le chemin
        #    - avanver petit à petit avec retro-action

        pass
    
    def take_nuts(self):
        pass
    
    def release(self):
        pass


if __name__ == "__main__":
    com_esp.init()
    robot = Robot()
    com_esp.close()

