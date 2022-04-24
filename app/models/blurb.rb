class Blurb < ApplicationRecord
  # permit_params :id, :title, :text, :planet_replacements  # Doesn't work... https://stackoverflow.com/questions/47790066/how-to-locate-unpermitted-params-id-in-active-admin
  validates :title, presence: true, length: { minimum: 6, maximum: 80 }
  validates :text, presence: true, length: { minimum: 10, maximum: 2000 }
  validates :planet_replacements, presence: true, length: { minimum: 24, maximum: 4000 }
end 