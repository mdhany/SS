class Payment < ActiveRecord::Base
  belongs_to :turn
  belongs_to :level
  belongs_to :login
  belongs_to :beneficiary, class_name: 'Login', foreign_key: 'beneficiary_id'

  validates :amount,:gateway, presence: true

  scope :pendientes, -> { where(sent: false, received: false ) }
  scope :enviados, -> { where(sent: true, received: false) }


  #Busca los pagos apartados que aun no han sido enviados
  # y si tienen más de 4horas los borra
  def self.destroy_payments_inactive
    self.pendientes.each do |pa|
      tp = pa.updated_at + 1.hour
      if Time.now > tp
        if self.delete(pa)
          logger.info "CRON: Borrando Payments inactivos #{pa}"
          c = view_context.what_level(pa.level_id, pa.login)
          c.update_attribute :status, "inactive"
        end
      end
    end
  end

  def self.confirming_payment_automatic
    self.enviados.each do |c|
      p = c.updated_at + 4.hours
      if Time.now > p
        if c.update_attribute :received, true
          u = view_context.what_level(c.level_id, c.login)
          u.update_attribute :status, 'pagado'

          logger.info "CRON: Confirmando Pago Enviado #{p}"
        end
      end
    end


  end

end
