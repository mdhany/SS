module ApplicationHelper
  def completed_turn?(turn)
    t = turn.payments.where sent: true, received: true
    t.size == 5
  end

  def how_many_turns(status)
    @t_total = Turn.where login_id: current_login.id, status: status
    @t_total.size
  end

  def have_turn?
    t = Turn.where login_id: current_login.id, status: ['waiting', 'active', 'confirmation']
    if t == 0
      l = current_login
      l.update_attribute :status, 'inactive'
    end
  end

  def payments_recently
    l = current_login
    r = l.payments.where sent: true, received: false
    r.size
  end

  #Si tiene la capacidad en INACTIVO y no tiene turno
  def have_capacity?(level)
    t = Turn.where login_id: current_login.id, level_id: level, status: ['waiting', 'active', 'confirmation']
    l = Login.find current_login.id

    if  level == 1
        c = l.capacities.first
    elsif level == 2
        c = l.capacities.second
    else
        c = l.capacities.last
    end

    #Si es admin, puede crear más de 1 turno
    if c.capacity > 1
      t.size < c.capacity || c.status == 'inactive'
    else
      t.size < c.capacity && c.status == 'inactive'
    end
  end

  def what_level(level, object)
    case level
      when 1
        l = object.capacities.first
      when 2
        l = object.capacities.second
      when 3
        l = object.capacities.last
    end
  end


end
