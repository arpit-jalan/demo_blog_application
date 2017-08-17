#require 'elasticsearch/model'

class Post < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user, dependent: :destroy

  validates :title, presence: true, length: {minimum: 20}
  validates :body, presence: true, length: {minimum: 20}
  attr_accessible :String, :body, :title, :user_id

  after_save {
  	EsIndexWorker.perform_async(:index, self.id)
  }

  after_destroy {
  	EsIndexWorker.perform_async(:delete, self.id)
  }

  mapping dynamic: 'false' do
  	indexes :title, type: 'string'
  	indexes :body, type: 'string'
  	indexes :users do
  		indexes :name, type: 'string'
  	end
  end

  #index all these columns of models
  def as_indexed_json(options={})
    
    self.as_json(
      only: [:body,:title],
      include: {
      	user: { only: :name}
      }
    )
  end

  #bulk importing
  def self.import_elasticsearch
  	Post.find_in_batches({ :batch_size => 1000 }) { |posts| bulk_index(posts) }
  end

  def self.bulk_index(posts)
  	Post.__elasticsearch__.client.bulk({
       index: ::Post.__elasticsearch__.index_name,
       type: ::Post.__elasticsearch__.document_type,
       body: prepare_records(posts)
   	})
  end

  def self.prepare_records(posts)
  	posts.map do |post|
    	{ index: { _id: post.id, data: post.as_indexed_json } }
   	end
  end

  def self.search query
  	Post.__elasticsearch__.search(
  		query: {
  			multi_match: {
  				analyzer: "keyword",
  				query: query,
  				fields: ["title", "body", "name"]
  			} 
  		}
  	)
  end
end

# importing all together
#Post.import
