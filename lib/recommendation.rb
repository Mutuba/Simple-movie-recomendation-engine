# module Recommendation
#   def self.included(base)
#     base.extend(ClassMethods)
#   end

#   module ClassMethods
#     attr_accessor :associated_model

#     def set_association(model)
#       @associated_model = model
#     end
#   end

#    def movie_recommendations
#      other_users = self.class.where.not(id: self.id)
#      self_movies = self.send(self.class.associated_model).to_set
 
#      movie_recommendations = other_users.reduce(Hash.new(0)) do |acc, user|
#        user_movies = user.send(self.class.associated_model).to_set
#        common_movies = user_movies & self_movies

#       # Calculate similarity scores using Jaccard Index and Dice-Sørensen Coefficient
#       jaccard_index = common_movies.size.to_f / (user_movies | self_movies).size 
#       dice_sorensen_coefficient = (2.0 * common_movies.size) / (user_movies.size + self_movies.size)

#       # Calculate collaborative filtering weight and normalize it accordingly
#       collaborative_weight = common_movies.size.to_f / Math.sqrt(user_movies.size * self_movies.size)

#       # Combine the similarity scores with the collaborative filtering weight
#       weight = (jaccard_index + dice_sorensen_coefficient + collaborative_weight) / 3.0
       
#        (user_movies - common_movies).each do |movie|
#         # Exclude movies that are already liked by the user
#         acc[movie] += weight unless self.movies.include?(movie)
#       end
#        acc
#      end
 
#      sorted_movie_recommendations = movie_recommendations.sort_by { |_, weight| weight }.reverse
#    end
#  end
 

# module Recommender
module Recommendation
  extend ActiveSupport::Concern

  included do
    extend ClassMethods
  end

  AssociationMetadata = Struct.new(:join_table, :foreign_key, :association_foreign_key)

  module ClassMethods
    attr_accessor :association_metadata

    def set_association(association_name)
      reflection = reflect_on_association(association_name.to_sym)
      raise ArgumentError, "Association '#{association_name}' not found" unless reflection
            
      self.association_metadata = build_association_metadata(reflection)
    end

    private

    def build_association_metadata(reflection)
      case reflection
      when ActiveRecord::Reflection::HasAndBelongsToManyReflection
        AssociationMetadata.new(
          reflection.join_table,
          reflection.foreign_key,
          reflection.association_foreign_key
        )
      when ActiveRecord::Reflection::ThroughReflection
        AssociationMetadata.new(
          reflection.through_reflection.table_name,
          reflection.through_reflection.foreign_key,
          reflection.association_foreign_key
        )
      when ActiveRecord::Reflection::HasManyReflection
        AssociationMetadata.new(
          reflection.name.to_s.pluralize,
          reflection.foreign_key,
          nil # Adjust based on your needs
        )
      else
        raise ArgumentError, "Association '#{reflection.name}' is not a supported type"
      end
    end
  end

  def recommendations(results: 10)
    other_instances = self.class.where.not(id: id)
    self_items = send(self.class.association_metadata.join_table).to_set

    item_recommendations = other_instances.reduce(Hash.new(0)) do |acc, instance|
      instance_items = instance.send(self.class.association_metadata.join_table).to_set
      common_items = instance_items & self_items

      # Calculate similarity scores using the Jaccard Index and Dice-Sørensen Coefficient
      jaccard_index = common_items.size.to_f / (instance_items | self_items).size
      dice_sorensen_coefficient = (2.0 * common_items.size) / (instance_items.size + self_items.size)

      # Calculate collaborative filtering weight and normalize it accordingly
      collaborative_weight = common_items.size.to_f / Math.sqrt(instance_items.size * self_items.size)

      # Combine the similarity scores with the collaborative filtering weight
      weight = (jaccard_index + dice_sorensen_coefficient + collaborative_weight) / 3.0

      (instance_items - common_items).each do |item|
        # Exclude items that are already liked by the user
        acc[item] += weight unless self_items.include?(item)
      end
      acc
    end

    sorted_recommendations = item_recommendations.sort_by { |_, weight| weight }.reverse.take(results)
  end
end
# end