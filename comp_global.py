import math
import 

class Robot:
 # origine à l'opposé de la zone de départ jaune
 # regardant le mur côté grenier
  default_blue_position = (0., 0.) # en cm
  default_yellow_position = (0., 0.) # en cm
  default_theta = - math.pi / 2

  def __init__(self):
    self.mouvement_queue = []
    self.theta = default_theta
    self.set_team()
    if self.team == "blue":
      self.position = default_blue_position
    else:
      self.position = default_yellow_position

  def update_pos(self):
    pass

  def set_team(self):
    pass


if __name__ == "__main__":
  robot = Robot()

