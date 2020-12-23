# 

class Ingredients
  ENTRY_REGEX = /(.*) \(contains (.*)\)/

  def initialize (file_name)
    @allergens = {}
    @ingredients = {}
    @ingredient_lists_by_allergen = Hash.new { |h,k| h[k] = [] }
    @ingredients_to_allergens = {}

    File.open(file_name) do |f|
      @ingredient_lists = f.readlines.map do |line|
        m = ENTRY_REGEX.match line
        ings = m.captures.first.split(' ').sort
        alrgs = m.captures.last.split(', ').sort
        alrgs.each do |a|
          @ingredient_lists_by_allergen[a] << Set.new(ings)
        end
        [ings, alrgs]
      end
    end

  end

  def overlaps
    workspace = {}
    @ingredient_lists_by_allergen.each do |allr, alg_sets|
      workspace[allr] = Set.new alg_sets.reduce(&:&)
    end
    while true
      puts "workspace:"
      pp workspace

      workspace.each do |allr, set|
        if set.empty?
          workspace.delete(allr)
        end
        if set.length == 1
          ingredient = set.to_a.first
          workspace.each_value {|s| s.delete_if {|a| a == ingredient } }
          @ingredients_to_allergens[allr] = ingredient
        end
      end
      break if workspace.empty?
    end

    puts "workspace:"
    pp workspace
    puts "@ingredients_to_allergens"
    pp @ingredients_to_allergens
  end

  def part1
    overlaps
    allergen_ingredients = @ingredients_to_allergens.values
    @ingredient_lists.map do |ings, algs|
      ings.reject {|ing| allergen_ingredients.include? ing }
    end.flatten.count
  end
end