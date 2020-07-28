class Recipe
  attr_reader :name, :description, :prep_time, :skill_level, :done

  def initialize(name, description, prep_time, skill_level, done = 0)
    @name = name
    @description = description
    @prep_time = prep_time
    @skill_level = skill_level
    @done = done
  end

  def done?
    !@done.to_i.zero?
  end

  def mark_as_done!
    @done.to_i.zero? ? @done = 1 : @done = 0
  end
end
