# frozen_string_literal: true

class ApplicationVersion < ApplicationRecord
  include PaperTrail::VersionConcern
end
