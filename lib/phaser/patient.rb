module Phaser
  class Patient < Base

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes.deep_symbolize_keys
    end

    def id
      attributes[:id]
    end

    def name
      attributes[:name]
    end

    def birthday
      @birthday ||= DateTime.parse(attributes[:birthday])
    end

    def display_birthday
      birthday.strftime("%-b %-d, %Y")
    end

    def attempts
      attempt_repo.wrap(attributes[:attempts], self)
    end

    def create_attempt(attributes)
      attempt_repo.create_for(self, attributes)
    end

    def destroy_attempt(id)
      attempt_repo.destroy_for(self, id)
    end

    def move_attempt_to_phase(id, phase_id)
      attempt_repo.move_to_phase(self, id, phase_id)
    end

    private

    def attempt_repo
      @parameter_repo || Phaser::Attempt
    end

  end

  class EmptyPatient < EmptyBase
  end

  class PatientCollection < BaseCollection

    def collected_class
      Phaser::Patient
    end

  end

end