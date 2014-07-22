module LoginsHelper
  #si el turno del level llamado, es igual al estatus
  def turn_incomplete(level, status)
    l = Login.find current_login.id
    c = l.capacities
    #Si el status de la capacidad no esta active es porque no tiene turno y por lo tanto no ha sido completado
    if level == 1
      c.first.status == status
    elsif level == 2
      c.second.status == status
    else
      c.last.status == status
    end
  end

end
