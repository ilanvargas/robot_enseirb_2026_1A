import math

def comand_steper(instruction : str, amplitude : int):
  """
  examples :
  """
  instructions = {
    "forward" : (1, 1),
    "backward" : (2, 2),
    "right forward" : (1, 0),
    "left forward" : (0, 1),
    "right" : (1, 2),
    "left" : (2,1),
    "right backward" : (0, 2),
    "left backward" : (2, 0)
  }
  # TODO : transmettre la commande au stepper

  pass


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
    #  - trouver le chemin
    #  - avanver petit à petit avec retro-action

    pass
  
  def take_nuts(self):
    pass
  
  def release(self):
    pass


if __name__ == "__main__":
  robot = Robot()

