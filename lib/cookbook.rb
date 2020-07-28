require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    csv_load
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    csv_update
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    csv_update
  end

  def mark_recipe(recipe_index)
    @recipes[recipe_index].mark_as_done!
    csv_update
  end

  private

  def csv_load
    CSV.foreach(@csv_file_path) { |row| @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4].to_i) }
  end

  def csv_update
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each { |item| csv << [item.name, item.description, item.prep_time, item.skill_level, item.done] }
    end
  end
end
