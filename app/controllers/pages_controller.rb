# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home; end

  def voter_home; end

  def verification 
  end
end
