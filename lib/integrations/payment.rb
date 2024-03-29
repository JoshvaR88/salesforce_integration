module Integration
  class Payment < Base

    attr_reader :object

    def initialize(config, object)
      @object = object.with_indifferent_access
      super(config)
    end

    def upsert!(payment)
      payment_service.upsert!(payment_params(payment), order_id, email)
    end

    def import!
      look_up('payments').each { |p| upsert!(p) }
    end

    def order_id
      look_up('id')
    end

    def email
      look_up('email')
    end

    def look_up(what)
      object[what]
    end

    def payment_params(payment)
      Integration::Builder::Payment.new(payment).build
    end

  end
end
